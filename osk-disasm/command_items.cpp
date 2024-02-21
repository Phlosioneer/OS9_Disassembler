
#include "pch.h"

#include "command_items.h"

#include "address_space.h"
#include "commonsubs.h"
#include "disglobs.h"
#include "dismain.h"
#include "dprint.h"
#include "main_support.h"
#include "modtypes.h"
#include "params.h"
#include "rof.h"
#include "userdef.h"
#include "raw_params.h"

typedef struct modestrs
{
    const char* str;
    int CPULvl;
} MODE_STR;

void cmd_items::setSource(const LiteralParam& param)
{
    source = std::make_unique<LiteralParam>(param);
}

void cmd_items::setSource(const RegParam& param)
{
    source = std::make_unique<RegParam>(param);
}

void cmd_items::setSource(const AbsoluteAddrParam& param)
{
    source = std::make_unique<AbsoluteAddrParam>(param);
}

void cmd_items::setSource(const RegOffsetParam& param)
{
    source = std::make_unique<RegOffsetParam>(param);
}

void cmd_items::setSource(const MultiRegParam& param)
{
    source = std::make_unique<MultiRegParam>(param);
}

void cmd_items::setDest(const LiteralParam& param)
{
    dest = std::make_unique<LiteralParam>(param);
}

void cmd_items::setDest(const RegParam& param)
{
    dest = std::make_unique<RegParam>(param);
}

void cmd_items::setDest(const AbsoluteAddrParam& param)
{
    dest = std::make_unique<AbsoluteAddrParam>(param);
}

void cmd_items::setDest(const RegOffsetParam& param)
{
    dest = std::make_unique<RegOffsetParam>(param);
}

void cmd_items::setDest(const MultiRegParam& param)
{
    dest = std::make_unique<MultiRegParam>(param);
}

std::string cmd_items::renderParams() const
{
    std::ostringstream paramBuffer;
    if (source)
    {
        paramBuffer << *source;
        if (dest)
        {
            paramBuffer << ',' << *dest;
        }
    }
    return paramBuffer.str();
}

cmd_items& cmd_items::operator=(struct cmd_items&& other) noexcept
{
    lblname = std::move(other.lblname);
    mnem = std::move(other.mnem);
    comment = other.comment;
    source.swap(other.source);
    dest.swap(other.dest);
    rawSource.swap(other.rawSource);
    rawDest.swap(other.rawDest);
    memcpy_s(rawData, 10, other.rawData, 10);
    rawDataSize = other.rawDataSize;
    forceRelativeImmediateMode = other.forceRelativeImmediateMode;
    literalSpaceHint = other.literalSpaceHint;

    return *this;
}

void cmd_items::hydrateRawParams(bool isRof, int Pass, uint16_t moduleType)
{
    if (rawSource && !source)
    {
        source = rawSource->hydrate(isRof, Pass, forceRelativeImmediateMode, literalSpaceHint, moduleType);
    }

    if (rawDest && !dest)
    {
        dest = rawDest->hydrate(isRof, Pass, forceRelativeImmediateMode, literalSpaceHint, moduleType);
    }
}

/*
 * Functions that deal with a register and hold the reg #
 * in the command word, and also have an effective address
 */
int reg_ea(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t sourceMode = (ci->cmd_wrd >> 3) & 7;
    uint8_t sourceReg = ci->cmd_wrd & 7;
    uint8_t destRegCode = (ci->cmd_wrd >> 9) & 7;
    uint8_t rawSize = (ci->cmd_wrd >> 7) & 3;

    /* Eliminate illegal Addressing modes */
    switch (op->id)
    {
    case InstrId::CHK:  /* chk */
    case InstrId::DIVU: /* divu */
    case InstrId::DIVS: /* divs */
    case InstrId::MULU: /* mulu */
    case InstrId::MULS: /* muls */
        if ((sourceMode == 1)) return 0;
        break;

    case InstrId::LEA: /* lea */
        if ((sourceMode < 2) || (sourceMode == 3) || (sourceMode == 4)) return 0;
        if ((sourceMode == 7) && (sourceReg == 4)) return 0;
        break;
    default:
        throw std::runtime_error("Unexpected instruction id");
    }

    // Determine operand size
    OperandSize size;
    switch (op->id)
    {
    case InstrId::CHK:
        switch (rawSize)
        {
        case 0b11:
            size = OperandSize::Word;
            break;
        case 0b10:
            size = OperandSize::Long;
            break;
        default:
            return 0;
        }
        break;
    case InstrId::DIVS:
    case InstrId::DIVU:
    case InstrId::MULS:
    case InstrId::MULU:
        size = OperandSize::Word;
        break;
    case InstrId::LEA:
        size = OperandSize::Long;
        break;
    default:
        throw std::runtime_error("Unexpected instruction id");
    }

    ci->rawSource = parseEffectiveAddressWithMode(state, sourceMode, sourceReg, size);
    if (!ci->rawSource) return 0;

    ci->mnem = op->name;
    Register destReg = Registers::makeDReg(destRegCode);
    if (op->id == InstrId::LEA)
    {
        destReg = Registers::makeAReg(destRegCode);
    }

    ci->dest = std::make_unique<RegParam>(destReg, RegParamMode::Direct);
    return 1;
}

static RegisterSet reglist(uint16_t regmask, int mode)
{
    if (mode == 4)
    {
        regmask = revbits(regmask, 16);
    }

    uint8_t addressByte = regmask >> 8;
    uint8_t dataByte = regmask & 0xFF;

    // RegisterSet registers(addressByte, dataByte);
    // stream << registers;
    return RegisterSet(addressByte, dataByte);
}

int cmd_movem(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t reg = ci->cmd_wrd & 7;
    OperandSize size = (ci->cmd_wrd & 0x40) ? OperandSize::Long : OperandSize::Word;
    bool regsAreDest = (ci->cmd_wrd >> 10) & 1;

    // Can't use direct mode.
    if (mode == DirectAddrReg || mode == DirectDataReg) return 0;

    if (regsAreDest)
    {
        if (mode == PreDecrement) return 0;
        if (mode == Special && reg == ImmediateData) return 0;
    }
    else
    {
        if (mode == PostIncrement) return 0;
        if (!isWritableMode(mode, reg)) return 0;
    }

    if (!hasnext_w(state)) return 0;
    uint16_t regmask = getnext_w(ci, state);

    auto rawEaParam = parseEffectiveAddressWithMode(state, mode, reg, size);
    if (!rawEaParam) return 0;

    auto mnem = std::string(op->name) + OperandSizes::getLetter(size);
    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(size);

    if (regsAreDest)
    {
        ci->rawSource = std::move(rawEaParam);
        ci->setDest(MultiRegParam(reglist(regmask, mode)));
    }
    else
    {
        ci->setSource(MultiRegParam(reglist(regmask, mode)));
        ci->rawDest = std::move(rawEaParam);
    }
    return 1;
}

int link_unlk(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    auto reg = Registers::makeAReg(ci->cmd_wrd & 7);
    ci->mnem = op->name;

    if (op->id == InstrId::UNLK)
    {
        ci->setSource(RegParam(reg));
    }
    else
    {
        ci->rawDest = parseImmediateParam(state, OperandSize::Word);
        if (!ci->rawDest) return 0;

        ci->setSource(RegParam(reg));
    }
    return 1;
}

std::unique_ptr<RawParam> parseDisplacementParam(parse_state* state, Register baseReg)
{
    if (!hasnext_w(state))
    {
        return nullptr;
    }
    auto dispAddress = state->PCPos;
    auto displacement = getnext_w_raw(state);
    const auto dispSize = OperandSize::Word;

    return std::make_unique<RawRegOffsetParam>(baseReg, displacement, dispAddress, dispSize);
}

std::unique_ptr<RawParam> parseIndexParam(parse_state* state, Register baseReg)
{
    if (!hasnext_w(state))
    {
        return nullptr;
    }

    ExtensionWord extensionWord{getnext_w_raw(state)};
    // Nonzero scale not supported on M68000.
    if (!extensionWord.isValid || extensionWord.scale != 0)
    {
        ungetnext_w_raw(state);
        return nullptr;
    }

    auto dispAddress = state->PCPos - 1;
    const auto dispSize = OperandSize::Byte;

    return std::make_unique<RawIndexParam>(baseReg, extensionWord, dispAddress);
}

std::unique_ptr<RawLiteralParam> parseImmediateParam(parse_state* state, OperandSize size)
{
    auto immediateAddress = state->PCPos;
    uint32_t immediate = 0;
    switch (size)
    {
    case OperandSize::Byte: {
        // The byte is treated like a word with a limited range.
        immediateAddress += 1;
        // Read the whole word.
        if (!hasnext_w(state))
        {
            return nullptr;
        }
        immediate = getnext_w_raw(state);

        // In theory, the top byte of the word should be 0x00. However, assemblers
        // don't actually respect that restriction when the immediate is supposed
        // to be negative. So the upper byte of the word must be either 0x0000 or
        // 0xFF00.
        uint32_t upperByte = immediate & 0xFF00;
        if (upperByte != 0 && upperByte != 0xFF00)
        {
            ungetnext_w_raw(state);
            return nullptr;
        }

        break;
    }
    case OperandSize::Word:
        if (!hasnext_w(state))
        {
            return nullptr;
        }
        immediate = getnext_w_raw(state);
        break;
    case OperandSize::Long:
        if (!hasnext_l(state))
        {
            return nullptr;
        }
        immediate = getnext_l_raw(state);
        break;
    default:
        std::runtime_error("Invalid size");
    }

    return std::make_unique<RawLiteralParam>(immediate, size, immediateAddress);
}

std::unique_ptr<RawRelativeParam> parseRelativeParam(parse_state* state, OperandSize size)
{
    auto relativeToAddr = state->PCPos;
    auto immediate = parseImmediateParam(state, size);
    if (!immediate) return nullptr;
    return std::make_unique<RawRelativeParam>(*immediate, relativeToAddr);
}

std::unique_ptr<RawParam> parseAbsoluteParam(parse_state* state, OperandSize size)
{
    auto addressAddress = state->PCPos;


    uint32_t absoluteAddress;
    if (size == OperandSize::Word)
    {
        if (!hasnext_w(state))
        {
            return nullptr;
        }
        absoluteAddress = getnext_w_raw(state);
    }
    else if (size == OperandSize::Long)
    {
        if (!hasnext_l(state))
        {
            return nullptr;
        }
        absoluteAddress = getnext_l_raw(state);
    }
    else
    {
        throw std::runtime_error("Absolute param cannot be a single byte");
    }

    return std::make_unique<RawAbsoluteAddrParam>(absoluteAddress, addressAddress, size);
}

std::unique_ptr<RawParam> parseEffectiveAddressWithMode(parse_state* state, uint8_t mode, uint8_t reg, OperandSize size)
{
    switch (mode)
    {
    case DirectDataReg: /* "Dn" */
        return std::make_unique<RawRegParam>(Registers::makeDReg(reg), RegParamMode::Direct);
    case DirectAddrReg: /* "An" */
        if (size == OperandSize::Byte)
        {
            // TODO: Document why this is always illegal.
            return nullptr;
        }
        return std::make_unique<RawRegParam>(Registers::makeAReg(reg), RegParamMode::Direct);
    case Indirect: /* (An) */
        return std::make_unique<RawRegParam>(Registers::makeAReg(reg), RegParamMode::Indirect);
    case PostIncrement: /* (An)+ */
        return std::make_unique<RawRegParam>(Registers::makeAReg(reg), RegParamMode::PostIncrement);
    case PreDecrement: /* -(An) */
        return std::make_unique<RawRegParam>(Registers::makeAReg(reg), RegParamMode::PreDecrement);
    case Displacement: /* d16(An)*/
        return parseDisplacementParam(state, Registers::makeAReg(reg));
    case Index: /* d8(An,Xn) */
        return parseIndexParam(state, Registers::makeAReg(reg));
    case Special:
        switch (reg)
        {
        case AbsoluteWord: /* (xxx).W */
            return parseAbsoluteParam(state, OperandSize::Word);
        case AbsoluteLong: /* (xxx).L */
            return parseAbsoluteParam(state, OperandSize::Long);
        case ImmediateData: /* #xxx */
            return parseImmediateParam(state, size);
        case PcDisplacement: /* d16(PC) */
            return parseDisplacementParam(state, Register::PC);
        case PcIndex: /* d8(PC,Xn) */
            return parseIndexParam(state, Register::PC);
        default:
            throw std::runtime_error("Unknown sub-mode error");
        }
    default:
        throw std::runtime_error("Unknown mode error");
    }
}

char getnext_b(struct cmd_items* ci, struct parse_state* state)

{
    char b = state->Module->read<char>();

    if (state->Module->eof())
    {
        throw std::runtime_error("Error reading file: Unexpected EOF");
    }

    state->PCPos++;
    /* We won't store this into the buffers
     * as it is not a command */
    return b;
}

bool hasnext_w(struct parse_state* state)
{
    return state->Module->size() >= 2;
}

/*
 * Fetches the next word (an Extended Word) from the module
 * Passed: The struct cmd_items pointer
 * Returns: the word retrieved
 *
 * The PCPos is updated, the count of words in the instruction is updated and
 *    the word is stored in the proper Info->code position
 */
int getnext_w(struct cmd_items* ci, struct parse_state* state)
{
    int16_t w = state->Module->read<int16_t>();
    if (state->Module->eof())
    {
        throw std::runtime_error("Error reading file: Unexpected EOF");
    }
    state->PCPos += 2;
    ci->rawData[ci->rawDataSize] = w;
    ci->rawDataSize += 1;
    return w;
}

/*
 * ungetnext_w() - ungets (undoes) a previous word-get.
 * Passed: Pointer to the struct cmd_items struct
 */
void ungetnext_w(struct cmd_items* ci, struct parse_state* state)
{
    state->Module->undo();
    state->PCPos -= 2;
    ci->rawDataSize -= 1;
}

/*
 * Fetches the next word (an Extended Word) from the module
 * Passed: The struct cmd_items pointer
 * Returns: the word retrieved
 *
 * The PCPos is updated.
 */
uint16_t getnext_w_raw(parse_state* state)
{
    uint16_t ret = state->Module->read<uint16_t>();
    if (state->Module->eof())
    {
        throw std::runtime_error("Error reading file: Unexpected EOF");
    }
    state->PCPos += 2;
    return ret;
}

void ungetnext_w_raw(parse_state* state)
{
    state->Module->undo();
    state->PCPos -= 2;
}

bool hasnext_l(parse_state* state)
{
    return state->Module->size() >= 4;
}

uint32_t getnext_l_raw(parse_state* state)
{
    uint32_t ret = state->Module->read<uint32_t>();
    if (state->Module->eof())
    {
        throw std::runtime_error("Error reading file: Unexpected EOF");
    }
    state->PCPos += 4;
    return ret;
}

void ungetnext_l_raw(parse_state* state)
{
    state->Module->undo();
    state->PCPos -= 4;
}