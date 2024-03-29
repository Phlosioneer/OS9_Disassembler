#pragma once

#include "size.h"
#include "range.h"
#include "address_space.h"
#include "registers.h"
#include "references.h"

class InstrParam;

inline AddressRange rangeFromSize(uint32_t offset, OperandSize size)
{
    return rangeFromLength(offset, OperandSizes::getByteCount(size));
}

struct ExtensionWord
{
    bool isValid = false;
    uint8_t scale = 0;
    Register indexReg = Register::A0;
    // Note: Can only be Word or Long.
    OperandSize indexRegSize = OperandSize::Word;
    // Note: Always signed.
    int8_t displacement = 0;

    ExtensionWord(uint16_t word);
};

class RawParam
{
  public:
    virtual ~RawParam() = default;

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                bool suppressAbsoluteAddressLabels,
                                                bool suppressHashTagForImmediates) = 0;
};

class RawLiteralParam : public RawParam
{
  public:
    RawLiteralParam(uint32_t rawValue, OperandSize size, uint32_t address);
    virtual ~RawLiteralParam() = default;

    uint32_t rawValue;
    OperandSize size;
    uint32_t address;

    inline AddressRange range()
    {
        return rangeFromSize(address, size);
    }

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                bool suppressAbsoluteAddressLabels, bool suppressHashTagForImmediates);

    inline int32_t signedValue() const
    {
        return OperandSizes::truncateSigned(size, rawValue);
    }

    const std::vector<RelocatedReference>* findRefs(AddrSpaceHandle space) const;
};

class RawRelativeParam : public RawLiteralParam
{
  public:
    RawRelativeParam(uint32_t rawValue, OperandSize size, uint32_t address, uint32_t relativeToAddress);
    RawRelativeParam(const RawLiteralParam& rawLiteral, uint32_t relativeToAddress);

    uint32_t relativeToAddress;

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                bool suppressAbsoluteAddressLabels, bool suppressHashTagForImmediates);
};

class RawEquateParam : public RawLiteralParam
{
  public:
    RawEquateParam(uint32_t rawValue, OperandSize size, uint32_t address, const char* name);
    RawEquateParam(const RawLiteralParam& rawLiteral, const char* name);

    std::string name;

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                bool suppressAbsoluteAddressLabels, bool suppressHashTagForImmediates);
};

class RawAbsoluteAddrParam : public RawParam
{
  public:
    RawAbsoluteAddrParam(uint32_t value, uint32_t address, OperandSize size);
    virtual ~RawAbsoluteAddrParam() = default;

    uint32_t value;
    uint32_t address;
    OperandSize size;

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                bool suppressAbsoluteAddressLabels, bool suppressHashTagForImmediates);
};

class RawRegOffsetParam : public RawParam
{
  public:
    RawRegOffsetParam(Register baseReg, int16_t displacement, uint32_t address, OperandSize size);
    virtual ~RawRegOffsetParam() = default;

    Register baseReg;
    int16_t displacement;
    uint32_t address;
    OperandSize size;

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                bool suppressAbsoluteAddressLabels, bool suppressHashTagForImmediates);
};

class RawIndexParam : public RawParam
{
  public:
    RawIndexParam(Register baseReg, const ExtensionWord& extension, uint32_t displacementAddress);
    virtual ~RawIndexParam() = default;

    Register baseReg;
    Register indexReg;
    int8_t displacement;
    OperandSize size;
    uint32_t displacementAddress;

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                bool suppressAbsoluteAddressLabels, bool suppressHashTagForImmediates);
};