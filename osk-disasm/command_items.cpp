
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
    ci->lblname = NULL; // I added this line
    return ci;
}

/*
 * Functions that deal with a register and hold the reg #
 * in the command word, and also have an effective address
 */
int reg_ea(struct cmd_items* ci, int j, const struct opst* op, struct parse_state* state)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    int size = (ci->cmd_wrd >> 7) & 3;
    char ea[50];
    char* regname = "d";

    /* Eliminate illegal Addressing modes */
    switch (op->id)
    {
    case 30:  /* chk */
    case 137: /* chk 68020 */
        switch (size)
        {
        case 2:
            size = SIZ_LONG;
            break;
        case 3:
            size = SIZ_WORD;
            break;
        default:
            return 0;
        }

        break;
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
    }

    switch (op->id)
    {
    default:
        break; /* Already checked above */
    }

    if (j == 31)
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

/*
 * Format a range of registers (``low'' to ``high'')
 * into ``s'', beginning with a ``slash'' if necessary.
 * ``ad'' specifies either address (A) or data (D) registers.
 */
static char* regwrite(char* s, char* ad, int low, int high, int slash)
{

    if (slash) *s++ = '/';

    if (high - low >= 1)
    {
        s += sprintf(s, "%s", ad);
        *s++ = low + '0';
        *s++ = '-';
        s += sprintf(s, "%s", ad);
        *s++ = high + '0';
    }
    else if (high - low == 1)
    {
        s += sprintf(s, "%s", ad);
        *s++ = low + '0';
        *s++ = '/';
        s += sprintf(s, "%s", ad);
        *s++ = high + '0';
    }
    else
    {
        s += sprintf(s, "%s", ad);
        *s++ = high + '0';
    }

    *s = '\0';
    return s;
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

int movem_cmd(struct cmd_items* ci, int j, const struct opst* op, struct parse_state* state)
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

int link_unlk(struct cmd_items* ci, int j, const struct opst* op, struct parse_state* state)
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
        ext_w = getnext_w(ci, state);

        if (j == 138)
        {
            ext_w = (ext_w << 8) | (getnext_w(ci, state) & 0xff);
        }

        sprintf(ci->params, "A%d,#%d", regno, ext_w);
        strcat(ci->mnem, (j == 46) ? "w" : "l");
    }

    return 1;
}

/*
 * Retrieves the extended command word, and sets up
 *      the values.
 * Returns 1 if valid, 0 if cpu < 68020 && is Full Extended Word
 */
int get_ext_wrd(struct cmd_items* ci, struct extWbrief* extW, int mode, int reg, struct parse_state* state)
{
    int ew; /* A local copy of the extended word (stored in ci->code[0]) */

    ew = getnext_w(ci, state);

    if ((state->cpu < 20) && (ew & 0x0100))
    {
        ungetnext_w(ci, state);
        return 0;
    }

    /* get the values common to all */
    extW->isLong = (ew >> 11) & 1;
    extW->scale = (ew >> 9) & 3;
    extW->regno = (ew >> 12) & 7;
    extW->isFull = (ew >> 8) & 1;
    extW->regNam = dispRegNam[(ew >> 15) & 1];

    if (extW->isFull)
    {
        if (ew & 0x08) /* Bit 3 must be 0 */
        {
            ungetnext_w(ci, state);
            return 0;
        }

        extW->iiSel = ew & 7;
        extW->bs = (ew >> 7) & 1;
        extW->is = (ew >> 6) & 1;

        if ((extW->bdSize = (ew >> 4) & 3) == 0)
        {
            ungetnext_w(ci, state);
            return 0;
        }

        extW->displ = 0;
    }
    else
    {
        extW->displ = ew & 0xff;

        if (extW->displ & 0x80)
        {
            extW->displ = extW->displ | (-1 ^ 0xff);
        }
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

    dispstr[0] = '\0';
    ea_addr = PCPos;

    /* Set up PBytSiz */
    switch (size)
    {
    case SIZ_BYTE:
        PBytSiz = 1;
        break;
    case SIZ_WORD:
        PBytSiz = 2;
        break;
    case SIZ_LONG:
        PBytSiz = 4;
        break;
    }

    std::unique_ptr<InstrParam> param;

    switch (mode)
    {
        MODE_STR* a_pt;
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
    {
        char* label = nullptr;
        AMode = AM_A0 + reg;
        ext1 = getnext_w(ci, state);

        /* The system biases the data Pointer (a6) by 0x8000 bytes,
         * so compensate
         */

        if (reg == 6 && modHeader && modHeader->type == MT_PROGRAM)
        {
            ext1 += 0x8000;
        }

        /* NOTE:: NEED TO TAKE INTO ACCOUNT WHEN DISPLACEMENT IS A LABEL !!! */
        if (LblCalc(dispstr, ext1, AMode, ea_addr, state->opt->IsROF))
        {
            label = dispstr;
        }

        param = std::make_unique<RegOffsetParam>(Registers::makeAReg(reg), ext1, label);

        // `0(An)` and `(An)` assemble to different instructions.
        ((RegOffsetParam*)param.get())->setShouldForceZero(true);

        break;
    }
    case 6: /* d{8}(An,Xn) or 68020-up */
        if (get_ext_wrd(ci, &ew_b, mode, reg, state))
        {
            if (state->cpu < 20 && ew_b.scale != 0)
            {
                ungetnext_w(ci, state);
                return 0;
            }
            auto addressReg = Registers::makeAReg(reg);
            auto offsetReg = ew_b.regNam == 'a' ? Registers::makeAReg(ew_b.regno) : Registers::makeDReg(ew_b.regno);
            auto offsetRegSize = ew_b.isLong ? OperandSize::Long : OperandSize::Word;
            char* label = nullptr;
            if (ew_b.displ != 0)
            {
                // ew_b.displ -= 2;
                if (LblCalc(dispstr, ew_b.displ, AM_A0 + reg, PCPos - 2, state->opt->IsROF))
                {
                    label = dispstr;
                }
            }
            if (ew_b.isFull)
            {
                return process_extended_word_full(ci, ea, &ew_b, mode, reg, size, state);
            }
            else
            {
                param = std::make_unique<RegOffsetParam>(addressReg, offsetReg, offsetRegSize, ew_b.scale, ew_b.displ,
                                                         label);
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
            char* label = nullptr;
            OperandSize opSize;
            int amode_local;
            if (reg == 0)
            {
                opSize = OperandSize::Word;
                ext1 = getnext_w(ci, state);
                amode_local = AM_SHORT;
            }
            else
            {
                opSize = OperandSize::Long;
                ext1 = getnext_w(ci, state);
                ext1 = (ext1 << 16) | (getnext_w(ci, state) & 0xffff);
                amode_local = AM_LONG;
            }
            if (LblCalc(dispstr, ext1, amode_local, ea_addr, state->opt->IsROF))
            {
                label = dispstr;
            }
            param = std::make_unique<AbsoluteAddrParam>(ext1, label, opSize);
            break;
        }
        case 4: /* #<data> */
        {
            AMode = AM_IMM;
            ref_ptr = PCPos;
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
                ext2 = getnext_w(ci, state);
                ext1 = (ext1 << 16) | (ext2 & 0xffff);
                break;
            }

            if (rof_setup_ref(refs_code, ref_ptr, dispstr, ext1))
            {
                sprintf(ea, Mode07Strings[reg].str, dispstr);
                return 1;
            }

            // This uses too many global variables to be replaced by LiteralParam.
            LblCalc(dispstr, ext1, AMode, ea_addr, state->opt->IsROF);
            sprintf(ea, Mode07Strings[reg].str, dispstr);
            return 1;
        }
        case 2: /* (d16,PC) */
        {
            char* label = nullptr;
            ext1 = getnext_w(ci, state);
            if (LblCalc(dispstr, ext1, AM_REL, ea_addr, state->opt->IsROF))
            {
                label = dispstr;
            }
            param = std::make_unique<RegOffsetParam>(Register::REG_PC, ext1, label);
            break;
        }
        case 3: /* d8(PC,Xn) */
            if (get_ext_wrd(ci, &ew_b, mode, reg, state))
            {
                if (state->cpu < 20 && ew_b.scale != 0)
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
                    if (LblCalc(dispstr, ew_b.displ, AM_REL, PCPos - 2, state->opt->IsROF))
                    {
                        label = dispstr;
                    }
                }
                if (ew_b.isFull)
                {
                    return process_extended_word_full(ci, ea, &ew_b, mode, reg, size, state);
                }
                else
                {
                    param = std::make_unique<RegOffsetParam>(Register::REG_PC, offsetReg, offsetRegSize, ew_b.scale,
                                                             ew_b.displ, label);
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

/*
 * Process the extended word for indexed modes
 */
int process_extended_word_full(struct cmd_items* ci, char* dststr, struct extWbrief* ew, int mode, int reg, int size,
                               struct parse_state* state)
{
    char base_str[50];
    char idx_reg[20];
    char od_str[30];

    /* Base Displacement */
    base_str[0] = '\0';

    /* Base Register */

    if (ew->bdSize > 1)
    {
        int pcadj;

        get_displ(ci, base_str, ew->bdSize, state);

        if (mode == 7) /* Adjust for PC-Rel mode */
        {
            sscanf(base_str, "%d", &pcadj);
            sprintf(base_str, "%d", pcadj - 2);
        }
    }

    if (ew->bs == 0) /* If not suppressed ... */
    {
        char br_str[3];

        if (strlen(base_str))
        {
            strcat(base_str, ",");
        }

        switch (mode)
        {
        case 6:
            sprintf(br_str, "a%d", reg);
            strcat(base_str, br_str);
            break;
        case 7:
            strcat(base_str, "pc");
        }
    }

    /* Index Register */
    idx_reg[0] = '\0';

    if (!ew->is)
    {
        sprintf(idx_reg, "%c%d.%c", ew->regNam, ew->regno, ew->isLong ? 'l' : 'w');

        if (ew->scale)
        {
            register int s = 1;
            register int m = ew->scale;

            while (m--)
            {
                s *= 2;
            }

            sprintf(&idx_reg[strlen(idx_reg)], "*%d", s);
        }
    }

    /* Outer Displacement */
    od_str[0] = '\0';

    if ((ew->iiSel & 3) > 1)
    {
        get_displ(ci, od_str, ew->iiSel & 3, state);
    }

    if (ew->is == 0)
    {
        switch (ew->iiSel & 4)
        {
        case 0: /* PreIndexed */
            if ((strlen(base_str)) && (strlen(idx_reg)))
            {
                strcat(base_str, ",");
                strcat(base_str, idx_reg);
            }
            else if (strlen(idx_reg)) /* no base_str */
            {
                strcpy(base_str, idx_reg);
            }

            if (strlen(od_str))
            {
                strcpy(idx_reg, od_str);
            }
            else
            {
                idx_reg[0] = '\0';
            }

            break;
        default: /* PostIndexed */
            if ((strlen(idx_reg)) && (strlen(od_str)))
            {
                strcat(idx_reg, ",");
                strcat(idx_reg, od_str);
            }
            else if (strlen(od_str))
            {
                strcpy(idx_reg, od_str);
            }
        }
    }
    else /* else ew->is = 1 */
    {
        if (ew->iiSel >= 4)
        {
            while (ci->wcount)
            {
                ungetnext_w(ci, state);
            }

            return 0;
        }

        /* We have base_str already - empty string if no bd or reg */

        if (strlen(od_str))
        {
            strcpy(idx_reg, od_str);
        }
    }

    if (ew->iiSel & 7)
    {
        sprintf(dststr, "([%s]", base_str);
    }
    else
    {
        sprintf(dststr, "(%s", base_str);
    }

    if (strlen(idx_reg))
    {
        if (strlen(base_str) || (ew->iiSel & 3))
        {
            strcat(dststr, ",");
        }

        strcat(dststr, idx_reg);
    }

    strcat(dststr, ")");

    return 1;
}

/*
 * get_displ() - Get the displacement for either the base displacement
 *          or the outer displacement, if not suppressed
 */
void get_displ(struct cmd_items* ci, char* dst, int siz_flag, struct parse_state* state)
{
    switch (siz_flag)
    {
    case 2: /* Word Displacement */
        sprintf(dst, "%d.w", getnext_w(ci, state));
        break;
    case 3: /* Long Displacement */
        sprintf(dst, "%d", (getnext_w(ci, state) << 16) | (getnext_w(ci, state) & 0xffff));
        break;
    default:
        break;
    }
}

/*
 *     Sets up the string for the Index register for
 *     Indirect Addressing mode for either
 *     Address register or PC
 * Passed:  (1) dest - The location to store the string
 *          (2) extW - The extWbrief struct containing the
 *                     extended word information.
 * Returns: Pointer to the newly-filled dest
 *
 */
int set_indirect_idx(char* dest, struct extWbrief* extW, int cpu)
{

    /* Scale not allowed for < 68020 */
    /* Note: we might be able to ignore this */
    if (cpu < 20)
    {
        if (extW->scale)
        {
            return 0;
        }
    }

    sprintf(dest, "%c%d.%c", extW->regNam, extW->regno, extW->isLong ? 'l' : 'w');
    /**dest = extW->regNam;
    dest[1] = '\0';
    sprintf (rgnum, "%d", extW->regno);
    strcat (dest, rgnum);
    strcat (dest, extW->isLong ? ".l" : ".w");*/

    switch (extW->scale)
    {
    default:
        break; /* No need to specify scale if it's 1 */
    case 1:
        strcat(dest, "*2");
        break;
    case 2:
        strcat(dest, "*4");
        break;
    case 3:
        strcat(dest, "*8");
        break;
    }

    return 1;
}

/*
 * Gets the extended data, sets up the ea for calls
 *       where the size is the 3 MS=bits of the lower byte of the command,
 *       and the EA is the lower 5 bytes of the command word.
 * Passed: (1) - the command items structure
 *         (2) - the mnemonic for the call.  This routine adds the size
 *               descriptor
 */
int get_extends_common(struct cmd_items* ci, char* mnem, struct parse_state* state)
{
    int mode, reg;
    int size;
    char addr_mode[20]; /* Destination for the opcode */

    mode = (ci->cmd_wrd >> 3) & 7;
    reg = ci->cmd_wrd & 7;
    size = (ci->cmd_wrd >> 6) & 3;

    get_eff_addr(ci, addr_mode, mode, reg, size, state);
    getnext_w(ci, state);

    if (size > 1)
    {
        getnext_w(ci, state);
    }

    return 1;
}

/*
 * Returns 0 if the addressing mode is anything but a Control addressing mode
 */
int ctl_addrmodesonly(int mode, int reg)
{
    if ((mode < 2) || (mode == 4) || (mode == 8)) return 0;

    if (mode == 7)
    {
        if (mode == 4) return 0;
    }

    return 1;
}

char getnext_b(struct cmd_items* ci, struct parse_state* state)

{
    char b;

    if (fread(&b, 1, 1, state->ModFP) < 1)
    {
        filereadexit();
    }

    ++PCPos;
    /* We won't store this into the buffers
     * as it is not a command */
    return b;
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
    short w;

    w = fread_w(state->ModFP);
    PCPos += 2;
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
    fseek(state->ModFP, -2, SEEK_CUR);
    PCPos -= 2;
    ci->wcount -= 1;
}