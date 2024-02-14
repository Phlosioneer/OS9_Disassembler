#pragma once

#include "pch.h"

enum class Register : uint8_t
{
    A0,
    A1,
    A2,
    A3,
    A4,
    A5,
    A6,
    SP,
    PC,
    D0,
    D1,
    D2,
    D3,
    D4,
    D5,
    D6,
    D7,
    CCR,
    SR,
    USP
};

// Helper methods for the Register enum.
namespace Registers
{
const size_t MAX_ID = static_cast<size_t>(Register::USP);

typedef Register (*RegMaker)(unsigned int id);

// Implementation in params.cpp
const char* getName(Register reg);

constexpr uint8_t getId(Register reg)
{
    return static_cast<int>(reg);
}

constexpr Register fromIdUnchecked(unsigned int id)
{
    return static_cast<Register>(id);
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

constexpr uint8_t getIndexUnchecked(Register reg)
{
    if (isDReg(reg)) return getId(reg) - getId(Register::D0);
    return getId(reg) - getId(Register::A0);
}

constexpr uint8_t getIndex(Register reg)
{
    if (!isDReg(reg) && !isAReg(reg)) throw std::runtime_error("Register doesn't have an index");
    return getIndexUnchecked(reg);
}

}; // namespace Registers

enum class RegParamMode
{
    Direct,
    Indirect,
    PostIncrement,
    PreDecrement
};