
#include "params.h"

const char* registerNames[] = {"a0", "a1", "a2", "a3", "a4", "a5", "a6", "sp", "pc",
                               "d0", "d1", "d2", "d3", "d4", "d5", "d6", "d7"};
const char sizeLetters[] = {'b', 'w', 'l'};
const char* sizeSuffixes[] = {".b", ".w", ".l"};

namespace Registers
{

const char* getName(Register reg)
{
    auto regNumber = static_cast<size_t>(reg);
    if (regNumber >= _countof(registerNames)) throw std::exception();
    return registerNames[regNumber];
}

constexpr Register makeDReg(unsigned int id)
{
    if (id >= 8) throw std::exception();
    return fromIdUnchecked(id + getId(Register::REG_D0));
}

constexpr Register makeAReg(unsigned int id)
{
    if (id >= 8) throw std::exception();
    return fromIdUnchecked(id + getId(Register::A0));
}

constexpr Register fromId(unsigned int id)
{
    if (id >= 17) throw std::exception();
    return fromIdUnchecked(id);
}

constexpr bool isDReg(Register reg)
{
    return getId(reg) < getId(Register::REG_PC);
}

constexpr bool isAReg(Register reg)
{
    return getId(reg) > getId(Register::REG_PC);
}

constexpr uint8_t getIndex(Register reg)
{
    if (reg == Register::REG_PC) throw std::runtime_error("PC register doesn't have an index");
    return getIndexUnchecked(reg);
}

constexpr uint8_t getIndexUnchecked(Register reg)
{
    if (isDReg(reg)) return getId(reg) - getId(Register::REG_D0);
    return getId(reg) - getId(Register::A0);
}

} // namespace Registers

char getOperandSizeLetter(OperandSize size)
{
    auto i = static_cast<size_t>(size);
    if (i >= _countof(sizeLetters)) throw std::exception();
    return sizeLetters[i];
}

const char* getOperandSizeSuffix(OperandSize size)
{
    auto i = static_cast<size_t>(size);
    if (i >= _countof(sizeSuffixes)) throw std::exception();
    return sizeSuffixes[i];
}

#pragma region RegisterSet

RegisterSet::RegisterSet() : RegisterSet(0, 0)
{
}

RegisterSet::RegisterSet(uint8_t addressRegMask, uint8_t dataRegMask, bool hasPC)
    : _addressRegisters(addressRegMask), _dataRegisters(dataRegMask), _hasPC(hasPC)
{
}

void RegisterSet::format(std::ostream& stream) const
{
    bool hasOutputAnything = false;
    if (_addressRegisters.any())
    {
        formatRanges(stream, _addressRegisters, Registers::makeAReg);
        hasOutputAnything = true;
    }
    if (_hasPC)
    {
        if (hasOutputAnything) stream << '/';
        stream << Registers::getName(Register::REG_PC);
        hasOutputAnything = true;
    }
    if (_dataRegisters.any())
    {
        if (hasOutputAnything) stream << '/';
        formatRanges(stream, _dataRegisters, Registers::makeDReg);
        hasOutputAnything = true;
    }
    if (!hasOutputAnything)
    {
        stream << '0';
    }
}

bool RegisterSet::contains(Register reg) const
{
    if (reg == Register::REG_PC)
    {
        return _hasPC;
    }
    else if (Registers::isAReg(reg))
    {
        return _addressRegisters[Registers::getIndexUnchecked(reg)];
    }
    else
    {
        return _dataRegisters[Registers::getIndexUnchecked(reg)];
    }
}

bool RegisterSet::add(Register reg)
{
    bool ret;
    if (reg == Register::REG_PC)
    {
        ret = _hasPC;
        _hasPC = true;
    }
    else if (Registers::isAReg(reg))
    {
        auto index = Registers::getIndexUnchecked(reg);
        ret = _addressRegisters[index];
        _addressRegisters.set(index);
    }
    else
    {
        auto index = Registers::getIndexUnchecked(reg);
        ret = _dataRegisters[index];
        _addressRegisters.set(index);
    }
    return ret;
}

bool RegisterSet::remove(Register reg)
{
    bool ret;
    if (reg == Register::REG_PC)
    {
        ret = _hasPC;
        _hasPC = false;
    }
    else if (Registers::isAReg(reg))
    {
        auto index = Registers::getIndexUnchecked(reg);
        ret = _addressRegisters[index];
        _addressRegisters.reset(index);
    }
    else
    {
        auto index = Registers::getIndexUnchecked(reg);
        ret = _dataRegisters[index];
        _dataRegisters.set(index);
    }
    return ret;
}

void RegisterSet::formatRanges(std::ostream& stream, const std::bitset<8>& registers, Registers::RegMaker maker)
{
    int i;
    bool hasStartReg = false;
    bool hasPrintedDash = false;
    bool doSlash = false;

    for (i = 0; i < 8; i++)
    {
        if (registers[i])
        {
            if (hasStartReg)
            {
                if (!hasPrintedDash)
                {
                    stream << '-';
                    hasPrintedDash = true;
                }
                continue;
            }
            else
            {
                if (doSlash) stream << '/';
                stream << Registers::getName(maker(i));
                hasStartReg = true;
            }
        }
        else if (hasStartReg)
        {
            // Print the end register if needed.
            if (hasPrintedDash) stream << Registers::getName(maker(i - 1));
            hasStartReg = false;
            hasPrintedDash = false;
            doSlash = true;
        }
    }

    if (hasPrintedDash) stream << Registers::getName(maker(i - 1));
}

#pragma endregion

#pragma region InstrParam

std::string InstrParam::toStr() const
{
    std::ostringstream stream;
    format(stream);
    return stream.str();
}

#pragma endregion

#pragma region LiteralParam

LiteralParam::LiteralParam(int32_t value) : LiteralParam(value, nullptr)
{
}

LiteralParam::LiteralParam(int32_t value, const char* label)
    : value(value), _hasLabel(label != nullptr), _label(label ? label : "")
{
}

void LiteralParam::format(std::ostream& stream) const
{
    if (_hasLabel)
    {
        stream << _label;
    }
    else
    {
        stream << '#' << value;
    }
}

#pragma endregion

#pragma region RegParam

RegParam::RegParam(Register reg) : RegParam(reg, RegParamMode::Direct)
{
}

RegParam::RegParam(Register reg, RegParamMode mode) : reg(reg), mode(mode)
{
    if (reg >= Register::REG_D0 && reg <= Register::D7)
    {
        if (mode != RegParamMode::Direct) throw std::exception();
    }
}

void RegParam::format(std::ostream& stream) const
{
    auto name = Registers::getName(reg);
    switch (mode)
    {
    case RegParamMode::Direct:
        stream << name;
        break;
    case RegParamMode::Indirect:
        stream << '(' << name << ')';
        break;
    case RegParamMode::PostIncrement:
        stream << '(' << name << ")+";
        break;
    case RegParamMode::PreDecrement:
        stream << "-(" << name << ')';
        break;
    default:
        std::ostringstream message;
        message << "Unexpected enum value: " << static_cast<int>(mode);
        throw std::runtime_error(message.str());
    }
}

#pragma endregion

#pragma region AbsoluteAddrParam

AbsoluteAddrParam::AbsoluteAddrParam(int32_t address, const char* label, OperandSize size)
    : size(size), _hasLabel(label != nullptr), _address(address), _label(label)
{
    if (size == OperandSize::Byte)
    {
        throw std::exception();
    }
}

void AbsoluteAddrParam::format(std::ostream& stream) const
{
    stream << '(';
    if (_hasLabel)
    {
        stream << _label;
    }
    else
    {
        stream << _address;
    }
    stream << ')' << getOperandSizeSuffix(size);
}

int32_t AbsoluteAddrParam::address() const
{
    if (_hasLabel) throw std::runtime_error("Param does not have an address.");
    return _address;
}

const std::string& AbsoluteAddrParam::label() const
{
    if (!_hasLabel) throw std::runtime_error("Param does not have a label.");
    return _label;
}

#pragma endregion

#pragma region RegOffsetParam

RegOffsetParam::RegOffsetParam(Register addressReg, int32_t offset, const char* label)
    : addressReg(addressReg), offset(offset), _hasOffsetReg(false), _offsetReg(), _offsetRegSize(OperandSize::Word),
      _scale(0), _hasLabel(label != nullptr), _label(label ? label : ""), _forceZero(false)
{
    if (addressReg < Register::A0 || addressReg > Register::REG_PC)
    {
        throw std::exception();
    }
}

RegOffsetParam::RegOffsetParam(Register addressReg, Register offsetReg, OperandSize offsetRegSize, unsigned int scale)
    : RegOffsetParam(addressReg, offsetReg, offsetRegSize, scale, 0, nullptr)
{
}

RegOffsetParam::RegOffsetParam(Register addressReg, Register offsetReg, OperandSize offsetRegSize, unsigned int scale,
                               int32_t offset, const char* label)
    : addressReg(addressReg), offset(offset), _hasOffsetReg(true), _offsetReg(offsetReg), _offsetRegSize(offsetRegSize),
      _scale(scale), _hasLabel(label != nullptr), _label(label ? label : ""), _forceZero(false)
{
    if (addressReg < Register::A0 || addressReg > Register::REG_PC)
    {
        throw std::exception();
    }
    if (scale > 3)
    {
        throw std::exception();
    }
    if (offsetRegSize == OperandSize::Byte)
    {
        throw std::exception();
    }
}

void RegOffsetParam::format(std::ostream& stream) const
{
    if (_hasLabel)
    {
        stream << _label;
    }
    else if (offset != 0 || _forceZero)
    {
        stream << offset;
    }
    stream << '(' << Registers::getName(addressReg);
    if (_hasOffsetReg)
    {
        stream << ',' << Registers::getName(_offsetReg) << getOperandSizeSuffix(_offsetRegSize);
        if (_scale != 0) stream << '*' << (1 << _scale);
    }
    stream << ')';
}

Register RegOffsetParam::offsetReg() const
{
    if (!_hasOffsetReg) throw std::exception();
    return _offsetReg;
}

const std::string& RegOffsetParam::label() const
{
    if (!_hasLabel) throw std::exception();
    return _label;
}

#pragma endregion