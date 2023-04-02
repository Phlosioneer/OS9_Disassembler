/* ************************************************************************ *
 * commonsubs.c - Common subroutines and functions that are used            *
 *          by several calls.                                               *
 *                                                                          *
 * ************************************************************************ *
 *                                                                          *
 * Copyright (c) 2017 David Breeding                                        *
 *                                                                          *
 * This file is part of osk-disasm.                                         *
 *                                                                          *
 * osk-disasm is free software: you can redistribute it and/or modify       *
 * it under the terms of the GNU General Public License as published by     *
 * the Free Software Foundation, either version 3 of the License, or        *
 * (at your option) any later version.                                      *
 *                                                                          *
 * osk-disasm is distributed in the hope that it will be useful,            *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
 * GNU General Public License for more details.                             *
 *                                                                          *
 * You should have received a copy of the GNU General Public License        *
 * (see the file "COPYING") along with osk-disasm.  If not,                 *
 * see <http://www.gnu.org/licenses/>.                                      *
 *                                                                          *
 * ************************************************************************ */


#include <string.h>
#include <stdio.h>
#include "userdef.h"
#include "modtypes.h"
#include "disglobs.h"
#include "rof.h"
#include "proto.h"

typedef struct modestrs {
    char *str;
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

extern char *SizSufx[];

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

static int set_indirect_idx (char *dest, struct extWbrief *extW)
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

    sprintf (dest, "%c%d.%c", extW->regNam, extW->regno,
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

/* ------------------------------------------------------------------ *
 * get_ext_wrd() - Retrieves the extended command word, and sets up   *
 *      the values.                                                   *
 * Returns 1 if valid, 0 if cpu < 68020 && is Full Extended Word      *
 * ------------------------------------------------------------------ */

static int get_ext_wrd (CMD_ITMS *ci, struct extWbrief *extW, int mode, int reg)
{
    int ew;     /* A local copy of the extended word (stored in ci->code[0] */

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

/* *********************
 * get_displ() - Get the displacement for either the base displacement
 *          or the outer displacement, if not suppressed
 */

static void get_displ(CMD_ITMS *ci, char *dst, int siz_flag)
{
    switch (siz_flag)
    {
        case 2:   /* Word Displacement */
            sprintf (dst, "%d.w", getnext_w(ci));
            break;
        case 3:  /* Long Displacement */
            sprintf (dst, "%d",
                    (getnext_w(ci) << 16) | (getnext_w(ci) & 0xffff));
            break;
        default:
            break;
    }
}

/* -------------------------
 * process_extended_word_full() - Process the extended word for
 *          indexed modes
 */

static int process_extended_word_full(CMD_ITMS *ci, char *dststr, struct extWbrief *ew, int mode,
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
            sscanf (base_str, "%d", &pcadj);
            sprintf (base_str, "%d", pcadj - 2);
        }
    }

    if (ew->bs == 0)        /* If not suppressed ... */
    {
        char br_str[3];

        if (strlen(base_str))
        {
            strcat (base_str, ",");
        }

        switch (mode)
        {
            case 6:
                sprintf(br_str, "a%d", reg);
                strcat (base_str, br_str);
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

            sprintf (&idx_reg[strlen(idx_reg)], "*%d", s);
        }
    }

    /* Outer Displacement */
    od_str[0] = '\0';

    if ((ew->iiSel & 3) > 1)
    {
        get_displ(ci, od_str, ew->iiSel & 3);
    }

    if(ew->is == 0)
    {
        switch (ew->iiSel & 4)
        {
        case 0:          /* PreIndexed */
            if ((strlen(base_str)) && (strlen(idx_reg)))
            {
                strcat (base_str, ",");
                strcat (base_str, idx_reg);
            }
            else if (strlen(idx_reg))   /* no base_str */
            {
                strcpy (base_str, idx_reg);
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
                strcat (idx_reg, ",");
                strcat(idx_reg, od_str);
            }
            else if (strlen(od_str))
            {
                strcpy (idx_reg, od_str);
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
            strcpy (idx_reg, od_str);
        }
    }


    if (ew->iiSel & 7)
    {
        sprintf (dststr, "([%s]", base_str);
    }
    else
    {
        sprintf (dststr, "(%s", base_str);
    }

    if (strlen(idx_reg))
    {
        if (strlen(base_str) || (ew->iiSel & 3))
        {
            strcat (dststr, ",");
        }

        strcat (dststr, idx_reg);
    }

    strcat(dststr, ")");

    return 1;
}

static int process_extended_word_brief(CMD_ITMS *ci, char *dststr, struct extWbrief *ew_b,
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

        LblCalc (a_disp, ew_b->displ, AMode, PCPos - 2);
    }

    if (!set_indirect_idx (idxstr, ew_b))
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
                    sprintf (dststr, SPStrings[mode].str, a_disp, idxstr);
                    break;
                default:
                    sprintf (dststr, ModeStrings[mode].str, a_disp,
                            reg, idxstr);
                    break;
            }
            break;
        case 7:     /* PCRel */
            sprintf (dststr, Mode07Strings[reg].str, a_disp, idxstr);
            break;
        default:
            return 0;
    }

    return 1;
}

/* ------------------------
 * get_eff_addr() - Build the appropriate opcode string for the command
 *     and store it in the command structure opcode string
 *
 * ------------------------- */

int get_eff_addr(CMD_ITMS *ci, char *ea, int mode, int reg, int size)
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
        MODE_STR *a_pt;
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
            sprintf (ea, ModeStrings[mode].str,dispstr,reg);
        }
        return 1;
        break;
    case 6:             /* d{8}(An,Xn) or 68020-up */
        AMode = AM_A0 + reg;

        if (get_ext_wrd (ci, &ew_b, mode, reg))
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
            }*/

            return 1;
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
            sprintf (ea, Mode07Strings[reg].str, dispstr);
            return 1;
        case 1:                /* (xxx).L */
            AMode = AM_LONG;
            ext1 = getnext_w(ci);
            ext1 = (ext1 << 16) | (getnext_w(ci) & 0xffff);
            LblCalc(dispstr, ext1, AMode, ea_addr);
            sprintf (ea, Mode07Strings[reg].str, dispstr);
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
                    sprintf (ea, Mode07Strings[reg].str, dispstr);
                    return 1;
            }

            LblCalc (dispstr, ext1, AMode, ea_addr);
            sprintf (ea, Mode07Strings[reg].str, dispstr);
            return 1;
        case 2:              /* (d16,PC) */
            AMode = AM_REL;
            ext1 = getnext_w(ci);
                    /* (ext1 - 2) to reflect PCPos before getnext_w */
            /*LblCalc(dispstr, ext1 - 2, AMode, ea_addr);*/
            LblCalc(dispstr, ext1, AMode, ea_addr);
            sprintf (ea, Mode07Strings[reg].str, dispstr);
            return 1;
        case 3:              /* d8(PC,Xn) */
            AMode = AM_REL;

            if (get_ext_wrd (ci, &ew_b, mode, reg))
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

/*
 * pass_eq() - Skip past the '=' of an assignment, and also skip
 *      blanks so that on return, the pointer will be positioned
 *      at the begin of the next string.
 */

char * pass_eq (char *p)
{
    while ((*p) && (strchr ("= \t\r\f\n", *p)))
    {
        ++p;
    }

    if (*p == '\n')
    {
        *p = 0;
    }

    return p;
}

/*
 * strpos() - Similar to strchr except that it returns the
 *        base-1 offset from the begin of the string.
 */

int strpos (char *s, char c)
{
    register int p;

    return ((p = (int)strchr(s, c)) ? (p - (int)s) : -1);
}

/* **************************************************************** *
 * skipblank() passes over any space, tab, or any newline character *
 *             in the string                                        *
 * Passed: p pointer to begin of string to parse                    *
 * Returns: pointer to first character of "valid" data,             *
 *          or null if end of data                                  *
 * **************************************************************** */

char * skipblank (char *p)
{
    /* We did just pass over spaces or tabs, but we need to
     * also be sure we are past all return characters
     * ( especially the extra character MS-Dos uses
     */

    while ((*p) && (strchr (" \t\r\f\n", *p)))
    {
        ++p;
    }

    if (*p == '\n')
    {
        *p = 0;
    }

    return p;
}

/* ------------------------------------------------------------------------ *
 * get_extends_common() - Gets the extended data, sets up the ea for calls  *
 *       where the size is the 3 MS=bits of the lower byte of the command,  *
 *       and the EA is the lower 5 bytes of the command word.               *
 * Passed: (1) - the command items structure                                *
 *         (2) - the mnemonic for the call.  This routine adds the size     *
 *               descriptor                                                 *
 * ------------------------------------------------------------------------ */

char *sizebits[] = {".s", ".w", ".l"};

int get_extends_common(CMD_ITMS *ci, char *mnem)
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

/* ----------------------------------------------------------------- *
 * reg_ea - Functions that deal with a register and hold the reg #   *
 *      in the command word, and also have an effective address      *
 * ----------------------------------------------------------------- */

int reg_ea(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    int size = (ci->cmd_wrd >> 7) & 3;
    char ea[50];
    char *regname = "d";

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
        sprintf(ci->opcode, "%s,%c%d", ea, regname[0], (ci->cmd_wrd >> 9) & 7);
        strcpy (ci->mnem, op->name);

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

static char * regwrite(char *s, char *ad, int low, int high, int slash)
{

	if (slash)
		*s++ = '/';

	if (high - low >= 1) {
		s += sprintf(s, "%s", ad);
		*s++ = low + '0';
		*s++ = '-';
		s += sprintf(s, "%s", ad);
		*s++ = high + '0';
	} else if (high - low == 1) {
		s += sprintf(s, "%s", ad);
		*s++ = low + '0';
		*s++ = '/';
		s += sprintf(s, "%s", ad);
		*s++ = high + '0';
	} else {
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

char * regbyte(char *s, unsigned char regmask, char *ad, int doslash)
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
		} else if (last != -1) {
			s = regwrite(s, ad, last, i - 1, doslash);
			doslash = 1;
			last = -1;
		}
    }

	if (last != -1)
		s = regwrite(s, ad, last, i - 1, doslash);

	return s;
}


/* ------------------------------------------------------------------ *
 * revbits() - Reverses the bit order for a value.                    *
 * ------------------------------------------------------------------ */


int revbits(int num, int lgth)
{
    int n2 = 0;
    int c, i;

    for (c = (lgth - 1), i = 0; c >= 0; c--,i++)
    {
        n2 <<= 1;

        if (num & (1 << i))
            n2 |= 1;
    }

    return n2;
}

static void reglist(char *s, unsigned long regmask, int mode)
{
    char *t = s;

    if (mode == 4)
    {
        regmask = revbits(regmask, 16);
    }

    s = regbyte (s, (unsigned char)(regmask >> 8), "a", 0);
    s = regbyte (s, (unsigned char)(regmask & 0xff), "d", s != t);

    if (s == t)
    {
        strcpy (s, "0");
    }
}

int movem_cmd(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
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

    reglist (regnames, regmask, mode);
    strcpy (ci->mnem, op->name);
    strcat (ci->mnem, SizSufx[size]);

    if (dir)
    {
        sprintf(ci->opcode, "%s,%s", ea, regnames);
    }
    else
    {
        sprintf(ci->opcode, "%s,%s", regnames, ea);
    }

    return 1;
}

int link_unlk(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    int regno = ci->cmd_wrd & 7;
    int ext_w;

    strcpy (ci->mnem, op->name);

    switch (op->id)
    {
        case 47:        /* "unlink: only needs regno for the opcode */
            sprintf (ci->opcode, "A%d", regno);

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

            sprintf (ci->opcode, "A%d,#%d", regno, ext_w);
            strcat(ci->mnem, (j == 46) ? "w" : "l");
    }

    return 1;
}

unsigned int fget_w (FILE *fp)
{
    return ((unsigned char)fgetc(fp) << 8) | (unsigned char)fgetc(fp);
}

unsigned int fget_l (FILE *fp)
{
    unsigned int val,
                 c;
    val = (unsigned char)fgetc(fp);

    for (c = 0; c < 3; c++)
    {
        val = (val << 8) | (unsigned char)(fgetc(fp) & 0xff);
    }

    return val;
}

/* ************************************************************************* *
 * fread_* functions - These are partly convenience functions but mostly are *
 * used to enable retrieving multi-byte values regardless of the             *
 * "ENDIAN"ness of the CPU                                                   *
 * If the read fails, the program is immediately exited.                     *
 * ************************************************************************* */

char fread_b(FILE *fp)
{
    char b;

    if (fread(&b, 1, 1, fp) < 1)
    {
        filereadexit();
    }

    return b;
}

char getnext_b(CMD_ITMS *ci)

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
 * Passed: The cmditems pointer                                                 *
 * Returns: the word retrieved                                                  *
 *                                                                              *
 * The PCPos is updated, the count of words in the instruction is updated and   *
 *    the word is stored in the proper Info->code position                      *
 * **************************************************************************** */

int getnext_w(CMD_ITMS *ci)
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
 * Passed: Pointer to the cmditems struct
 * *************************************************************************** */

void     ungetnext_w(CMD_ITMS *ci)
{
    fseek (ModFP, -2, SEEK_CUR);
    PCPos -= 2;
    ci->wcount -= 1;
}

/* ******************************************************************** *
 * Some substitutions to allow portability. Most deal with the byte     *
 *  order of the CPU                                                    *
 * ******************************************************************** */

/* Read multi-byte numbers from the file.  
 * We are going to make a serious assumption here.  If it's _OSK then
 * assume it's LITTLE_ENDIAN, other wise it's BIG_ENDIAN.  Also we'll
 * assume that if it's _OSK, _STDC_ is #undef; otherwise it's defined
 */

#ifdef _OSK
short fread_w(fp)
    FILE *fp;
{
    short w;
    
    if (fread(&w, 2, 1, fp) < 1)
    {
        filereadexit();
    }

    return w;
}

int fread_l(fp)
    FILE *fp;
{
    int l;
    int count;
    
    l = (unsigned char)fgetc(fp)  & 0xff;

    for (count = 1; count < sizeof(int); count++)
    {
        l = (l << 8) | (unsigned char)fgetc(fp) & 0xff;
    }

    return l;
}
#else
short fread_w(FILE *fp)
{
    int tt;

    tt = (fgetc(ModFP) << 8) | (fgetc (ModFP) & 0xff);
    return tt;
}

int fread_l(FILE *fp)
{
    int tt;
    int tmpnum = 0;
    int count;

    for (count = 0; count < 4; count++)
    {
        if (fread(&tt, 1, 1, fp) < 1)
        {
            filereadexit();
        }

        tmpnum = (tmpnum<<8) | (tt & 0xff); 
    }

    return tmpnum;

    return 1;
}
#endif

/* **************************************************************** *
 * bufReadW() - Returns the word value stored at pos pt in a buffer *
 * **************************************************************** */

short bufReadW(char **pt)
{
    register int val = 0;

    val = *(*pt)++ & 0xff;
    val = (val << 8) | (*(*pt)++ & 0xff);
    /*return ((*(*pt)++ & 0xff) << 8) | (*((*pt)++) & 0xff);*/
    return val;
}

/* **************************************************************** *
 * bufReadL() - Returns the long value stored at pos pt in a buffer *
 * **************************************************************** */

int     bufReadL(char **pt)
{
    register int byteCnt;
    register int val = 0;

    for (byteCnt = 0; byteCnt < 4; byteCnt++)
    {
        val = (val << 8) | (*((*pt)++) & 0xff);
    }

    return val;
}

void * mem_alloc (int req)
{
    void *addr;

    if (!(addr = malloc (req)))
    {
        errexit ("Failed to acquire requested memory");
    }

    return addr;
}

/* *************************************************************** *
 * freadString() - Read a null-terminated string from the file,    *
 *            allocate memory for that string, and store it there. *
 * Returns: Pointer to the new string.                             *
 * *************************************************************** */

char * freadString()
{
    register char *strPt = strBuf;
    register char *newStr;
    register int ch;

    while ((ch = getc(ModFP)) && (ch > 0))
    {
        *(strPt++) = ch;
    }

    *strPt = '\0';
    strcpy ((newStr = (char *)mem_alloc(strlen(strBuf) + 1)), strBuf);
    return newStr;
}

char * lbldup (char *lbl)
{
    char *dupstr = (char *)mem_alloc (strlen(lbl) + 2);
    strcpy(dupstr, lbl);
    return dupstr;
}

