
#include "pch.h"

#include "size.h"

uint32_t OperandSizes::truncateUnsigned(OperandSize size, uint32_t value)
{
    switch (size)
    {
    case OperandSize::Byte:
        return value & 0xFF;
    case OperandSize::Word:
        return value & 0xFFFF;
    case OperandSize::Long:
        return value;
    default:
        throw std::runtime_error("Unexpected size");
    }
}

int32_t OperandSizes::truncateSigned(OperandSize size, int32_t value)
{
    switch (size)
    {
    case OperandSize::Byte:
        return (int32_t)((int8_t)value);
    case OperandSize::Word:
        return (int32_t)((int16_t)value);
    case OperandSize::Long:
        return value;
    default:
        throw std::runtime_error("Unexpected size");
    }
}