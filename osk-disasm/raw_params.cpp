
#include "pch.h"

#include "raw_params.h"
#include "params.h"
#include "rof.h"
#include "modtypes.h"

ExtensionWord::ExtensionWord(uint16_t word)
{
    isValid = (word & 0x0100) == 0;
    bool isLong = (word & 0x0800) != 0;
    indexRegSize = isLong ? OperandSize::Long : OperandSize::Word;
    scale = (word >> 9) & 0b11;
    uint8_t regNumber = (word >> 12) & 0b111;
    bool isAddressRegister = (word & 0x8000) != 0;
    if (isAddressRegister)
    {
        indexReg = Registers::makeAReg(regNumber);
    }
    else
    {
        indexReg = Registers::makeDReg(regNumber);
    }
    displacement = static_cast<int8_t>(word);
}

RawLiteralParam::RawLiteralParam(uint32_t rawValue, OperandSize size, uint32_t address)
    : RawParam(), rawValue(rawValue), size(size), address(address)
{
}

std::unique_ptr<InstrParam> RawLiteralParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                     AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                     bool suppressAbsoluteAddressLabels)
{
    std::string dispstr;
    // TODO: When exactly is '#' needed?
    if (rof_setup_ref(dispstr, &CODE_SPACE, address, rawValue, Pass, size, forceRelativeImmediateMode))
    {
        return std::make_unique<LiteralParam>(dispstr, true);
    }
    else if (LblCalc(dispstr, rawValue, AM_IMM, address, isRof, Pass, size))
    {
        return std::make_unique<LiteralParam>(dispstr, true);
    }
    else
    {
        auto number = MakeFormattedNumber(signedValue(), AM_IMM, size, literalSpaceHint);
        return std::make_unique<LiteralParam>(number, true);
    }
}

RawRelativeParam::RawRelativeParam(uint32_t rawValue, OperandSize size, uint32_t address, uint32_t relativeToAddress)
    : RawLiteralParam(rawValue, size, address), relativeToAddress(relativeToAddress)
{
}

RawRelativeParam::RawRelativeParam(const RawLiteralParam& rawLiteral, uint32_t relativeToAddress)
    : RawLiteralParam(rawLiteral), relativeToAddress(relativeToAddress)
{
}

std::unique_ptr<InstrParam> RawRelativeParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                      AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                      bool suppressAbsoluteAddressLabels)
{
    std::string dispstr;
    if (rof_setup_ref(dispstr, &CODE_SPACE, address, signedValue(), Pass, size, forceRelativeImmediateMode))
    {
        return std::make_unique<LiteralParam>(dispstr, false);
    }
    else if (LblCalc(dispstr, signedValue(), AM_REL, relativeToAddress, isRof, Pass, size))
    {
        return std::make_unique<LiteralParam>(dispstr, false);
    }
    else
    {
        return std::make_unique<LiteralParam>(FormattedNumber(signedValue(), size, literalSpaceHint));
    }
}

RawAbsoluteAddrParam::RawAbsoluteAddrParam(uint32_t value, uint32_t address, OperandSize size)
    : RawParam(), value(value), address(address), size(size)
{
}

std::unique_ptr<InstrParam> RawAbsoluteAddrParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                          AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                          bool suppressAbsoluteAddressLabels)
{
    auto addressMode = suppressAbsoluteAddressLabels ? AM_NO_LABELS : AM_ABSOLUTE;

    std::string displayString;
    if (LblCalc(displayString, value, addressMode, address, isRof, Pass, size))
    {
        return std::make_unique<AbsoluteAddrParam>(displayString, size);
    }
    else
    {
        // Absolute Address values are sign extended. Weird, but designed for PEA (ab)use.
        auto number = FormattedNumber(OperandSizes::truncateSigned(size, value), size, literalSpaceHint);
        return std::make_unique<AbsoluteAddrParam>(number, size);
    }
}

RawRegOffsetParam::RawRegOffsetParam(Register baseReg, int16_t displacement, uint32_t address, OperandSize size)
    : RawParam(), baseReg(baseReg), displacement(displacement), address(address), size(size)
{
}

std::unique_ptr<InstrParam> RawRegOffsetParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                       AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                       bool suppressAbsoluteAddressLabels)
{
    // The system biases the data pointer (A6) by 0x8000 bytes in programs, to maximize
    // addressable memory from a signed word offset. So a real data variable may be at
    // offset 0x1000010, but A6 is pointing at 0x108000, so the signed displacement is
    // 0x8010 or -32,752.
    //
    // This code undoes that bias before computing any labels. The assembler automatically
    // biases A6 displacements even when they're constants, so it's correct to do this
    // even if it doesn't correspond to a label.
    uint32_t actualOffset = displacement;
    if (baseReg == Register::A6 && !isRof && moduleType == MT_Program)
    {
        actualOffset = static_cast<uint16_t>(static_cast<uint16_t>(displacement) + 0x8000);
    }
    int32_t signedActualOffset = static_cast<int32_t>(static_cast<int16_t>(displacement));

    const int addressMode = baseReg == Register::PC ? AM_REL : AM_A0 + Registers::getIndex(baseReg);

    std::string displayString;
    std::unique_ptr<RegOffsetParam> ret;
    // TODO: Should labels use sign-extended displacements?
    if (LblCalc(displayString, actualOffset, addressMode, address, isRof, Pass, size))
    {
        ret = std::make_unique<RegOffsetParam>(baseReg, displayString);
    }
    else
    {
        auto number = MakeFormattedNumber(signedActualOffset, addressMode, size);
        ret = std::make_unique<RegOffsetParam>(baseReg, number);
    }

    // `0(An)` and `(An)` assemble to different instructions, so omitting the zero isn't
    // an option here. It is required for correct disassembly. For why false is the default,
    // see RawIndexParam::hydrate.
    ((RegOffsetParam*)ret.get())->setShouldForceZero(true);

    return ret;
}

RawIndexParam::RawIndexParam(Register baseReg, const ExtensionWord& extension, uint32_t displacementAddress)
    : RawParam(), baseReg(baseReg), indexReg(extension.indexReg), displacement(extension.displacement),
      size(extension.indexRegSize), displacementAddress(displacementAddress)
{
}

std::unique_ptr<InstrParam> RawIndexParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                   AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                   bool suppressAbsoluteAddressLabels)
{
    if (displacement == 0)
    {
        // Avoid making labels if the value is 0, but still check for external refs.
        std::string displayString;
        if (isRof && IsRef(displayString, displacementAddress, displacement, Pass, OperandSize::Byte, true))
        {
            // This is just a `(An,Dn)` style directive. The `0` at the front is optional, so
            // RegOffsetParam will ignore it by default.
            return std::make_unique<RegOffsetParam>(baseReg, indexReg, size, displayString);
        }
        else
        {
            // This is just a `(An,Dn)` style directive. The `0` at the front is optional, so
            // RegOffsetParam will ignore it by default.
            return std::make_unique<RegOffsetParam>(baseReg, indexReg, size, FormattedNumber(0));
        }
    }
    else
    {
        int addressMode = baseReg == Register::PC ? AM_REL : AM_A0 + Registers::getIndex(baseReg);
        // TODO: This is wrong. The old code used `PC-2`, but that would be the high byte of the
        // extension word. The displacement is in the low byte.
        auto offByOneAddress = displacementAddress - 1;
        std::string displayString;
        // Note: The size here is the size of the displacement literal, not the size of the memory access.
        if (LblCalc(displayString, displacement, addressMode, offByOneAddress, isRof, Pass, OperandSize::Byte))
        {
            return std::make_unique<RegOffsetParam>(baseReg, indexReg, size, displayString);
        }
        else
        {
            auto number = MakeFormattedNumber(displacement, addressMode, size);
            return std::make_unique<RegOffsetParam>(baseReg, indexReg, size, number);
        }
    }
}