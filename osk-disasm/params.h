
#ifndef PARAMS_H
#define PARAMS_H

#include "pch.h"

#include <bitset>

#include "address_space.h"
#include "either.h"

class Label;

enum class Register
{
    A0,
    A1,
    A2,
    A3,
    A4,
    A5,
    A6,
    SP,
    REG_PC,
    REG_D0,
    D1,
    D2,
    D3,
    D4,
    D5,
    D6,
    D7
};

enum class RegParamMode
{
    Direct,
    Indirect,
    PostIncrement,
    PreDecrement
};

enum class OperandSize
{
    Byte,
    Word,
    Long
};

// Helper methods for the Register enum.
namespace Registers
{
typedef Register (*RegMaker)(unsigned int id);
constexpr Register makeDReg(unsigned int id);
constexpr Register makeAReg(unsigned int id);

const char* getName(Register reg);
constexpr Register fromId(unsigned int id);
inline constexpr uint8_t getId(Register reg)
{
    return static_cast<int>(reg);
}
inline constexpr Register fromIdUnchecked(unsigned int id)
{
    return static_cast<Register>(id);
}

constexpr bool isDReg(Register reg);
constexpr bool isAReg(Register reg);
constexpr uint8_t getIndex(Register reg);
constexpr uint8_t getIndexUnchecked(Register reg);

}; // namespace Registers

char getOperandSizeLetter(OperandSize size);
const char* getOperandSizeSuffix(OperandSize size);
uint8_t getOperandSizeInBytes(OperandSize size);

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

    int32_t number;
    OperandSize size;
    AddrSpaceHandle labelSpace;
};

std::ostream& operator<<(std::ostream& os, const FormattedNumber& number);

FormattedNumber MakeFormattedNumber(int value, int amod, int defaultHexSize, AddrSpaceHandle space = nullptr);

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
    LiteralParam(std::string label);
    LiteralParam(FormattedNumber number);
    virtual ~LiteralParam() = default;

    virtual void format(std::ostream& stream) const override;

    const LabelOrNumber value;
};

class RegParam : public InstrParam
{
  public:
    RegParam(Register reg);
    RegParam(Register reg, RegParamMode mode);
    virtual ~RegParam() = default;

    virtual void format(std::ostream& stream) const override;

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

#endif // PARAMS_H
