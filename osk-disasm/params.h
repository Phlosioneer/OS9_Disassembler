
#ifndef PARAMS_H
#define PARAMS_H

#include <bitset>
#include <sstream>
#include <stdexcept>
#include <string>

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

class InstrParam
{
  public:
    virtual void format(std::ostream& stream) const = 0;
    std::string toStr() const;
};

class LiteralParam : public InstrParam
{
  public:
    LiteralParam(int32_t value);
    LiteralParam(int32_t value, const char* label);
    virtual void format(std::ostream& stream) const override;

    const int32_t value;

  private:
    const bool _hasLabel;
    const std::string _label;
};

class RegParam : public InstrParam
{
  public:
    RegParam(Register reg);
    RegParam(Register reg, RegParamMode mode);
    virtual void format(std::ostream& stream) const override;

    const Register reg;
    const RegParamMode mode;
};

class AbsoluteAddrParam : public InstrParam
{
  public:
    AbsoluteAddrParam(int32_t address, const char* label, OperandSize size);
    virtual void format(std::ostream& stream) const override;

    inline bool hasLabel() const
    {
        return _hasLabel;
    }
    inline bool hasAddress() const
    {
        return !_hasLabel;
    }
    int32_t address() const;
    const std::string& label() const;

    const OperandSize size;

  private:
    const bool _hasLabel;
    const int32_t _address;
    const std::string _label;
};

class RegOffsetParam : public InstrParam
{
  public:
    RegOffsetParam(Register addressReg, int32_t offset, const char* label);
    RegOffsetParam(Register addressReg, Register offsetReg, OperandSize offsetRegSize, unsigned int scale);
    RegOffsetParam(Register addressReg, Register offsetReg, OperandSize offsetRegSize, unsigned int scale,
                   int32_t offset, const char* label);
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
    inline bool hasLabel() const
    {
        return _hasLabel;
    }
    Register offsetReg() const;
    const std::string& label() const;

    const Register addressReg;
    const int32_t offset;

  private:
    const bool _hasOffsetReg;
    const Register _offsetReg;
    const OperandSize _offsetRegSize;
    const int _scale;
    const bool _hasLabel;
    const std::string _label;

    bool _forceZero;
};

#endif // PARAMS_H
