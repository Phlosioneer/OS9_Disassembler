
#include "pch.h"

#include "params.h"

#include "disglobs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "label.h"

#pragma region Registers

const char* registerNames[] = {"a0", "a1", "a2", "a3", "a4", "a5", "a6", "sp",  "pc", "d0",
                               "d1", "d2", "d3", "d4", "d5", "d6", "d7", "ccr", "sr", "usp"};

static_assert(_countof(registerNames) == Registers::MAX_ID + 1, "Some registers are missing names");

namespace Registers
{

const char* getName(Register reg)
{
    auto regNumber = static_cast<size_t>(reg);
    if (regNumber >= _countof(registerNames)) throw std::runtime_error("");
    return registerNames[regNumber];
}

constexpr Register makeDReg(unsigned int id)
{
    if (id >= 8) throw std::exception();
    return fromIdUnchecked(id + getId(Register::D0));
}

constexpr Register makeAReg(unsigned int id)
{
    if (id >= 8) throw std::exception();
    return fromIdUnchecked(id + getId(Register::A0));
}

constexpr Register fromId(unsigned int id)
{
    if (id > MAX_ID) throw std::exception();
    return fromIdUnchecked(id);
}

constexpr bool isDReg(Register reg)
{
    return getId(reg) >= getId(Register::D0) && getId(reg) <= getId(Register::D7);
}

constexpr bool isAReg(Register reg)
{
    return getId(reg) >= getId(Register::A0) && getId(reg) <= getId(Register::SP);
}

constexpr uint8_t getIndex(Register reg)
{
    if (!isDReg(reg) && !isAReg(reg)) throw std::runtime_error("Register doesn't have an index");
    return getIndexUnchecked(reg);
}

constexpr uint8_t getIndexUnchecked(Register reg)
{
    if (isDReg(reg)) return getId(reg) - getId(Register::D0);
    return getId(reg) - getId(Register::A0);
}

} // namespace Registers

#pragma endregion

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
        stream << Registers::getName(Register::PC);
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
    if (reg == Register::PC)
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
    if (reg == Register::PC)
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
    if (reg == Register::PC)
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

#pragma region FormattedNumber

FormattedNumber::FormattedNumber(int32_t number, OperandSize size, AddrSpaceHandle labelSpace)
    : number(number), size(size), labelSpace(labelSpace)
{
}

std::string FormattedNumber::str() const
{
    std::ostringstream buffer;
    buffer << *this;
    return buffer.str();
}

/*
 * Append a char in the desired printable format onto dst
 */
static void singleCharData(std::ostream& dest, char ch)
{
    if (isprint(ch & 0x7f) && ((ch & 0x7f) != ' '))
    {
        dest << '\'' << ch << '\'';
    }
    else
    {
        auto pp = labelManager.getLabel(&LITERAL_ASCII_SPACE, ch);
        if (pp)
        {
            dest << pp->name();
        }
        else
        {
            dest << PrettyNumber<int>(ch).fill('0').width(2).hex();
        }
    }

    if (ch & 0x80)
    {
        dest << "+$80";
    }
}

std::ostream& operator<<(std::ostream& os, const FormattedNumber& self)
{
    if (!self.labelSpace) throw std::runtime_error("Unexpected class!");
    if (*self.labelSpace == LITERAL_HEX_SPACE)
    {
        uint32_t trunc = OperandSizes::truncateUnsigned(self.size, self.number);
        os << '$' << PrettyNumber<int32_t>(trunc).fill('0').hex().width((size_t)OperandSizes::getByteCount(self.size) * 2);
    }
    else if (*self.labelSpace == LITERAL_DEC_SPACE || *self.labelSpace == LITERAL_SPACE)
    {
        os << self.number;
    }
    else if (*self.labelSpace == LITERAL_ASCII_SPACE)
    {
        // TODO: This breaks if self.number > 0xFFFF.
        // TODO: This ignores self.size
        if (self.number > 0xff)
        {
            singleCharData(os, (self.number >> 8) & 0xff);
            // TODO: This breaks if the character has 0x80 bit set. Need parentheses.
            os << "*256+";
        }
        singleCharData(os, self.number & 0xff);
    }
    else
    {
        throw std::runtime_error("Unexpected class!");
    }
    return os;
}

FormattedNumber MakeFormattedNumber(int value, int amod, int defaultHexSize, AddrSpaceHandle space)
{
    OperandSize convertedSize;
    switch (defaultHexSize)
    {
    case 1:
        convertedSize = OperandSize::Byte;
        break;
    case 2:
        convertedSize = OperandSize::Word;
        break;
    case 4:
        convertedSize = OperandSize::Long;
        break;
    default:
        throw std::runtime_error("Invalid size");
    }
    return MakeFormattedNumber(value, amod, convertedSize, space);
}

FormattedNumber MakeFormattedNumber(int value, int amod, OperandSize defaultHexSize, AddrSpaceHandle space)
{
    if (!space && amod)
    {
        if (amod == AM_A6)
        {
            space = &UNKNOWN_DATA_SPACE;
        }
        else if (amod <= AM_A7 || amod == AM_IMM)
        {
            space = &LITERAL_DEC_SPACE;
        }
        else
        {
            space = &CODE_SPACE;
        }
    }
    else /* amod=0, it's a boundary def  */
    {
        if (!space)
        {
            // Guess
            space = &LITERAL_SPACE;
        }
    }

    /* Readjust class definition if necessary */
    if (space == &LITERAL_SPACE)
    {
        if (abs(value) < 9)
        {
            space = &LITERAL_DEC_SPACE;
        }
        else
        {
            space = &LITERAL_HEX_SPACE;
        }
    }

    if (*space == LITERAL_HEX_SPACE)
    {
        switch (amod)
        {
        default:
            return FormattedNumber(value, defaultHexSize, space);
        case AM_LONG:
            return FormattedNumber(value, OperandSize::Long, space);
        case AM_SHORT:
            return FormattedNumber(value, OperandSize::Word, space);
        }
    }
    else if (*space == LITERAL_DEC_SPACE)
    {
        return FormattedNumber(value, OperandSize::Long, space);
    }
    else if (*space == LITERAL_ASCII_SPACE)
    {
        return FormattedNumber(value, OperandSize::Byte, space);
    }
    else
    {
        throw std::runtime_error("Unexpected address space: " + space->name);
    }
}

#pragma endregion

#pragma region InstrParam

std::string InstrParam::toStr() const
{
    std::ostringstream stream;
    format(stream);
    return stream.str();
}

std::ostream& operator<<(std::ostream& os, const InstrParam& self)
{
    self.format(os);
    return os;
}

#pragma endregion

#pragma region LiteralParam

LiteralParam::LiteralParam(std::string label, bool usePrefix) : value(label), usePrefix(usePrefix)
{
}

LiteralParam::LiteralParam(FormattedNumber number, bool usePrefix) : value(number), usePrefix(usePrefix)
{
}

void LiteralParam::format(std::ostream& stream) const
{
    if (usePrefix) stream << '#';

    if (value.hasLeft())
    {
        stream << value.left();
    }
    else
    {
        stream << value.right();
    }
}

#pragma endregion

#pragma region RegParam

RegParam::RegParam(Register reg) : RegParam(reg, RegParamMode::Direct)
{
}

RegParam::RegParam(Register reg, RegParamMode mode) : reg(reg), mode(mode)
{
    if (reg >= Register::D0 && reg <= Register::D7)
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

AbsoluteAddrParam::AbsoluteAddrParam(FormattedNumber address, OperandSize size) : value(address), size(size)
{
    if (size == OperandSize::Byte) throw std::runtime_error("Byte absolute address not allowed");
}

AbsoluteAddrParam::AbsoluteAddrParam(std::string label, OperandSize size) : value(label), size(size)
{
    if (size == OperandSize::Byte) throw std::runtime_error("Byte absolute address not allowed");
}

void AbsoluteAddrParam::format(std::ostream& stream) const
{
    stream << '(';
    if (value.hasLeft())
    {
        stream << value.left();
    }
    else
    {
        stream << value.right();
    }
    stream << ')' << OperandSizes::getSuffix(size);
}

#pragma endregion

#pragma region RegOffsetParam

RegOffsetParam::RegOffsetParam(Register addressReg, FormattedNumber offset)
    : addressReg(addressReg), offset(offset), _hasOffsetReg(false), _offsetReg(), _offsetRegSize(OperandSize::Word),
      _forceZero(false)
{
    if (addressReg < Register::A0 || addressReg > Register::PC)
    {
        throw std::exception();
    }
}

RegOffsetParam::RegOffsetParam(Register addressReg, std::string offsetLabel)
    : addressReg(addressReg), offset(offsetLabel), _hasOffsetReg(false), _offsetReg(),
      _offsetRegSize(OperandSize::Word), _forceZero(false)
{
    if (addressReg < Register::A0 || addressReg > Register::PC)
    {
        throw std::exception();
    }
}

RegOffsetParam::RegOffsetParam(Register addressReg, Register offsetReg, OperandSize offsetRegSize,
                               FormattedNumber offset)
    : addressReg(addressReg), offset(offset), _hasOffsetReg(true), _offsetReg(offsetReg), _offsetRegSize(offsetRegSize),
      _forceZero(false)
{
    if (addressReg < Register::A0 || addressReg > Register::PC)
    {
        throw std::exception();
    }
    if (offsetRegSize == OperandSize::Byte)
    {
        throw std::exception();
    }
}

RegOffsetParam::RegOffsetParam(Register addressReg, Register offsetReg, OperandSize offsetRegSize,
                               std::string offsetLabel)
    : addressReg(addressReg), offset(offsetLabel), _hasOffsetReg(true), _offsetReg(offsetReg),
      _offsetRegSize(offsetRegSize), _forceZero(false)
{
    if (addressReg < Register::A0 || addressReg > Register::PC)
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
    if (offset.hasLeft())
    {
        stream << offset.left();
    }
    else if (offset.right().number != 0 || _forceZero)
    {
        stream << offset.right();
    }
    stream << '(' << Registers::getName(addressReg);
    if (_hasOffsetReg)
    {
        stream << ',' << Registers::getName(_offsetReg) << OperandSizes::getSuffix(_offsetRegSize);
    }
    stream << ')';
}

Register RegOffsetParam::offsetReg() const
{
    if (!_hasOffsetReg) throw std::exception();
    return _offsetReg;
}

#pragma endregion

#pragma region MultiRegParam

MultiRegParam::MultiRegParam(RegisterSet&& registers) : _regs(std::move(registers))
{

}

void MultiRegParam::format(std::ostream& stream) const
{
    stream << _regs;
}

#pragma endregion