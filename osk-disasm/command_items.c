
#include "command_items.h"

#include <string.h>

#include "disglobs.h"
#include "commonsubs.h"
#include "modtypes.h"
#include "exit.h"

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

struct cmd_items Instruction;

char* SizSufx[] = { "b", "w", "l" };

typedef struct modestrs {
    char* str;
    int CPULvl;
} MODE_STR;


MODE_STR ModeStrings[] = {
    {"d%d", 0},
    {"a%d", 0},
    {"(a%d)", 0},
    {"(a%d)+", 0},
    {"-(a%d)", 0},
    {"%s(a%d)", 0},
    {"%s(a%d,%s)", 0}
};

/* The above strings for when the register is A6 (sp) */
MODE_STR SPStrings[] = {
    {"", 99999},    /* Should never be used */
    {"sp",   0},
    {"(sp)", 0},
    {"(sp)+", 0},
    {"-(sp)", 0},
    {"%s(sp)", 0},
    {"%s(sp,%s)", 0}
};

/* Need to add for 68020-up modes.  Don't know if they can be included in these two arrays or not..*/
MODE_STR Mode07Strings[] = {
    {"(%s).w", 0},
    {"(%s).l", 0},
    {"%s(pc)",0},
    {"%s(pc,%s)", 0},
    {"#%s", 0}
};

MODE_STR Mode020Strings[] = {
    {"(%s,A%d)"},           /* (disp.w,An) */
    {"(%s,%s,%s)"},         /* (bd,An,Xn) | (bd,PC,Xn) */
    {"([%d,%s],%s,%d)"},    /* ([bd,An],Xn,disp) | ([bd,PC],Xn,disp) */
    {"([%d,%s,%s],%d)"},    /* ([bd,An,Xn],disp) | ([bd,PC,Xn],disp) */
};

/*
#define HANDLE struct cmd_items*

int instr_getOpWord(HANDLE handle) { return handle->inner->cmd_wrd; }
const char* instr_getLabel(HANDLE handle) { return handle->inner->lblname; }
const char* instr_getMneumonic(HANDLE handle) { return handle->inner->mnem; }
short* instr_getCode(HANDLE handle) { return handle->inner->code; }
int instr_getWordCont(HANDLE handle) { return handle->inner->wcount; }
const char* instr_getOpCode(HANDLE handle) { return handle->inner->params; }
const char* instr_getComment(HANDLE handle) { return handle->inner->comment; }

// Copies the label. Caller is responsible for freeing `name` afterwards, if needed.
void instr_setLabel(HANDLE handle, const char* name) {
    strncpy(handle->inner->lblname, name, LABEL_LEN);
}
// Copies the comment. Caller is responsible for freeing `comment` afterwards, if needed.
void instr_setComment(HANDLE handle, const char* comment) {
    strncpy(handle->inner->comment, comment, COMMENT_LEN);
}

void instr_setOpcode(struct cmd_items* handle, const char* opcode) {
    strncpy(handle->inner->params, opcode, OPCODE_LEN);
}

void instr_setMneumonic(HANDLE handle, const char* s) {
    strncpy(handle->inner->mnem, s, MNEM_LEN);
}

HANDLE instr_new()
{
    struct cmd_items_inner* inner = malloc(sizeof(struct cmd_items_inner));
    if (!inner) {
        errexit("instr_new: OoM");
    }
    HANDLE outer = malloc(sizeof(struct cmd_items));
    if (!outer) {
        errexit("instr_new: OoM");
    }
    outer->inner = inner;
    initcmditems(outer);
    return outer;
}

void instr_delete(HANDLE handle) {
    if (handle)
    {
        if (handle->inner)
        {
            free(handle->inner->comment);
            free(handle->inner->lblname);
            handle->inner->comment = NULL;
            handle->inner->lblname = NULL;
        }
        free(handle->inner);
        handle->inner = NULL;
    }
    free(handle);
}
*/

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

/* ----------------------------------------------------------------- *
 * reg_ea - Functions that deal with a register and hold the reg #   *
 *      in the command word, and also have an effective address      *
 * ----------------------------------------------------------------- */

int reg_ea(struct cmd_items* ci, int j, struct opst* op)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    int size = (ci->cmd_wrd >> 7) & 3;
    char ea[50];
    char* regname = "d";

    /* Eliminate illegal Addressing modes */
    switch (op->id)
    {
    case 30:        /* chk */
    case 137:       /* chk 68020 */
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
    case 70:        /* divu */
    case 71:        /* divs */
    case 79:        /* mulu */
    case 80:        /* muls */
        if ((mode == 1))
            return 0;
        break;

    case 31:       /* lea */
        if ((mode < 2) || (mode == 3) || (mode == 4))
            return 0;
        if ((mode == 7) && (reg == 4))
            return 0;
        size = SIZ_LONG;
    }

    switch (op->id)
    {
    default:
        break;  /* Already checked above */
    }

    if (j == 31)
    {
        regname = "a";
    }

    if (get_eff_addr(ci, ea, mode, reg, size))
    {
        sprintf(ci->params, "%s,%c%d", ea, regname[0], (ci->cmd_wrd >> 9) & 7);
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

    if (slash)
        *s++ = '/';

    if (high - low >= 1) {
        s += sprintf(s, "%s", ad);
        *s++ = low + '0';
        *s++ = '-';
        s += sprintf(s, "%s", ad);
        *s++ = high + '0';
    }
    else if (high - low == 1) {
        s += sprintf(s, "%s", ad);
        *s++ = low + '0';
        *s++ = '/';
        s += sprintf(s, "%s", ad);
        *s++ = high + '0';
    }
    else {
        s += sprintf(s, "%s", ad);
        *s++ = high + '0';
    }

    *s = '\0';
    return s;
}

/*
 * Format ``regmask'' into ``s''.  ``ad'' is a prefix used to indicate
 * whether the mask is for address, data, or floating-point registers.
 */

char* regbyte(char* s, unsigned char regmask, char* ad, int doslash)
{
    int	i;
    int	last;

    for (last = -1, i = 0; regmask; i++, regmask >>= 1)
    {
        if (regmask & 1) {
            if (last != -1)
                continue;
            else
                last = i;
        }
        else if (last != -1) {
            s = regwrite(s, ad, last, i - 1, doslash);
            doslash = 1;
            last = -1;
        }
    }

    if (last != -1)
        s = regwrite(s, ad, last, i - 1, doslash);

    return s;
}

static void reglist(char* s, unsigned long regmask, int mode)
{
    char* t = s;

    if (mode == 4)
    {
        regmask = revbits(regmask, 16);
    }

    s = regbyte(s, (unsigned char)(regmask >> 8), "a", 0);
    s = regbyte(s, (unsigned char)(regmask & 0xff), "d", s != t);

    if (s == t)
    {
        strcpy(s, "0");
    }
}

int movem_cmd(struct cmd_items* ci, int j, struct opst* op)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    int size = (ci->cmd_wrd & 0x40) ? SIZ_LONG : SIZ_WORD;
    char ea[50];
    char regnames[50];
    int dir = (ci->cmd_wrd >> 10) & 1;
    int regmask;

    if (mode < 2)       /* Common to both modes */
    {
        return 0;
    }

    if (dir)
    {
        if (mode == 4)
            return 0;
        if ((mode == 7) && (reg == 4))
            return 0;
    }
    else
    {
        if (mode == 3)
            return 0;
        if ((mode == 7) && (reg > 1))
            return 0;
    }

    regmask = getnext_w(ci);

    if (!get_eff_addr(ci, ea, mode, reg, size))
    {
        ungetnext_w(ci);
        return 0;
    }

    reglist(regnames, regmask, mode);
    strcpy(ci->mnem, op->name);
    strcat(ci->mnem, SizSufx[size]);

    if (dir)
    {
        sprintf(ci->params, "%s,%s", ea, regnames);
    }
    else
    {
        sprintf(ci->params, "%s,%s", regnames, ea);
    }

    return 1;
}

int link_unlk(struct cmd_items* ci, int j, struct opst* op)
{
    int regno = ci->cmd_wrd & 7;
    int ext_w;

    strcpy(ci->mnem, op->name);

    switch (op->id)
    {
    case 47:        /* "unlink: only needs regno for the opcode */
        sprintf(ci->params, "A%d", regno);

        if ((ci->mnem[strlen(ci->mnem) - 1]) == '.')
        {
            ci->mnem[strlen(ci->mnem) - 1] = '\0';
        }

        break;
    default:
        ext_w = getnext_w(ci);

        if (j == 138)
        {
            ext_w = (ext_w << 8) | (getnext_w(ci) & 0xff);
        }

        sprintf(ci->params, "A%d,#%d", regno, ext_w);
        strcat(ci->mnem, (j == 46) ? "w" : "l");
    }

    return 1;
}

/* ------------------------------------------------------------------ *
 * get_ext_wrd() - Retrieves the extended command word, and sets up   *
 *      the values.                                                   *
 * Returns 1 if valid, 0 if cpu < 68020 && is Full Extended Word      *
 * ------------------------------------------------------------------ */

int get_ext_wrd(struct cmd_items* ci, struct extWbrief* extW, int mode, int reg)
{
    int ew;     /* A local copy of the extended word (stored in ci->code[0]) */

    ew = getnext_w(ci);

    if ((cpu < 20) && (ew & 0x0100))
    {
        ungetnext_w(ci);
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
        if (ew & 0x08)  /* Bit 3 must be 0 */
        {
            ungetnext_w(ci);
            return 0;
        }

        extW->iiSel = ew & 7;
        extW->bs = (ew >> 7) & 1;
        extW->is = (ew >> 6) & 1;

        if ((extW->bdSize = (ew >> 4) & 3) == 0)
        {
            ungetnext_w(ci);
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

/* ------------------------
 * get_eff_addr() - Build the appropriate opcode string for the command
 *     and store it in the command structure opcode string
 *
 * ------------------------- */

int get_eff_addr(struct cmd_items* ci, char* ea, int mode, int reg, int size)
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

    switch (mode)
    {
        MODE_STR* a_pt;
    default: return 0;
    case 0:   /* "Dn" */
        sprintf(ea, ModeStrings[mode].str, reg);
        return 1;
    case 1:   /* "An" */
        if (size < SIZ_WORD)
            return 0;
    case 2:   /* (An) */
    case 3:   /* (An)+ */
    case 4:   /* -(An) */
        if (reg == 7)
        {
            a_pt = &SPStrings[mode];
        }
        else
        {
            a_pt = &ModeStrings[mode];
        }

        sprintf(ea, a_pt->str, reg);
        return 1;
        break;
    case 5:             /* d{16}An */
        AMode = AM_A0 + reg;
        ext1 = getnext_w(ci);

        /* The system biases the data Pointer (a6) by 0x8000 bytes,
         * so compensate
         */

        if (reg == 6) {
            switch (M_Type)
            {
            case MT_PROGRAM:
                ext1 += 0x8000;
                break;
            default:
                break;
            }
        }

        /* NOTE:: NEED TO TAKE INTO ACCOUNT WHEN DISPLACEMENT IS A LABEL !!! */
        LblCalc(dispstr, ext1, AMode, ea_addr);

        if (reg == 7)
        {
            sprintf(ea, SPStrings[mode].str, dispstr);
        }
        else
        {
            sprintf(ea, ModeStrings[mode].str, dispstr, reg);
        }
        return 1;
        break;
    case 6:             /* d{8}(An,Xn) or 68020-up */
        AMode = AM_A0 + reg;

        if (get_ext_wrd(ci, &ew_b, mode, reg))
        {
            if (ew_b.isFull)
            {
                return process_extended_word_full(ci, ea, &ew_b, mode, reg, size);
            }
            else
            {
                return process_extended_word_brief(ci, ea, &ew_b, mode, reg, size);
            }
            /* the displacement should be a string for it may sometimes
             * be a label */
             /*char a_disp[50];
             char idxstr[30];

             a_disp[0] = '\0';*/

             /* This is for cpu's < 68020
              * for 68020-up, the bd can be up to 32 bits
              */
              /*if (abs(ew_b.displ) > 0x80)
              {
                  ungetnext_w(ci);
                  return 0;
              }

              if (ew_b.displ)
              {
                  LblCalc (a_disp, ew_b.displ, AMode);
              }

              if (!set_indirect_idx (idxstr, &ew_b))
              {
                  ungetnext_w(ci);
                  return 0;
              }

              if (reg == 7)
              {
                  sprintf (ea, SPStrings[mode].str, a_disp, idxstr);
              }
              else
              {
                  sprintf (ea, ModeStrings[mode].str, a_disp, reg, idxstr);
              }

              return 1;
              */
        }
        else
        {
            return 0;
        }

        /* NOTE:: NEED TO TAKE INTO ACCOUNT WHEN DISPLACEMENT IS A LABEL !!! */
        break;

        /* We now go to mode %111, where the mode is determined
         * by the register field
         */
    case 7:
        switch (reg) {
        case 0:                 /* (xxx).W */
            AMode = AM_SHORT;
            ext1 = getnext_w(ci);
            /*sprintf (dispstr, "%d", displac_w);*/
            LblCalc(dispstr, ext1, AMode, ea_addr);
            sprintf(ea, Mode07Strings[reg].str, dispstr);
            return 1;
        case 1:                /* (xxx).L */
            AMode = AM_LONG;
            ext1 = getnext_w(ci);
            ext1 = (ext1 << 16) | (getnext_w(ci) & 0xffff);
            LblCalc(dispstr, ext1, AMode, ea_addr);
            sprintf(ea, Mode07Strings[reg].str, dispstr);
            return 1;
        case 4:                 /* #<data> */
            AMode = AM_IMM;
            ref_ptr = PCPos;
            ext1 = getnext_w(ci);

            switch (size)
            {
            case SIZ_BYTE:
                if ((ext1 < -128) || (ext1 > 0xff))
                {
                    ungetnext_w(ci);
                    return 0;
                }

                break;
            case SIZ_WORD:
                if ((ext1 < -32768) || (ext1 > 0xffff))
                {
                    ungetnext_w(ci);
                    return 0;
                }

                break;
            case SIZ_LONG:
                ext2 = getnext_w(ci);
                ext1 = (ext1 << 16) | (ext2 & 0xffff);
                break;
            }

            if (rof_setup_ref(refs_code, ref_ptr, dispstr, ext1))
            {
                sprintf(ea, Mode07Strings[reg].str, dispstr);
                return 1;
            }

            LblCalc(dispstr, ext1, AMode, ea_addr);
            sprintf(ea, Mode07Strings[reg].str, dispstr);
            return 1;
        case 2:              /* (d16,PC) */
            AMode = AM_REL;
            ext1 = getnext_w(ci);
            /* (ext1 - 2) to reflect PCPos before getnext_w */
    /*LblCalc(dispstr, ext1 - 2, AMode, ea_addr);*/
            LblCalc(dispstr, ext1, AMode, ea_addr);
            sprintf(ea, Mode07Strings[reg].str, dispstr);
            return 1;
        case 3:              /* d8(PC,Xn) */
            AMode = AM_REL;

            if (get_ext_wrd(ci, &ew_b, mode, reg))
            {
                if (ew_b.isFull)
                {
                    return process_extended_word_full(ci, ea, &ew_b, mode, reg, size);
                }
                else
                {
                    return process_extended_word_brief(ci, ea, &ew_b, mode, reg, size);
                }
                /*char a_disp[50];
                char idxstr[30];


                if (ew_b.displ)
                {
                    sprintf (a_disp, "%d", ew_b.displ);
                }
                else
                {
                    a_disp[0] = '\0';
                }

                if (!set_indirect_idx (idxstr, &ew_b))
                {
                    ungetnext_w(ci);
                    return 0;
                }

                sprintf (ea, Mode07Strings[reg].str, a_disp, idxstr);

                return 1;
            }
            else
            {
                return 0;*/
            }
        }
    }

    return 0;    /* Return 0 means no effective address was found */
}


/* -------------------------
 * process_extended_word_full() - Process the extended word for
 *          indexed modes
 */

int process_extended_word_full(struct cmd_items* ci, char* dststr, struct extWbrief* ew, int mode,
    int reg, int size)
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

        get_displ(ci, base_str, ew->bdSize);

        if (mode == 7)  /* Adjust for PC-Rel mode */
        {
            sscanf(base_str, "%d", &pcadj);
            sprintf(base_str, "%d", pcadj - 2);
        }
    }

    if (ew->bs == 0)        /* If not suppressed ... */
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
        sprintf(idx_reg, "%c%d.%c", ew->regNam, ew->regno,
            ew->isLong ? 'l' : 'w');

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
        get_displ(ci, od_str, ew->iiSel & 3);
    }

    if (ew->is == 0)
    {
        switch (ew->iiSel & 4)
        {
        case 0:          /* PreIndexed */
            if ((strlen(base_str)) && (strlen(idx_reg)))
            {
                strcat(base_str, ",");
                strcat(base_str, idx_reg);
            }
            else if (strlen(idx_reg))   /* no base_str */
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
        default:         /* PostIndexed */
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
    else        /* else ew->is = 1 */
    {
        if (ew->iiSel >= 4)
        {
            while (ci->wcount)
            {
                ungetnext_w(ci);
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

int process_extended_word_brief(struct cmd_items* ci, char* dststr, struct extWbrief* ew_b,
    int mode, int reg, int size)
{
    char a_disp[50];
    char idxstr[30];

    a_disp[0] = '\0';

    /* This is for cpu's < 68020
     * for 68020-up, the bd can be up to 32 bits
     */
     /*if (abs(ew_b.displ) > 0x80)
     {
         ungetnext_w(ci);
         return 0;
     }*/

    if (ew_b->displ)
    {
        if (mode == 7)
        {
            ew_b->displ -= 2;
        }

        LblCalc(a_disp, ew_b->displ, AMode, PCPos - 2);
    }

    if (!set_indirect_idx(idxstr, ew_b))
    {
        ungetnext_w(ci);
        return 0;
    }

    switch (mode)
    {
    case 6:
        switch (reg)
        {
        case 7:
            sprintf(dststr, SPStrings[mode].str, a_disp, idxstr);
            break;
        default:
            sprintf(dststr, ModeStrings[mode].str, a_disp,
                reg, idxstr);
            break;
        }
        break;
    case 7:     /* PCRel */
        sprintf(dststr, Mode07Strings[reg].str, a_disp, idxstr);
        break;
    default:
        return 0;
    }

    return 1;
}


/* *********************
 * get_displ() - Get the displacement for either the base displacement
 *          or the outer displacement, if not suppressed
 */

void get_displ(struct cmd_items* ci, char* dst, int siz_flag)
{
    switch (siz_flag)
    {
    case 2:   /* Word Displacement */
        sprintf(dst, "%d.w", getnext_w(ci));
        break;
    case 3:  /* Long Displacement */
        sprintf(dst, "%d",
            (getnext_w(ci) << 16) | (getnext_w(ci) & 0xffff));
        break;
    default:
        break;
    }
}


/* *************
 * set_indirect_idx()
 *     Sets up the string for the Index register for
 *     Indirect Addressing mode for either
 *     Address register or PC
 * Passed:  (1) dest - The location to store the string
 *          (2) extW - The extWbrief struct containing the
 *                     extended word information.
 * Returns: Pointer to the newly-filled dest
 *
 */

int set_indirect_idx(char* dest, struct extWbrief* extW)
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

    sprintf(dest, "%c%d.%c", extW->regNam, extW->regno,
        extW->isLong ? 'l' : 'w');
    /**dest = extW->regNam;
    dest[1] = '\0';
    sprintf (rgnum, "%d", extW->regno);
    strcat (dest, rgnum);
    strcat (dest, extW->isLong ? ".l" : ".w");*/

    switch (extW->scale)
    {
    default:
        break;  /* No need to specify scale if it's 1 */
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


/* ------------------------------------------------------------------------ *
 * get_extends_common() - Gets the extended data, sets up the ea for calls  *
 *       where the size is the 3 MS=bits of the lower byte of the command,  *
 *       and the EA is the lower 5 bytes of the command word.               *
 * Passed: (1) - the command items structure                                *
 *         (2) - the mnemonic for the call.  This routine adds the size     *
 *               descriptor                                                 *
 * ------------------------------------------------------------------------ */

int get_extends_common(struct cmd_items* ci, char* mnem)
{
    int mode, reg;
    int size;
    char addr_mode[20];              /* Destination for the opcode */

    mode = (ci->cmd_wrd >> 3) & 7;
    reg = ci->cmd_wrd & 7;
    size = (ci->cmd_wrd >> 6) & 3;

    get_eff_addr(ci, addr_mode, mode, reg, size);
    getnext_w(ci);

    if (size > 1) {
        getnext_w(ci);
    }

    return 1;
}

/* ----------------------------------------------------------------- *
 * ctl_addrmodesonly - Returns 0 if the addressing mode is anything  *
 *    but a Control addressing mode                                  *
 * ----------------------------------------------------------------- */

int ctl_addrmodesonly(int mode, int reg)
{
    if ((mode < 2) || (mode == 4) || (mode == 8))
        return 0;

    if (mode == 7)
    {
        if (mode == 4)
            return 0;
    }

    return 1;
}


char getnext_b(struct cmd_items* ci)

{
    char b;

    if (fread(&b, 1, 1, ModFP) < 1)
    {
        filereadexit();
    }

    ++PCPos;
    /* We won't store this into the buffers
     * as it is not a command */
    return b;
}

/* **************************************************************************** *
 * getnext_w() - Fetches the next word (an Extended Word) from the module        *
 * Passed: The struct cmd_items pointer                                                 *
 * Returns: the word retrieved                                                  *
 *                                                                              *
 * The PCPos is updated, the count of words in the instruction is updated and   *
 *    the word is stored in the proper Info->code position                      *
 * **************************************************************************** */

int getnext_w(struct cmd_items* ci)
{
    short w;

    w = fread_w(ModFP);
    PCPos += 2;
    ci->code[ci->wcount] = w;
    ci->wcount += 1;
    return w;
}

/* *************************************************************************** *
 * ungetnext_w() - ungets (undoes) a previous word-get.
 * Passed: Pointer to the struct cmd_items struct
 * *************************************************************************** */

void ungetnext_w(struct cmd_items* ci)
{
    fseek(ModFP, -2, SEEK_CUR);
    PCPos -= 2;
    ci->wcount -= 1;
}