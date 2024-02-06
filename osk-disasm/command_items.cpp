
#include "pch.h"

#include "command_items.h"

#include <string.h>

#include "commonsubs.h"
#include "disglobs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "main_support.h"
#include "modtypes.h"
#include "params.h"
#include "rof.h"

#define LABEL_LEN 200
#define MNEM_LEN 50
#define CODE_LEN 10
#define OPCODE_LEN 200
#define COMMENT_LEN 200

/*
struct cmd_items_inner {
    int cmd_wrd;        // The single effective address word (the command)
    char lblname[LABEL_LEN];
    char mnem[MNEM_LEN];
    short code[CODE_LEN];
    int wcount;         // The count of words in the instrct/.(except sea)
    char opcode[OPCODE_LEN];   // Possibly ovesized, but just to be safe
    char comment[COMMENT_LEN];     // Inline comment - NULL if none
    struct extWbrief extend;   // The extended command (if present)
};
*/

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

cmd_items& cmd_items::operator=(struct cmd_items&& other)
{
    lblname = std::move(other.lblname);
    mnem = std::move(other.mnem);
    comment = other.comment;
    source.swap(other.source);
    dest.swap(other.dest);
    memcpy_s(rawData, 10, other.rawData, 10);
    rawDataSize = other.rawDataSize;

    return *this;
}

/*
 * Functions that deal with a register and hold the reg #
 * in the command word, and also have an effective address
 */
int reg_ea(struct cmd_items* ci, const struct opst* op, struct parse_state* state)
{
    uint8_t sourceMode = (ci->cmd_wrd >> 3) & 7;
    uint8_t sourceReg = ci->cmd_wrd & 7;
    uint8_t destRegCode = (ci->cmd_wrd >> 9) & 7;
    int size = (ci->cmd_wrd >> 7) & 3;

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
        size = SIZ_LONG;
        break;
    default:
        throw std::runtime_error("Unexpected instruction id");
    }

    // Determine operand size
    switch (op->id)
    {
    case InstrId::CHK:
        switch (size)
        {
        case 0b11:
            size = SIZ_WORD;
            break;
        case 0b10:
            size = SIZ_LONG;
            break;
        default:
            return 0;
        }
        break;
    case InstrId::DIVS:
    case InstrId::DIVU:
    case InstrId::MULS:
    case InstrId::MULU:
        size = SIZ_WORD;
        break;
    case InstrId::LEA:
        size = SIZ_LONG;
        break;
    default:
        throw std::runtime_error("Unexpected instruction id");
    }

    ci->source = get_eff_addr(ci, sourceMode, sourceReg, size, state);
    if (!ci->source) return 0;

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

int cmd_movem(struct cmd_items* ci, const struct opst* op, struct parse_state* state)
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

    auto eaParam = get_eff_addr(ci, mode, reg, size, state);
    if (!eaParam) return 0;

    auto mnem = std::string(op->name) + OperandSizes::getLetter(size);
    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(size);

    if (regsAreDest)
    {
        ci->source = std::move(eaParam);
        ci->setDest(MultiRegParam(reglist(regmask, mode)));
    }
    else
    {
        ci->setSource(MultiRegParam(reglist(regmask, mode)));
        ci->dest = std::move(eaParam);
    }
    return 1;
}

int link_unlk(struct cmd_items* ci, const struct opst* op, struct parse_state* state)
{
    auto reg = Registers::makeAReg(ci->cmd_wrd & 7);
    ci->mnem = op->name;

    if (op->id == InstrId::UNLK)
    {
        // strcpy(ci->params, Registers::getName(reg));
        ci->setSource(RegParam(reg));
    }
    else
    {
        if (!hasnext_w(state)) return 0;
        auto ext_w = getnext_w(ci, state);

        ci->setSource(RegParam(reg));
        ci->setDest(LiteralParam(FormattedNumber(ext_w, OperandSize::Word)));

        // std::ostringstream paramsBuffer;
        // paramsBuffer << Registers::getName(reg) << ",#" << PrettyNumber<int16_t>(ext_w);
        // auto params = paramsBuffer.str();
        // strcpy(ci->params, params.c_str());
    }
    return 1;
}

/*
 * Retrieves the extended command word, and sets up
 *      the values.
 * Returns 1 if valid, 0 if is Full Extended Word (m68020+ only)
 */
int get_ext_wrd(struct cmd_items* ci, struct extWbrief* extW, int mode, int reg, struct parse_state* state)
{
    int ew; /* A local copy of the extended word (stored in ci->code[0]) */
    if (!hasnext_w(state)) return 0;
    ew = getnext_w(ci, state);

    if (ew & 0x0100)
    {
        ungetnext_w(ci, state);
        return 0;
    }

    /* get the values common to all */
    extW->isLong = (ew >> 11) & 1;
    extW->scale = (ew >> 9) & 3;
    extW->regno = (ew >> 12) & 7;
    extW->isAddrReg = ((ew >> 15) & 1) == 1;

    extW->displ = ew & 0xff;

    if (extW->displ & 0x80)
    {
        extW->displ = extW->displ | (-1 ^ 0xff);
    }

    return 1;
}

/*
 * get_eff_addr() - Build the appropriate opcode string for the command
 *     and store it in the command structure opcode string
 */
std::unique_ptr<InstrParam> get_eff_addr(struct cmd_items* ci, uint8_t mode, uint8_t reg, uint8_t size,
                                         struct parse_state* state)
{
    OperandSize opSize;
    switch (size)
    {
    case SIZ_BYTE:
        opSize = OperandSize::Byte;
        break;
    case SIZ_WORD:
        opSize = OperandSize::Word;
        break;
    case SIZ_LONG:
        opSize = OperandSize::Long;
        break;
    default:
        // This needs to be set to a value (any value other than byte). It's only used for
        // hexadecimal sizes, and nothing else.
        opSize = OperandSize::Long;
        break;
    }
    return get_eff_addr(ci, mode, reg, opSize, state);
}

// literalSpaceHint applies to (xxx).w, (xxx).l, and #<data> cases.
std::unique_ptr<InstrParam> get_eff_addr(struct cmd_items* ci, uint8_t mode, uint8_t reg, OperandSize size,
                                         struct parse_state* state, AddrSpaceHandle literalSpaceHint)
{
    int ext1;
    int ext2;
    int ref_ptr;
    struct extWbrief ew_b;
    int ea_addr;

    ea_addr = state->PCPos;
    bool pbytsizIsValid = true;

    std::unique_ptr<InstrParam> param;

    switch (mode)
    {
    case DirectDataReg: /* "Dn" */
        param = std::make_unique<RegParam>(Registers::makeDReg(reg));
        break;
    case DirectAddrReg: /* "An" */
        if (size == OperandSize::Byte) return nullptr;
    case Indirect:      /* (An) */
    case PostIncrement: /* (An)+ */
    case PreDecrement:  /* -(An) */
        param = std::make_unique<RegParam>(Registers::makeAReg(reg), static_cast<RegParamMode>(mode - 1));
        break;
    case Displacement: /* d{16}(An) */
    {
        if (!hasnext_w(state)) return nullptr;
        ext1 = getnext_w(ci, state);

        /* The system biases the data Pointer (a6) by 0x8000 bytes,
         * so compensate
         */

        if (reg == 6 && !state->opt->IsROF && state->opt->modHeader->type == MT_PROGRAM)
        {
            ext1 += 0x8000;
        }

        /* NOTE:: NEED TO TAKE INTO ACCOUNT WHEN DISPLACEMENT IS A LABEL !!! */
        std::string dispstr;
        if (LblCalc(dispstr, ext1, AM_A0 + reg, ea_addr, state->opt->IsROF, state->Pass))
        {
            param = std::make_unique<RegOffsetParam>(Registers::makeAReg(reg), dispstr);
        }
        else
        {
            // Temporary
            auto number = MakeFormattedNumber(ext1, AM_A0 + reg, size);
            param = std::make_unique<RegOffsetParam>(Registers::makeAReg(reg), number);
        }

        // `0(An)` and `(An)` assemble to different instructions.
        ((RegOffsetParam*)param.get())->setShouldForceZero(true);

        break;
    }
    case Index: /* d{8}(An,Xn) */
        if (get_ext_wrd(ci, &ew_b, mode, reg, state))
        {
            if (ew_b.scale != 0)
            {
                ungetnext_w(ci, state);
                return 0;
            }
            auto addressReg = Registers::makeAReg(reg);
            auto offsetReg = ew_b.isAddrReg ? Registers::makeAReg(ew_b.regno) : Registers::makeDReg(ew_b.regno);
            auto offsetRegSize = ew_b.isLong ? OperandSize::Long : OperandSize::Word;
            if (ew_b.displ != 0)
            {
                // ew_b.displ -= 2;
                int amode = AM_A0 + reg;
                std::string dispstr;
                if (LblCalc(dispstr, ew_b.displ, amode, state->PCPos - 2, state->opt->IsROF, state->Pass))
                {
                    param =
                        std::make_unique<RegOffsetParam>(addressReg, offsetReg, offsetRegSize, dispstr);
                }
                else
                {
                    auto number = MakeFormattedNumber(ew_b.displ, amode, size);
                    param = std::make_unique<RegOffsetParam>(addressReg, offsetReg, offsetRegSize, number);
                }
            }
            else
            {
                param = std::make_unique<RegOffsetParam>(addressReg, offsetReg, offsetRegSize, FormattedNumber(0));
            }
        }
        else
        {
            return nullptr;
        }

        break;

        /* We now go to mode %111, where the mode is determined
         * by the register field
         */
    case Special:
        switch (reg)
        {
        case AbsoluteWord: /* (xxx).W */
        case AbsoluteLong: /* (xxx).L */
        {
            OperandSize opSize;
            int amode_local;
            if (reg == 0)
            {
                opSize = OperandSize::Word;
                if (!hasnext_w(state)) return 0;
                ext1 = getnext_w(ci, state);
                amode_local = AM_SHORT;
            }
            else
            {
                opSize = OperandSize::Long;
                if (!hasnext_w(state)) return 0;
                ext1 = getnext_w(ci, state);
                if (!hasnext_w(state)) return 0;
                ext1 = (ext1 << 16) | (getnext_w(ci, state) & 0xffff);
                amode_local = AM_LONG;
            }
            std::string dispstr;
            if (LblCalc(dispstr, ext1, amode_local, ea_addr, state->opt->IsROF, state->Pass))
            {
                param = std::make_unique<AbsoluteAddrParam>(dispstr, opSize);
            }
            else
            {
                auto number = MakeFormattedNumber(ext1, amode_local, size, literalSpaceHint);
                param = std::make_unique<AbsoluteAddrParam>(number, opSize);
            }

            break;
        }
        case ImmediateData: /* #<data> */
        {
            ref_ptr = state->PCPos;
            if (!hasnext_w(state)) return 0;
            ext1 = getnext_w(ci, state);

            switch (size)
            {
            case OperandSize::Byte:
                // We read a word, so byte values should never be negative at this stage
                // (even if they should be interpreted as a signed value later).
                // Even though it's not allowed by the standard, assemblers don't
                // respect that and output 0xFF for negative numbers.
                if ((ext1 < CHAR_MIN) || (ext1 > 0xff))
                {
                    ungetnext_w(ci, state);
                    return 0;
                }

                // The byte is not aligned.
                ref_ptr += 1;

                break;
            case OperandSize::Word:
                // We read exactly 2 bytes, there's no need to check anything.
                break;
            case OperandSize::Long:
                if (!hasnext_w(state)) return 0;
                ext2 = getnext_w(ci, state);
                ext1 = (ext1 << 16) | (ext2 & 0xffff);
                break;
            default:
                throw std::runtime_error("Invalid size");
            }

            std::string dispstr;
            if (rof_setup_ref(dispstr, refManager.refs_code, static_cast<uint32_t>(ref_ptr), ext1))
            {
                dispstr = "#" + dispstr;
                param = std::make_unique<LiteralParam>(dispstr);
            }
            else if (LblCalc(dispstr, ext1, AM_IMM, ea_addr, state->opt->IsROF, state->Pass))
            {
                param = std::make_unique<LiteralParam>(dispstr);
            }
            else
            {
                auto number = MakeFormattedNumber(ext1, AM_IMM, size, literalSpaceHint);
                param = std::make_unique<LiteralParam>(number);
            }
            break;
        }
        case PcDisplacement: /* (d16,PC) */
        {
            if (!hasnext_w(state)) return 0;
            ext1 = getnext_w(ci, state);
            std::string dispstr;
            if (LblCalc(dispstr, ext1, AM_REL, ea_addr, state->opt->IsROF, state->Pass))
            {
                param = std::make_unique<RegOffsetParam>(Register::PC, dispstr);
            }
            else
            {
                auto number = MakeFormattedNumber(ext1, AM_REL, size);
                param = std::make_unique<RegOffsetParam>(Register::PC, number);
            }
            break;
        }
        case PcIndex: /* d8(PC,Xn) */
            if (get_ext_wrd(ci, &ew_b, mode, reg, state))
            {
                if (ew_b.scale != 0)
                {
                    ungetnext_w(ci, state);
                    return nullptr;
                }
                auto offsetReg = ew_b.isAddrReg ? Registers::makeAReg(ew_b.regno) : Registers::makeDReg(ew_b.regno);
                auto offsetRegSize = ew_b.isLong ? OperandSize::Long : OperandSize::Word;
                char* label = nullptr;
                if (ew_b.displ != 0)
                {
                    ew_b.displ -= 2;
                    std::string dispstr;
                    if (LblCalc(dispstr, ew_b.displ, AM_REL, state->PCPos - 2, state->opt->IsROF, state->Pass))
                    {
                        param = std::make_unique<RegOffsetParam>(Register::PC, offsetReg, offsetRegSize,
                                                                 std::string(dispstr));
                    }
                    else
                    {
                        // TODO: Is the -2 to displacement correct here?
                        auto number = MakeFormattedNumber(ew_b.displ, AM_REL, size);
                        param = std::make_unique<RegOffsetParam>(Register::PC, offsetReg, offsetRegSize, number);
                    }
                }
                else
                {
                    // The PC-1 is due to the 8-bit offset placed in the 2nd byte of the brief
                    // extension word.
                    std::string dispstr;
                    if (state->opt->IsROF && IsRef(dispstr, state->PCPos - 1, 0, state->Pass))
                    {
                        param = std::make_unique<RegOffsetParam>(Register::PC, offsetReg, offsetRegSize,
                                                                 std::string(dispstr));
                    }
                    else
                    {
                        param = std::make_unique<RegOffsetParam>(Register::PC, offsetReg, offsetRegSize,
                                                                 FormattedNumber(0));
                    }
                }
            }
            else
            {
                return nullptr;
            }

            break;
        default:
            return 0;
        }
        break;
    default:
        return 0;
    }

    return param;
}

char getnext_b(struct cmd_items* ci, struct parse_state* state)

{
    char b = state->Module->read<char>();

    if (state->Module->eof())
    {
        filereadexit();
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
        filereadexit();
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