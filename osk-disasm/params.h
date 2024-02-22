
#ifndef PARAMS_H
#define PARAMS_H

#include "pch.h"

#include <bitset>

#include "address_space_handle.h"
#include "either.h"
#include "disglobs.h"
#include "size.h"
#include "registers.h"
#include "raw_params.h"

class Label;
extern const AddressSpace LITERAL_DEC_SPACE;


enum EffectiveAddressMode
{
    DirectDataReg, // Dn
    DirectAddrReg, // An
    Indirect,      // (An)
    PostIncrement, // (An)+
    PreDecrement,  // -(An)
    Displacement,  // d16(An)
    Index,         // d8(An,An) or d8(An,Dn)
    Special        // One of the SpecialAddressMode options
};

enum SpecialAddressMode
{
    AbsoluteWord,   // (xxx).W
    AbsoluteLong,   // (xxx).L
    PcDisplacement, // #<data>
    PcIndex,        // d16(PC)
    ImmediateData   // d8(PC,An) or d8(PC,Dn)
};

namespace Condition
{
enum ConditionCode
{
    T,
    F,
    HI,
    LS,
    CC,
    CS,
    NE,
    EQ,
    VC,
    VS,
    PL,
    MI,
    GE,
    LT,
    GT,
    LE
};
} // namespace Condition

// Extremely common address mode check for destination EA's
inline constexpr bool isWritableMode(uint8_t mode, uint8_t reg)
{
    return mode != Special || reg == AbsoluteWord || reg == AbsoluteLong;
}


// Parses the size field, assuming the standard size encoding. The result is written
// into out_sizeOp. Returns true if successful.
//
// This is an inline function, so hopefully the compiler will optimize away the bool
// return and the out_sizeOp reference/pointer.
//
// TODO: Not really sure where to put this. It doesn't really belong with OperandSize
// functions, since it's a parsing function.
inline bool parseStandardSize(uint8_t size, OperandSize& out_sizeOp)
{
    constexpr uint8_t SIZ_BYTE = 0;
    constexpr uint8_t SIZ_WORD = 1;
    constexpr uint8_t SIZ_LONG = 2;

    switch (size)
    {
    case SIZ_BYTE:
        out_sizeOp = OperandSize::Byte;
        return true;
    case SIZ_WORD:
        out_sizeOp = OperandSize::Word;
        return true;
    case SIZ_LONG:
        out_sizeOp = OperandSize::Long;
        return true;
    default:
        return false;
    }
}

class RegisterSet
{
  public:
    RegisterSet();
    RegisterSet(uint8_t addressRegMask, uint8_t dataRegMask, bool hasPC = false);

    void format(std::ostream& stream) const;
    inline std::string format() const
    {
        std::ostringstream buffer;
        format(buffer);
        return buffer.str();
    }

    bool contains(Register reg) const;

    // Returns true if the register was already in the set.
    bool add(Register reg);

    // Returns true if the register was removed from the set.
    bool remove(Register reg);

  private:
    std::bitset<8> _addressRegisters;
    std::bitset<8> _dataRegisters;
    bool _hasPC;

    static void formatRanges(std::ostream& stream, const std::bitset<8>& registers, Registers::RegMaker maker);
};

inline std::ostream& operator<<(std::ostream& os, const RegisterSet& registers)
{
    registers.format(os);
    return os;
}

class FormattedNumber
{
  public:
    FormattedNumber(int32_t number, OperandSize size = OperandSize::Long,
                    AddrSpaceHandle labelSpace = &LITERAL_DEC_SPACE);

    std::string str() const;

    int32_t number;
    OperandSize size;
    AddrSpaceHandle labelSpace;
};

std::ostream& operator<<(std::ostream& os, const FormattedNumber& number);

FormattedNumber MakeFormattedNumber(int value, int amod, OperandSize defaultHexSize = OperandSize::Long,
                                    AddrSpaceHandle space = nullptr);

typedef Either<std::string, FormattedNumber> LabelOrNumber;

class InstrParam;
std::ostream& operator<<(std::ostream& os, const InstrParam& self);

class InstrParam
{
  public:
    virtual ~InstrParam() = default;

    virtual void format(std::ostream& stream) const = 0;
    std::string toStr() const;

    friend std::ostream& operator<<(std::ostream& os, const InstrParam& self);
};

class LiteralParam : public InstrParam
{
  public:
    LiteralParam(std::string label, bool usePrefix = false);
    LiteralParam(FormattedNumber number, bool usePrefix = true);
    virtual ~LiteralParam() = default;

    virtual void format(std::ostream& stream) const override;

    const LabelOrNumber value;
    const bool usePrefix;
};

class RegParam : public InstrParam, public RawParam
{
  public:
    RegParam(Register reg);
    RegParam(Register reg, RegParamMode mode);
    virtual ~RegParam() = default;

    virtual void format(std::ostream& stream) const override;

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                bool suppressAbsoluteAddressLabels, bool suppressHashTagForImmediates);

    const Register reg;
    const RegParamMode mode;
};

class AbsoluteAddrParam : public InstrParam
{
  public:
    AbsoluteAddrParam(std::string label, OperandSize size);
    AbsoluteAddrParam(FormattedNumber address, OperandSize size);
    virtual ~AbsoluteAddrParam() = default;

    virtual void format(std::ostream& stream) const override;

    const LabelOrNumber value;
    const OperandSize size;
};

class RegOffsetParam : public InstrParam
{
  public:
    RegOffsetParam(Register addressReg, FormattedNumber offset);
    RegOffsetParam(Register addressReg, std::string offsetLabel);
    RegOffsetParam(Register addressReg, Register offsetReg, OperandSize offsetRegSize, FormattedNumber offset);
    RegOffsetParam(Register addressReg, Register offsetReg, OperandSize offsetRegSize, std::string offsetLabel);
    virtual ~RegOffsetParam() = default;

    virtual void format(std::ostream& stream) const override;
    inline bool shouldForceZero() const
    {
        return _forceZero;
    }
    inline void setShouldForceZero(bool shouldForceZero)
    {
        _forceZero = shouldForceZero;
    }

    inline bool hasOffsetReg() const
    {
        return _hasOffsetReg;
    }
    Register offsetReg() const;
    const std::string& label() const;

    const Register addressReg;
    const LabelOrNumber offset;

  private:
    const bool _hasOffsetReg;
    const Register _offsetReg;
    const OperandSize _offsetRegSize;

    bool _forceZero;
};

class MultiRegParam : public InstrParam, public RawParam
{
  public:
    MultiRegParam(RegisterSet&& registers);
    virtual ~MultiRegParam() = default;

    virtual void format(std::ostream& stream) const override;
    inline const RegisterSet& registers() const
    {
        return _regs;
    }

    virtual std::unique_ptr<InstrParam> hydrate(bool isRof, int Pass, bool forceRelativeImmediateMode,
                                                AddrSpaceHandle literalSpaceHint, uint16_t moduleType,
                                                bool suppressAbsoluteAddressLabels, bool suppressHashTagForImmediates);

private:
    RegisterSet _regs;
};

#endif // PARAMS_H
