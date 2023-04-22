
#ifndef PARAMS_H
#define PARAMS_H

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

const char* getRegisterName(Register reg);
Register makeDReg(unsigned int id);
Register makeAReg(unsigned int id);

char getOperandSizeLetter(OperandSize size);
const char* getOperandSizeSuffix(OperandSize size);

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
