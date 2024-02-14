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

enum class RegParamMode
{
    Direct,
    Indirect,
    PostIncrement,
    PreDecrement
};