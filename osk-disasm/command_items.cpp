
#include "command_items.h"

#include <sstream>
#include <string.h>
#include <string>

#include "commonsubs.h"
#include "disglobs.h"
#include "dismain.h"
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

extern const char dispRegNam[] = {'d', 'a'};

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

struct cmd_items Instruction;

const char* SizSufx[] = {"b", "w", "l"};

typedef struct modestrs
{
    const char* str;
    int CPULvl;
} MODE_STR;

MODE_STR ModeStrings[] = {{"d%d", 0},    {"a%d", 0},     {"(a%d)", 0},     {"(a%d)+", 0},
                          {"-(a%d)", 0}, {"%s(a%d)", 0}, {"%s(a%d,%s)", 0}};

/* The above strings for when the register is A7 (sp) */
MODE_STR SPStrings[] = {{"", 99999}, /* Should never be used */
                        {"sp", 0},   {"(sp)", 0}, {"(sp)+", 0}, {"-(sp)", 0}, {"%s(sp)", 0}, {"%s(sp,%s)", 0}};

/* Need to add for 68020-up modes.  Don't know if they can be included in these two arrays or not..*/
MODE_STR Mode07Strings[] = {{"(%s).w", 0}, {"(%s).l", 0}, {"%s(pc)", 0}, {"%s(pc,%s)", 0}, {"#%s", 0}};

MODE_STR Mode020Strings[] = {
    {"(%s,A%d)"},        /* (disp.w,An) */
    {"(%s,%s,%s)"},      /* (bd,An,Xn) | (bd,PC,Xn) */
    {"([%d,%s],%s,%d)"}, /* ([bd,An],Xn,disp) | ([bd,PC],Xn,disp) */
    {"([%d,%s,%s],%d)"}, /* ([bd,An,Xn],disp) | ([bd,PC,Xn],disp) */
};

// This function is named "init cmd items" but it does not init cmd items.
struct cmd_items* initcmditems(struct cmd_items* ci)
{
    ci->mnem[0] = 0;
    ci->wcount = 0;
    ci->params[0] = '\0';
    ci->comment = NULL;
    ci->lblname.clear(); // I added this line
    return ci;
}

/*
 * Functions that deal with a register and hold the reg #
 * in the command word, and also have an effective address
 */
int reg_ea(struct cmd_items* ci, const struct opst* op, struct parse_state* state)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    int size = (ci->cmd_wrd >> 7) & 3;
    char ea[50];
    char* regname = "d";

    /* Eliminate illegal Addressing modes */
    switch (op->id)
    {
    case 30: /* chk */
    case 70: /* divu */
    case 71: /* divs */
    case 79: /* mulu */
    case 80: /* muls */
        if ((mode == 1)) return 0;
        break;

    case 31: /* lea */
        if ((mode < 2) || (mode == 3) || (mode == 4)) return 0;
        if ((mode == 7) && (reg == 4)) return 0;
        size = SIZ_LONG;
    default:
        break; /* Already checked above */
    }

    if (op->id == 31)
    {
        regname = "a";
    }

    if (get_eff_addr(ci, ea, mode, reg, size, state))
    {
        std::ostringstream buffer;
        buffer << ea << ',' << regname[0] << ((ci->cmd_wrd >> 9) & 7);
        auto bufferStr = buffer.str();
        strcpy(ci->params, bufferStr.c_str());
        strcpy(ci->mnem, op->name);

        switch (size)
        {
        case SIZ_BYTE:
            strcat(ci->mnem, "b");
            break;
        case SIZ_WORD:
            strcat(ci->mnem, "w");
            break;
        case SIZ_LONG:
            strcat(ci->mnem, "l");
            break;
        default:
            ci->mnem[strlen(ci->mnem) - 1] = '\0';
        }

        return 1;
    }

    return 0;
}

static std::unique_ptr<RegisterSet> reglist(uint16_t regmask, int mode)
{
    if (mode == 4)
    {
        regmask = revbits(regmask, 16);
    }

    uint8_t addressByte = regmask >> 8;
    uint8_t dataByte = regmask & 0xFF;

    // RegisterSet registers(addressByte, dataByte);
    // stream << registers;
    return std::make_unique<RegisterSet>(addressByte, dataByte);
}

int movem_cmd(struct cmd_items* ci, const struct opst* op, struct parse_state* state)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    int size = (ci->cmd_wrd & 0x40) ? SIZ_LONG : SIZ_WORD;
    char ea[50];
    int dir = (ci->cmd_wrd >> 10) & 1;
    int regmask;

    if (mode < 2) /* Common to both modes */
    {
        return 0;
    }

    if (dir)
    {
        if (mode == 4) return 0;
        if ((mode == 7) && (reg == 4)) return 0;
    }
    else
    {
        if (mode == 3) return 0;
        if ((mode == 7) && (reg > 1)) return 0;
    }

    if (!hasnext_w(state)) return 0;
    regmask = getnext_w(ci, state);

    if (!get_eff_addr(ci, ea, mode, reg, size, state))
    {
        ungetnext_w(ci, state);
        return 0;
    }

    std::ostringstream mneumonic;
    mneumonic << op->name << SizSufx[size];
    auto mneumonicResult = mneumonic.str();
    strcpy(ci->mnem, mneumonicResult.c_str());

    std::ostringstream params;
    if (dir)
    {
        params << ea << ',' << *reglist(regmask, mode);
    }
    else
    {
        params << *reglist(regmask, mode) << ',' << ea;
    }
    auto paramsResult = params.str();
    strcpy(ci->params, paramsResult.c_str());

    return 1;
}

int link_unlk(struct cmd_items* ci, const struct opst* op, struct parse_state* state)
{
    int regno = ci->cmd_wrd & 7;
    int ext_w;

    strcpy(ci->mnem, op->name);

    switch (op->id)
    {
    case 47: /* "unlink: only needs regno for the opcode */
        sprintf(ci->params, "A%d", regno);

        if ((ci->mnem[strlen(ci->mnem) - 1]) == '.')
        {
            ci->mnem[strlen(ci->mnem) - 1] = '\0';
        }

        break;
    default:
        if (!hasnext_w(state)) return 0;
        ext_w = getnext_w(ci, state);

        if (op->id == 138)
        {
            if (!hasnext_w(state)) return 0;
            ext_w = (ext_w << 8) | (getnext_w(ci, state) & 0xff);
        }

        sprintf(ci->params, "A%d,#%d", regno, ext_w);
        strcat(ci->mnem, (op->id == 46) ? "w" : "l");
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
    extW->regNam = dispRegNam[(ew >> 15) & 1];

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
int get_eff_addr(struct cmd_items* ci, char* ea, int mode, int reg, int size, struct parse_state* state)
{
    int ext1;
    int ext2;
    int ref_ptr;
    char dispstr[50];
    struct extWbrief ew_b;
    int ea_addr;
    uint8_t PBytSiz_local;

    dispstr[0] = '\0';
    ea_addr = state->PCPos;
    bool pbytsizIsValid = true;

    /* Set up PBytSiz_local */
    switch (size)
    {
    case SIZ_BYTE:
        PBytSiz_local = 1;
        break;
    case SIZ_WORD:
        PBytSiz_local = 2;
        break;
    case SIZ_LONG:
        PBytSiz_local = 4;
        break;
    default:
        // This needs to be set to a value (any value). It's only used for hexadecimal
        // sizes, and nothing else.
        PBytSiz_local = 4;
        break;
    }

    std::unique_ptr<InstrParam> param;

    switch (mode)
    {
    default:
        return 0;
    case 0: /* "Dn" */
        param = std::make_unique<RegParam>(Registers::makeDReg(reg));
        break;
    case 1: /* "An" */
        if (size < SIZ_WORD) return 0;
    case 2: /* (An) */
    case 3: /* (An)+ */
    case 4: /* -(An) */
        param = std::make_unique<RegParam>(Registers::makeAReg(reg), static_cast<RegParamMode>(mode - 1));
        break;
    case 5: /* d{16}(An) */
        if (!hasnext_w(state)) return 0;
        ext1 = getnext_w(ci, state);

        /* The system biases the data Pointer (a6) by 0x8000 bytes,
         * so compensate
         */

        if (reg == 6 && !state->opt->IsROF && state->opt->modHeader->type == MT_PROGRAM)
        {
            ext1 += 0x8000;
        }

        /* NOTE:: NEED TO TAKE INTO ACCOUNT WHEN DISPLACEMENT IS A LABEL !!! */
        if (LblCalc(dispstr, ext1, AM_A0 + reg, ea_addr, state->opt->IsROF, state->Pass))
        {
            param = std::make_unique<RegOffsetParam>(Registers::makeAReg(reg), std::string(dispstr));
        }
        else
        {
            // Temporary
            auto number = MakeFormattedNumber(ext1, AM_A0 + reg, PBytSiz_local);
            param = std::make_unique<RegOffsetParam>(Registers::makeAReg(reg), number);
        }

        // `0(An)` and `(An)` assemble to different instructions.
        ((RegOffsetParam*)param.get())->setShouldForceZero(true);

        break;
    case 6: /* d{8}(An,Xn) */
        if (get_ext_wrd(ci, &ew_b, mode, reg, state))
        {
            if (ew_b.scale != 0)
            {
                ungetnext_w(ci, state);
                return 0;
            }
            auto addressReg = Registers::makeAReg(reg);
            auto offsetReg = ew_b.regNam == 'a' ? Registers::makeAReg(ew_b.regno) : Registers::makeDReg(ew_b.regno);
            auto offsetRegSize = ew_b.isLong ? OperandSize::Long : OperandSize::Word;
            if (ew_b.displ != 0)
            {
                // ew_b.displ -= 2;
                int amode = AM_A0 + reg;
                if (LblCalc(dispstr, ew_b.displ, amode, state->PCPos - 2, state->opt->IsROF, state->Pass))
                {
                    param =
                        std::make_unique<RegOffsetParam>(addressReg, offsetReg, offsetRegSize, std::string(dispstr));
                }
                else
                {
                    auto number = MakeFormattedNumber(ew_b.displ, amode, PBytSiz_local);
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
            return 0;
        }

        break;

        /* We now go to mode %111, where the mode is determined
         * by the register field
         */
    case 7:
        switch (reg)
        {
        case 0: /* (xxx).W */
        case 1: /* (xxx).L */
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
            if (LblCalc(dispstr, ext1, amode_local, ea_addr, state->opt->IsROF, state->Pass))
            {
                param = std::make_unique<AbsoluteAddrParam>(std::string(dispstr), opSize);
            }
            else
            {
                auto number = MakeFormattedNumber(ext1, amode_local, PBytSiz_local);
                param = std::make_unique<AbsoluteAddrParam>(number, opSize);
            }

            break;
        }
        case 4: /* #<data> */
        {
            ref_ptr = state->PCPos;
            if (!hasnext_w(state)) return 0;
            ext1 = getnext_w(ci, state);

            switch (size)
            {
            case SIZ_BYTE:
                if ((ext1 < -128) || (ext1 > 0xff))
                {
                    ungetnext_w(ci, state);
                    return 0;
                }

                break;
            case SIZ_WORD:
                if ((ext1 < -32768) || (ext1 > 0xffff))
                {
                    ungetnext_w(ci, state);
                    return 0;
                }

                break;
            case SIZ_LONG:
                if (!hasnext_w(state)) return 0;
                ext2 = getnext_w(ci, state);
                ext1 = (ext1 << 16) | (ext2 & 0xffff);
                break;
            }

            if (rof_setup_ref(refs_code, ref_ptr, dispstr, ext1))
            {
                char temp[200];
                temp[0] = '\0';
                sprintf(temp, Mode07Strings[reg].str, dispstr);
                param = std::make_unique<LiteralParam>(std::string(temp));
            }
            else if (LblCalc(dispstr, ext1, AM_IMM, ea_addr, state->opt->IsROF, state->Pass))
            {
                param = std::make_unique<LiteralParam>(std::string(dispstr));
            }
            else
            {
                auto number = MakeFormattedNumber(ext1, AM_IMM, PBytSiz_local);
                param = std::make_unique<LiteralParam>(number);
            }
            break;
        }
        case 2: /* (d16,PC) */
            if (!hasnext_w(state)) return 0;
            ext1 = getnext_w(ci, state);
            if (LblCalc(dispstr, ext1, AM_REL, ea_addr, state->opt->IsROF, state->Pass))
            {
                param = std::make_unique<RegOffsetParam>(Register::REG_PC, std::string(dispstr));
            }
            else
            {
                auto number = MakeFormattedNumber(ext1, AM_REL, PBytSiz_local);
                param = std::make_unique<RegOffsetParam>(Register::REG_PC, number);
            }
            break;
        case 3: /* d8(PC,Xn) */
            if (get_ext_wrd(ci, &ew_b, mode, reg, state))
            {
                if (ew_b.scale != 0)
                {
                    ungetnext_w(ci, state);
                    return 0;
                }
                auto offsetReg = ew_b.regNam == 'a' ? Registers::makeAReg(ew_b.regno) : Registers::makeDReg(ew_b.regno);
                auto offsetRegSize = ew_b.isLong ? OperandSize::Long : OperandSize::Word;
                char* label = nullptr;
                if (ew_b.displ != 0)
                {
                    ew_b.displ -= 2;
                    if (LblCalc(dispstr, ew_b.displ, AM_REL, state->PCPos - 2, state->opt->IsROF, state->Pass))
                    {
                        param = std::make_unique<RegOffsetParam>(Register::REG_PC, offsetReg, offsetRegSize,
                                                                 std::string(dispstr));
                    }
                    else
                    {
                        // TODO: Is the -2 to displacement correct here?
                        auto number = MakeFormattedNumber(ew_b.displ, AM_REL, PBytSiz_local);
                        param = std::make_unique<RegOffsetParam>(Register::REG_PC, offsetReg, offsetRegSize, number);
                    }
                }
                else
                {
                    // The PC-1 is due to the 8-bit offset placed in the 2nd byte of the brief
                    // extension word.
                    if (state->opt->IsROF && IsRef(dispstr, state->PCPos - 1, 0, state->Pass))
                    {
                        param = std::make_unique<RegOffsetParam>(Register::REG_PC, offsetReg, offsetRegSize,
                                                                 std::string(dispstr));
                    }
                    else
                    {
                        param = std::make_unique<RegOffsetParam>(Register::REG_PC, offsetReg, offsetRegSize,
                                                                 FormattedNumber(0));
                    }
                }
            }
            else
            {
                return 0;
            }

            break;
        }
        break;
    }

    // return 0; /* Return 0 means no effective address was found */
    if (param)
    {
        strcpy(ea, param->toStr().c_str());
        return 1;
    }
    return 0;
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
    ci->code[ci->wcount] = w;
    ci->wcount += 1;
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
    ci->wcount -= 1;
}