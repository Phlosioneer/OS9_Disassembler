
#pragma once

#include "pch.h"

enum class OperandSize : uint8_t
{
    Byte,
    Word,
    Long
};

namespace OperandSizes
{


inline char getLetter(OperandSize size)
{
    switch (size)
    {
    case OperandSize::Byte:
        return 'b';
    case OperandSize::Word:
        return 'w';
    case OperandSize::Long:
        return 'l';
    default:
        throw std::runtime_error("Unexpected size");
    }
}

inline const char* getSuffix(OperandSize size)
{
    switch (size)
    {
    case OperandSize::Byte:
        return ".b";
    case OperandSize::Word:
        return ".w";
    case OperandSize::Long:
        return ".l";
    default:
        throw std::runtime_error("Unexpected size");
    }
}

inline uint8_t getByteCount(OperandSize size)
{
    switch (size)
    {
    case OperandSize::Byte:
        return 1;
    case OperandSize::Word:
        return 2;
    case OperandSize::Long:
        return 4;
    default:
        throw std::runtime_error("Unexpected size");
    }
}

// Excess bytes are filled with 0
uint32_t truncateUnsigned(OperandSize size, uint32_t value);
// Excess bytes are sign-extended
int32_t truncateSigned(OperandSize size, int32_t value);

}



