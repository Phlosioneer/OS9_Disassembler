#pragma once

#include "size.h"
#include "range.h"
#include "address_space.h"
#include "registers.h"

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
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType) = 0;
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
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType);

    inline int32_t signedValue() const
    {
        return OperandSizes::truncateSigned(size, rawValue);
    }
};

class RawRegParam : public RawParam
{
  public:
    RawRegParam(Register reg, RegParamMode mode);
    virtual ~RawRegParam() = default;

    Register reg;
    RegParamMode mode;

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType);
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
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType);
};

class RawRegOffsetParam : public RawParam
{
  public:
    RawRegOffsetParam(Register baseReg, uint16_t displacement, uint32_t address, OperandSize size);
    virtual ~RawRegOffsetParam() = default;

    Register baseReg;
    uint16_t displacement;
    uint32_t address;
    OperandSize size;

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType);
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
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType);
};