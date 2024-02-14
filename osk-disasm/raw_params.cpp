
#include "pch.h"

#include "raw_params.h"
#include "params.h"
#include "rof.h"

ExtensionWord::ExtensionWord(uint16_t word)
{
    isValid = (word & 0x0100) != 0;
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

std::unique_ptr<InstrParam> RawLiteralParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode, AddrSpaceHandle literalSpaceHint)
{
    std::string dispstr;
    if (rof_setup_ref(dispstr, &CODE_SPACE, address, rawValue, Pass, size, forceRelativeImmediateMode))
    {
        dispstr = "#" + dispstr;
        return std::make_unique<LiteralParam>(dispstr);
    }
    else if (LblCalc(dispstr, rawValue, AM_IMM, address, isRof, Pass, size))
    {
        return std::make_unique<LiteralParam>(dispstr);
    }
    else
    {
        auto number = MakeFormattedNumber(signedValue(), AM_IMM, size, literalSpaceHint);
        return std::make_unique<LiteralParam>(number);
    }
}

RawRegParam::RawRegParam(Register reg, RegParamMode mode) : RawParam(), reg(reg), mode(mode)
{
}

std::unique_ptr<InstrParam> RawRegParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                 AddrSpaceHandle literalSpaceHint)
{
    return std::make_unique<RegParam>(reg, mode);
}

RawAbsoluteAddrParam::RawAbsoluteAddrParam(uint32_t value, uint32_t address, OperandSize size)
    : RawParam(), value(value), address(address), size(size)
{
}

std::unique_ptr<InstrParam> RawAbsoluteAddrParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                 AddrSpaceHandle literalSpaceHint)
{
    throw std::exception();
}

RawRegOffsetParam::RawRegOffsetParam(Register baseReg, uint16_t displacement, uint32_t address, OperandSize size)
    : RawParam(), baseReg(baseReg), displacement(displacement), address(address), size(size)
{
}

std::unique_ptr<InstrParam> RawRegOffsetParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                 AddrSpaceHandle literalSpaceHint)
{
    throw std::exception();
}

RawIndexParam::RawIndexParam(Register baseReg, const ExtensionWord& extension, uint32_t displacementAddress)
    : RawParam(), baseReg(baseReg), indexReg(extension.indexReg), displacement(extension.displacement), size(extension.indexRegSize)
{
}

std::unique_ptr<InstrParam> RawIndexParam::hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                 AddrSpaceHandle literalSpaceHint)
{
    throw std::exception();
}