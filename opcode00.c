/* ******************************************************************** *
 * opcode00.c - Resolves cases where the Opcode is 0000                 *
 *                                                                      *
 * ******************************************************************** *
 *                                                                      *
 * Copyright (c) 2017 David Breeding                                    *
 *                                                                      *
 * This file is part of osk-disasm.                                     *
 *                                                                      *
 * osk-disasm is free software: you can redistribute it and/or modify   *
 * it under the terms of the GNU General Public License as published by *
 * the Free Software Foundation, either version 3 of the License, or    *
 * (at your option) any later version.                                  *
 *                                                                      *
 * osk-disasm is distributed in the hope that it will be useful,        *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of       *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        *
 * GNU General Public License for more details.                         *
 *                                                                      *
 * You should have received a copy of the GNU General Public License    *
 * (see the file "COPYING") along with osk-disasm.  If not,             *
 * see <http://www.gnu.org/licenses/>.                                  *
 *                                                                      *
 * ******************************************************************** */

#include <string.h>
#include "disglobs.h"
#include "userdef.h"
#include "sysnames.h"
#include "rof.h"

#include "proto.h"

enum {
    EA2REG,
    REG2EA
};

char *SizSufx[] = {"b", "w", "l"};

extern CONDITIONALS typecondition[];

/*int bitModeRegLegal(int mode, int reg)
{
    if ( ((2 ^ mode) & 0x7d) == 0)
    {
        return 0;
    }

    if (mode == 6)
    {
        if ( ((2 ^ reg) & 3) == 0)
        {
            return 0;
        }
    }
}*/

/*int      bit_movep_immediate (CMD_ITMS *cmditms)
{
    register int firstword = cmditms->cmd_wrd;*/    /* To save calculations */
/*    short ext1, ext2;
    int mode,reg;*/

    /* 68020+ code*/
/*    if ((firstword & 0xfff0) == 0x6c)  // "rtm"
    {
        //if (cpu >= 2)
        {
            return rtm_020(cmditms);
        }
       // else
            //return 0;
    }*/
/*
    switch (firstword)
    {
    case 0x3c:
    case 0x7c:
        return biti_reg(cmditms, "ori");
    case 0x023c:
    case 0x027c:
        return biti_reg(cmditms, "andi");
    case 0x0a3c:
    case 0x0a7c:
        return biti_reg(cmditms, "eori");
    default:
        break;
    }*/

    /* Handle static bit cmds */
/*
    switch (firstword & 0xffd0)
    {
    case 0x0800:
        return bit_static(cmditms, "btst");
    case 0x0840:
        return bit_static(cmditms, "bchg");
    case 0x0880:
        return bit_static(cmditms, "bclr");
    case 0x8a0:
        return bit_static(cmditms, "bset");
    }*/

    /* Dynamic bit commands */
/*
    switch ((firstword >> 6) & 7)
    {
        case 4:
            if (bit_dynamic(cmditms, "btst"))
            {
                return 1;
            }
            break;
        case 5:
            if (bit_dynamic(cmditms, "bchg"))
            {
                return 1;
            }
            break;
        case 6:
            if (bit_dynamic(cmditms, "bclr"))
            {
                return 1;
            }
            break;
        case 7:
            if (bit_dynamic(cmditms, "bset"))
            {
                return 1;
            }
            break;

    }

    switch ((firstword >> 8) & 0x0f)
    {
    case 0:
        if (cpu >= 2)
        {
            if ((firstword & 0x1c) == 0x0c) */   /* "cmp2" or "chk2"? */
/*            {*/
                /* For the time being, if this is not a match, simply
                                 * continue */
/*
                if (cmp2_chk2(cmditms))
                    return 1;
            }
        }

        return (biti_size(cmditms, "ori"));
        break;
    case 0x01:
        return (biti_size(cmditms, "andi"));*/
        /* Eliminate ccr & SR */
/*        break;
    case 0x02:
        return (biti_size(cmditms, "ori"));
    case 0x03:
        if ((firstword & 0x1f0) == 0xf0)
        {
            if (cpu > 2)
            {*/
                /* Process rtm, callm, cmp2, chk2 */
/*            }
            else
            {
                return 0;
            }
        }
        else
        {
            return (biti_size(cmditms, "andi"));
        }

        break;
    case 4:
        break;
    case 0x6:

        if ((firstword & 0xc0) == 0xc0)
        {
            strcpy(cmditms->mnem, "callm");*/
            /* special case */
/*        }
        else
        {
            return biti_size(cmditms, "addi");
        }
        break;
    case 0x0a:
        strcpy(cmditms->mnem, "eori");*/
        /* Eliminate ccr & SR */
        /* Go process extended command */
/*        break;
    case 0x0c:
        return biti_size(cmditms, "cmpi");
        break;
    case 0x08:
        {
            switch ((firstword >> 6) & 3)
            {
            case 0:
                strcpy(cmditms->mnem, "btst");
                break;
            case 1:
                strcpy(cmditms->mnem, "bchg");
                break;
            case 2:
                strcpy(cmditms->mnem, "bclr");
                break;
            case 3:
                strcpy(cmditms->mnem, "bset");
                break;
            }
        }
    case 0x0ff:
        strcpy(cmditms->mnem, "moves");
        break;
    }*/

    /* We need to now check a different set of bits */
/*    switch ((firstword >>6) & 0x07)
    {
    case 3:
        if (firstword & 0x800)
        {
            if ((firstword & 0x3f) == 0x3d)
            {
                strcpy(cmditms->mnem, "cas");
                break;
            }
            else
            {*/
                /* Possible tests needed */
/*                strcpy(cmditms->mnem, "cas");
                break;
            }
        }

        break;
    case 0x4:
        strcpy(cmditms->mnem, "btst");
        break;
    case 5:
        strcpy(cmditms->mnem, "bchg");
        break;
    case 6:
        strcpy(cmditms->mnem, "bclr");
        break;
    case 7:
        strcpy(cmditms->mnem, "bset");
        break;
    case 10:
        ext1 = getnext_w(cmditms);*/
        /* Eliminate ccr & SR */
/*        switch (cmditms->cmd_wrd & 0xff)
        {
            int regflag = cmditms->cmd_wrd & 0x40;*/
/*
        case 0x3c:
        case 0x7c:*/
            /* If it's ccr and it's negative, sign extend it */
/*            if ((regflag == 0) && ( ext1 & 0x80))
            {
                ext1 |= 0xffff0000;
            }*/

            /* Verify if it's a label */
/*            if (regflag == 0)
            {
                sprintf(cmditms->opcode, "#%s,ccr", ext1);
            }
            else
            {
                sprintf (cmditms->opcode, "#%s,sr", ext1);
            }

            strcpy(cmditms->mnem,"eori");
            return 1;
        default:
            strcpy (cmditms->mnem, "eori");
        }
    }

    if ((firstword & 0x38) == 0x08)
    {
        strcpy(cmditms->mnem, "movep");
    }


    return 0;
}*/

/* ******************
 * Immediate bit operations involving the status registers
 * Returns 1 on success, 0 on failure
 *
 */

int biti_reg(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    static char *sr[2] = {"ccr", "sr"};
    register int size;

    register int ext1 = getnext_w(ci);
    size = (ci->cmd_wrd >> 6) & 1;

/*    if (ext1 & 0xff00)
    {
        ungetnext_w(ci);
        return 0;
    }*/

    if ((size == 0) && (ext1 > 0x1f))
    {
        ungetnext_w(ci);
        return 0;
    }

    /* Add functions to retrieve label */
    if (Pass == 2) {
        strcpy (ci->mnem, op->name);
        sprintf (ci->opcode, "#%d,%s", ext1, sr[size]);
    }

    return 1;
}

/*
 * Immediate bit operations not involving status registers
 *
 */

int biti_size(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int size = (ci->cmd_wrd >> 6) & 3;
    register int mode = (ci->cmd_wrd >> 3) & 7;
    register int reg;
    /*register int firstword = ci->wcount;*/
    char ea[30];
    int data;

    EaString[0] = '\0';
    reg = (ci->cmd_wrd) & 7;

    if ((ci->cmd_wrd & 0x023c) == 0x023c)
    {
        switch (ci->cmd_wrd)
        {
        case 0x023c:
            strcpy (EaString, "ccr");
            size = SIZ_BYTE;
            break;
        case 0x027c:
            strcpy (EaString, "sr");
            size = SIZ_WORD;
        }
    }
    else
    {
        if (size > SIZ_LONG)
        {
            return 0;
        }

        if (mode == 1)
        {
            return 0;
        }

        if (mode == 7)
        {
                /* Note: for "cmpi"(0x0cxx), 68020-up allow all codes < 4 */
                if (reg > 1)
                {
                    return 0;
                }
        }
    }

    /* The source here is always immediate, but go through
     * get_eff_addr to get the label, if needed
     */
    if (!get_eff_addr (ci, ea, 7, 4, size))
    {
        return 0;
    }

    switch (size)
    {
    case SIZ_BYTE:
        data = ci->code[0];

        if ((data < -128) || (data > 0xff))
        {
            ungetnext_w(ci);
            return 0;
        }

        break;
    case SIZ_WORD:
        data = ci->code[0];

        if ((data < -32768) || (data > 0xffff))
        {
            ungetnext_w(ci);
            return 0;
        }

        break;
    case SIZ_LONG:
        break;
    }

    if (strlen(EaString) == 0)
    {
        if (!get_eff_addr(ci, EaString, mode, reg, SIZ_LONG))
        {
            return 0;
        }
    }

    sprintf (ci->opcode, "%s,%s", ea, EaString);
    strcpy (ci->mnem, op->name);
    strcat (ci->mnem, SizSufx[size]);
    return 1;
}

int bit_static(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int ext0,
                 mode, reg;
    char ea[30];

    mode = (ci->cmd_wrd >> 3) & 7;
    reg = ci->cmd_wrd & 7;

    if (mode == 1)
        return 0;

    ext0 = getnext_w(ci);

    /* The MS byte must be zero */
    if (ext0 & 0xff00)
    {
        ungetnext_w(ci);
        return 0;
    }

    /* Also the bt number has limits */
    if (((mode > 1) && (ext0 > 7)) || ext0 > 0x1f)
    {
        ungetnext_w(ci);
        return 0;
    }

    if (get_eff_addr (ci, ea, mode, reg, (ext0 >7) ? SIZ_LONG : SIZ_BYTE))
    {
        sprintf(ci->opcode, "#%d,%s", ext0, ea);
        strcpy(ci->mnem, op->name);
        strcat (ci->mnem, (mode == 0) ? "l" : "b");
        return 1;
    }


    return 0;
}

int bit_dynamic(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int mode, reg;

    mode = (ci->cmd_wrd >> 3) & 7;
    reg = ci->cmd_wrd & 7;

    if (mode == 1)
        return 0;

/*    switch (op->id)
    {
        case 4:
            if (mode == 4)
                return 0;
        default:
            if (mode > 1)
                return 0;
    }*/

    if (get_eff_addr (ci, EaString, mode, reg, SIZ_LONG))
    {
        sprintf(ci->opcode,"d%d,%s", (ci->cmd_wrd >>9) & 7, EaString);
        strcpy(ci->mnem, op->name);
        strcat (ci->mnem, (mode == 0) ? "l" : "b");
        return 1;
    }

    return 0;
}

/*
 *  Build the "move"/"movea" commands
 *
 */

int move_instr(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    int d_mode, d_reg, src_mode, src_reg;
    char src_ea[50], dst_ea[50];
    register int size;

    /* Move instructions have size a bit different */
    switch ((ci->cmd_wrd >> 12) & 3)
    {
        case 1:
            size = SIZ_BYTE;
            break;
        case 3:
            size = SIZ_WORD;
            break;
        case 2:
            size = SIZ_LONG;
            break;
        default:
            return 0;
    }

    /* Get Destination EA */
    d_mode = (ci->cmd_wrd >> 6) & 7;
    d_reg = (ci->cmd_wrd >> 9) & 7;

    if ((d_mode == 7) && (d_reg > 1))
    {
        return 0;
    }

    src_mode = (ci->cmd_wrd >> 3) & 7;
    src_reg = ci->cmd_wrd & 7;

    if (get_eff_addr (ci, src_ea, src_mode, src_reg, size))
    {
        if (get_eff_addr (ci, dst_ea, d_mode, d_reg, size))
        {
            sprintf(ci->opcode, "%s,%s", src_ea, dst_ea);
            strcpy (ci->mnem, "move");

            if (((ci->cmd_wrd >> 6) & 7) == 1)
            {
                strcat(ci->mnem, "a");
            }

            switch (size)
            {
            case SIZ_BYTE:
                if (((ci->cmd_wrd >> 6) & 7) == 1)
                {
                    return 0;
                }
                else
                {
                    strcat(ci->mnem, ".b");
                }
                break;
            case SIZ_WORD:
                strcat(ci->mnem, ".w");
                break;
            case SIZ_LONG:
                strcat(ci->mnem, ".l");
            }

            return 1;
        }
    }

    return 0;
}

int move_ccr_sr(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    /* direction is actually 2 bytes, but this lets REG2EA/EA2REG to work */
    int dir;
    char *statReg;
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;

    switch (ci->cmd_wrd & 0x0f00)
    {
    case 0:
        statReg = "sr";
        dir = REG2EA;
        break;
    case 0x0200:
        statReg = "ccr";
        dir = REG2EA;
        break;
    case 0x400:
        statReg = "ccr";
        dir = EA2REG;
        break;
    case 0x600:
        statReg = "sr";
        dir = EA2REG;
        break;
    default:
        return 0;
    }

    if (get_eff_addr (ci, EaString, mode, reg, SIZ_WORD))
    {
        register char *dot;

        switch (dir)
        {
        case EA2REG:
            sprintf (ci->opcode, "%s,%s", EaString, statReg);
            break;
        default:
            sprintf (ci->opcode, "%s,%s", statReg, EaString);
        }

        strcpy (ci->mnem, op->name);

        if ((dot = strchr(ci->mnem, '.')))
        {
            *dot = '\0';
        }

        return 1;
    }

    return 0;
}

int move_usp(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register char *dot;

    sprintf(EaString, "A%d", ci->cmd_wrd & 7);

    if ((ci->cmd_wrd >> 3) & 1)
    {
        sprintf(ci->opcode, "%s,%s", "usp", EaString);
    }
    else
    {
        sprintf (ci->opcode, "%s,%s", EaString, "usp");
    }

    strcpy (ci->mnem, op->name);

    if ((dot = strchr(ci->mnem, '.')))
    {
        *dot = '\0';
    }

    return 1;
}

int movep(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int addr_reg = ci->cmd_wrd & 7;
    register int opMode = (ci->cmd_wrd >> 6) & 7;
    register int size = (opMode & 1) ? SIZ_LONG : SIZ_WORD;
    char DReg[4];
    char AReg[50];
    int disp = getnext_w(ci);
    static char opcodeFmt[8];

    strcpy (opcodeFmt, "%s,%s");
    sprintf (DReg, "D%d", (ci->cmd_wrd >> 9) & 7);

    sprintf (AReg, "%d(A%d)", disp, addr_reg);

    if (opMode & 2)
    {
        sprintf (ci->opcode, opcodeFmt, DReg, AReg);
    }
    else
    {
        sprintf (ci->opcode, opcodeFmt, AReg, DReg);
    }

    strcpy (ci->mnem, op->name);
    strcat( ci->mnem, (size == SIZ_LONG) ? "l" : "w");
    return 1;
}

int moveq(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register char *dot;

    EaString[0] = '\0';
    LblCalc(EaString, ci->cmd_wrd & 0xff, AM_IMM, CmdEnt);
    sprintf(ci->opcode, "#%s,d%d", EaString, (ci->cmd_wrd >> 9) & 7);
    strcpy (ci->mnem, op->name);

    if ((dot = strchr(ci->mnem, '.')))
    {
        *dot = '\0';
    }

    return 1;
}

/* --------------------------------------------------------------- *
 * one_ea - A generic handler for when the basic command is a      *
 *      single word and the EA is in the lower 6 bytes             *
 * --------------------------------------------------------------- */

int one_ea(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    int size = (ci->cmd_wrd >> 6) & 3;
    char ea[50];

    if (strchr(op->name, '.'))
    {
        if (size >= sizeof(SizSufx)/sizeof(SizSufx[0]))
        {
            return 0;
        }
    }

    if (j == 38)       /* swap */
    {
        sprintf(ci->opcode, "d%d", ci->cmd_wrd & 7);
    }
    else
    {
        /* eliminate modes */
        switch (op->id)
        {
            case 38:    /* swap */
            case 43:    /* tst  */
                break;      /* Allow all modes */
            case 39:    /* pea  */
            case 57:    /* jsr  */
            case 58:    /* jmp  */
                if ((mode < 2) || (mode == 3) || (mode == 4))
                    return 0;
            default:
                if (mode == 1)
                    return 0;
        }

        /* Eliminate mode-7 regs */

        if (mode == 7)
        {
            switch (op->id)
            {
                case 32:        /* Allow all modes */
                case 38:
                    break;
                case 39:
                case 57:    /* jsr  */
                case 58:    /* jmp  */
                    if (reg == 4)
                        return 0;
                    break;
                default:
                    if (reg > 1)
                        return 0;
            }
        }

        /* Handle opcode */

        if (get_eff_addr(ci, ea, mode, reg, size))
        {
            char *statreg = "ccr";

            switch (op->id)
            {
                case 28:    /* Move from SR */
                    statreg = "sr";
                case 33:    /* Move to CCR  */
                case 35:    /* Move from CCR */
                    if (ci->cmd_wrd & 0x400)
                        sprintf (ci->opcode, "%s,%s", ea, statreg);
                    else
                        sprintf (ci->opcode, "%s,%s", statreg, ea);
                    break;
                default:    /* A single ea */
                    strcpy(ci->opcode, ea);
                    break;
            }
        }
        else
        {
            return 0;
        }
    }

    strcpy (ci->mnem, op->name);

    if (strchr (ci->mnem, '.'))
    {
        strcat (ci->mnem, SizSufx[size]);
    }

    return 1;
}

/* ------------------------------------------------------------------- *
 * branch_displ - Calculates the size of a branch and places the size
 *          suffix in the string provided in the parameters.
 * Returns: The branch size (sign extended) if valid, 0 on uneven branch size
 *
 */

static int branch_displ (CMD_ITMS *ci, int cmd_word, char *siz_suffix)
{
    register int displ = cmd_word & 0xff;

    switch (displ)
    {
        case 0:
            displ = getnext_w(ci);

            if (displ & 1)
            {
                ungetnext_w(ci);
                return 0;
            }

            strcpy (siz_suffix, "w");
            break;
        case 0xff:
            if (cpu < MC68020)
                return 0;  /* Long branch not available for < 68020 */

            displ = (getnext_w(ci) << 16) | (getnext_w(ci) & 0xffff);

            if (displ & 1)
            {
                ungetnext_w(ci);
                ungetnext_w(ci);
                return 0;
            }

            strcpy (siz_suffix, "l");
            break;
        default:
            if (displ & 1)
                return 0;

            /* Sign extend the 8-bit displacement */
            if (displ & 0x80)
            {
                displ |= (-1 ^ 0xff);
            }

            strcpy (siz_suffix, "s");
    }

    return displ;
}

int bra_bsr(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int displ;
    register int jmp_base = PCPos;
    char siz[4];

    displ = branch_displ(ci, ci->cmd_wrd, siz);

    if (displ & 1)
        return 0;

    if (!IsROF)
    {
        if (displ == 0)
        {
            return 0;
        }
    }
    else
    {
        int ref_addr = ci->cmd_wrd & 0xff;

        if ((ref_addr == 0) || (ref_addr == 0xff))
        {
            ref_addr = CmdEnt + 2;
        }
        else
        {
            ref_addr = CmdEnt + 1;
        }

        if (rof_setup_ref(refs_code, ref_addr, ci->opcode, displ))
        {
            strcpy (ci->mnem, op->name);
            strcat (ci->mnem, siz);
            return 1;
        }
        else
        {
            if (displ == 0)
                return 0;
        }
    }

    strcpy (ci->mnem, op->name);
    strcat (ci->mnem, siz);
    /*dstAddr = jmp_base + displ;

    //if (IsROF && (Pass == 2))
    //{
    //    if (IsRef(ci->opcode, jmp_base))
    //    {
    //        return 1;
    //    }
    //}*/

    /*process_label (ci, 'L', dstAddr);*/
    LblCalc(ci->opcode, displ, AM_REL, jmp_base);

    return 1;
}

int cmd_no_opcode(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    ci->opcode[0] = '\0';
    strcpy(ci->mnem, op->name);

    return 1;
}


int bit_rotate_mem(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    char ea[50];

    if (mode < 2)
    {
        return 0;
    }

    if ((mode == 7) && (reg > 1))
    {
        return 0;
    }

    if (get_eff_addr(ci, ea, mode, reg, 8))
    {
        if (Pass == 2)
        {
            strcpy (ci->opcode, ea);
            strcpy (ci->mnem, op->name);
        }

        return 1;
    }

    return 0;
}

int bit_rotate_reg(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int count_reg = (ci->cmd_wrd >> 9) & 7;
    char dest_ea[5];

    switch ((ci->cmd_wrd >> 5) & 1)
    {
        case 0:
            sprintf (ci->opcode, "#%d,", (count_reg == 0) ? 8 : count_reg);
            break;
        default:
            sprintf (ci->opcode, "d%d,", count_reg);
    }

    sprintf(dest_ea, "d%d", ci->cmd_wrd & 7);
    strcat (ci->opcode, dest_ea);
    strcpy (ci->mnem, op->name);

    /* Use count_reg to hold Size... */

    if ((count_reg = (ci->cmd_wrd >> 6) & 3) > 2)
    {
        return 0;
    }

    strcat(ci->mnem, SizSufx[count_reg]);
    return 1;
}

int br_cond(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int jmp_base = PCPos;
    register char *condit = typecondition[(ci->cmd_wrd >> 8) & 0x0f].condition;
    char siz[5];
    register int displ;
    char *subst;

    displ = branch_displ(ci, ci->cmd_wrd, siz);

    if (displ & 1)
        return 0;

    /* It wouldn't seem likely that a conditional branch would
     * ever branch to an external ref, and would probably ever
     * occur in C-generated code, but manually-written asm source
     * could contain this
     */

    if (!IsROF)
    {
        if (displ == 0)
        {
            return 0;
        }
    }
    else
    {
        int ref_addr = ci->cmd_wrd & 0xff;

        if ((ref_addr == 0) || (ref_addr == 0xff))
        {
            ref_addr = CmdEnt + 2;
        }
        else
        {
            ref_addr = CmdEnt + 1;
        }

        if (rof_setup_ref(refs_code, ref_addr, ci->opcode, displ))
        {
            strcpy (ci->mnem, op->name);
            strcat (ci->mnem, siz);
            return 1;
        }
        else
        {
            if (displ == 0)
                return 0;
        }
    }

    strcpy(ci->mnem, op->name);

    if ((subst = strchr(ci->mnem, '~')))
    {
        while (*condit)
        {
            *(subst++) = *(condit++);
        }

        *(subst++) = '.';
        strcpy (subst, siz);
    }
    else
    {
        return 0;
    }

        /* We need to calculate the address here */
    /*process_label (ci, 'L', jmp_base + displ);*/
    LblCalc(ci->opcode, displ, AM_REL, jmp_base);
    /*sprintf (ci->opcode, "L%05x", jmp_base + displ);*/

    return 1;
}

typedef struct add_sub_def {
    int size;
    int direction;
    char regname;
    int allmodes;
} ADDSUBDEF;

/* ********************
 * add_sub() - Handles add, sub, and, or, eor instructions
 *   Cmd modes:
 *     1000 - "or"
 *     1001 - "sub"
 *     1011 - "eor"
 *     1100 - "and"
 *     1101 - "add"
 */

int add_sub(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    /*int datareg = (ci->cmd_wrd >> 9) & 7;*/
    int ea_mode = (ci->cmd_wrd >> 3) & 7;
    int ea_reg = ci->cmd_wrd & 7;
    register int opmode = (ci->cmd_wrd >>6) & 7;
    register int cmdcode = ci->cmd_wrd >> 12;
    static ADDSUBDEF AddSubDefs[] = {
        {SIZ_BYTE, EA2REG, 'd', 0},
        {SIZ_WORD, EA2REG, 'd', 0},
        {SIZ_LONG, EA2REG, 'd', 0},
        {SIZ_WORD, EA2REG, 'a', 1},
        {SIZ_BYTE, REG2EA, 'd', 0},
        {SIZ_WORD, REG2EA, 'd', 0},
        {SIZ_LONG, REG2EA, 'd', 0},
        {SIZ_LONG, EA2REG, 'a', 1} 
    };
    register ADDSUBDEF *asDef = &AddSubDefs[opmode];
    char ea[50];

    if (asDef->direction == EA2REG)
    {
        if ((ea_mode == 1) && (asDef->size < SIZ_WORD))
        {
            return 0;
        }

        if (cmdcode == 0x1011)    /* eor */
        {
            return 0;
        }

        if ((cmdcode & 3) != 1)     /* Only "add"/"sub" allow An direct */
        {
            if (ea_mode == 1)
            {
                return 0;
            }
        }

        /* If not "add" or "sub", An cannot be a Dest */
        if ((cmdcode != 0x09) && (cmdcode != 0x0d))
        {
            if (asDef->regname == 'a')
                return 0;
        }
    }
    else       /* else asDef->Direction = REG2EA */
    {
        if (cmdcode == 0x0b) /* "eor" allows Dn, others don't */
        {
            if (ea_mode == 1)
                return 0;
        }
        else
        {
            if (ea_mode < 2)
                return 0;
        }

        if ((ea_mode == 7) && (ea_reg > 1))
        {
            return 0;
        }
    }

    if (get_eff_addr(ci, ea, ea_mode, ea_reg, asDef->size))
    {
        if (asDef->direction == REG2EA)
        {
            sprintf (ci->opcode, "%c%d,%s", asDef->regname, (ci->cmd_wrd >> 9) & 7, ea);
        }
        else
        {
            sprintf (ci->opcode, "%s,%c%d", ea, asDef->regname, (ci->cmd_wrd >> 9) & 7);
        }

        strcpy (ci->mnem, op->name);
        strcat (ci->mnem, SizSufx[asDef->size]);
        return 1;
    }
    else
    {
        return 0;
    }
}

int cmp_cmpa(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int mode = (ci->cmd_wrd >> 3) & 7;
    register int reg = ci->cmd_wrd & 7;
    register int size = (ci->cmd_wrd >> 6) & 7;
    char regName = 'd';

    if (size > 2)
    {
        switch (size)
        {
        case 3:
            size = SIZ_WORD;
            regName = 'a';
            break;
        case 7:
            size = SIZ_LONG;
            regName = 'a';
            break;
        default:
            return 0;
        }
    }

    if (get_eff_addr(ci, EaString, mode, reg, size))
    {
        sprintf (ci->opcode, "%s,%c%d", EaString, regName,
                (ci->cmd_wrd >> 9) & 7);
        strcpy (ci->mnem, op->name);
        strcat (ci->mnem, SizSufx[size]);
        return 1;
    }

    return 0;
}
int addq_subq(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    int size = (ci->cmd_wrd >> 6) & 3;
    int data = (ci->cmd_wrd >> 9) & 7;

    if ((mode == 7) && (reg > 1))
    {
        return 0;
    }

    if (data == 0)
    {
        data = 8;
    }

    if (get_eff_addr(ci, EaString, mode, reg, size))
    {
        sprintf (ci->opcode, "#%d,%s", data, EaString);
        strcpy (ci->mnem, op->name);
        strcat(ci->mnem, SizSufx[size]);
        return 1;
    }

    return 0;
}

int abcd_sbcd(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int srcReg = ci->cmd_wrd & 7;
    register int dstReg = (ci->cmd_wrd >> 9) & 7;
    register char *dot;

    if (ci->cmd_wrd & 0x08)
    {
        sprintf (ci->opcode, "-(a%d),-(a%d)", srcReg, dstReg);
    }
    else
    {
        sprintf (ci->opcode, "d%d,d%d", srcReg, dstReg);
    }

    strcpy(ci->mnem, op->name);

    if ((dot = strchr(ci->mnem, '.')))
    {
        *dot = '\0';
    }

    return 1;
}

/* *************************************************************** *
 * addTrapOpt() - If Pass 1, set up a boundary for the Trap option *
 *      so that it will disassemble correctly on Pass 2.           *
 *      if Pass 2, unget the next option word so it will be        *
 *      disassebled as a constant.                                 *
 * *************************************************************** */

void addTrapOpt(CMD_ITMS *ci, int ppos)
{
    char bndstr[100];

    if (Pass == 1)
    {
        sprintf (bndstr, "L W $ %05x-%05x", ppos, ppos+1);
        boundsline (bndstr);
    }
    else    /* If Pass 2, unget the opt so it will print as a "dc.w" */
    {
        ungetnext_w(ci);
    }
}

int trap(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int vector = ci->cmd_wrd & 0x0f;
    register int syscall = getnext_w(ci);
    unsigned int sysCallCount = sizeof(SysNames)/sizeof(SysNames[0]);
    unsigned int mathCallCount = sizeof(MathCalls)/sizeof(MathCalls[0]);

    ci->mnem[0] = '\0';

    switch (vector)
    {
    case 0:             /* System Call */
        if (IsROF)
        {
            if (Pass == 2)
            {
                struct rof_extrn *vec_ref = find_extrn (refs_code, CmdEnt + 1);
                struct rof_extrn *call_ref = find_extrn (refs_code, CmdEnt + 2);
                char *callName = NULL;

                if (call_ref != NULL)
                {
                    register int x;

                    callName = call_ref->EName.nam;

                    for (x = 0; x < sysCallCount; x++)
                    {
                        if (!strcmp(callName, SysNames[x]))
                        {

                            strcpy (ci->mnem, "os9");
                            strcpy(ci->opcode, callName);
                            return 1;
                        }
                    }
                } /* end - if call_ref != null */

                if (vec_ref)
                {
                    register char *vN = vec_ref->EName.nam;
                    register int x;

                    for (x = 0; x < mathCallCount; x++)
                    {
                        if (!strcmp("T$Math",vN) || !strcmp("T$Math",vN))
                        {
                            register int matched = FALSE;

                            if (!strcmp(callName, MathCalls[x]))
                            {
                                matched = 1;
                                break;
                            }

                            if (!matched)
                            {
                                ungetnext_w(ci);
                                return 0;
                            }
                        }
                    }

                    if (callName)
                    {
                        sprintf(ci->opcode, "%s,%s", vN, callName);
                    }
                    else
                    {
                        sprintf(ci->opcode, "%s,$%x", vN, syscall);
                    }

                    strcpy (ci->mnem, "tcall");
                    return 1;
                }
                else
                {
                    /* TODO: Check for user defined labels?? */
                    if (callName)
                    {
                        sprintf(ci->opcode, "$%x,%s", vector, callName);
                    }
                    else
                    {
                        sprintf (ci->opcode, "$%x,$%x", vector, syscall);
                    }

                    strcpy (ci->mnem, "tcall");
                    return 1;
                }
                break;
            }
        }
        else
        {
            if (Pass == 1)
            {
                if (syscall < sysCallCount)
                {
                    addlbl ('!', syscall, SysNames[syscall]);
                    /*addTrapOpt (ci, PCPos - 2);*/
                    return 1;
                }
                else
                {
                    ungetnext_w(ci);
                    return 0;
                }
            }
            else
            {
                strcpy (ci->opcode, SysNames[syscall]);
                strcpy (ci->mnem, "os9");
                return 1;
            }
        }
    case 0x0f:          /* Math trap   */
        if (syscall < sizeof(MathCalls)/sizeof(MathCalls[0]))
        {
            strcpy (ci->opcode, "T$Math");
            strcpy(ci->mnem, "tcall");
            /*addTrapOpt (ci, PCPos - 2);*/
            return 1;
        }

        ungetnext_w (ci);
        return 0;
        break;
    default:
        /* TODO: Provide for user-defined labels */
        sprintf (ci->opcode, "$%02x,", vector);
        sprintf (&ci->opcode[strlen(ci->opcode)], "%04x", syscall);
        strcpy (ci->mnem, "tcall");
        /*strcpy (ci->mnem, op->name);*/
        /*addTrapOpt (ci, PCPos - 2);*/
        return 1;
    }

    ungetnext_w (ci);
    return 0;
}

int cmd_stop(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    sprintf(ci->opcode, "#%d", getnext_w(ci));
    strcpy (ci->mnem, op->name);
    return 1;
}

int cmd_dbcc(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    /*int br_from = PCPos;
    register int dest;*/
    char *condpos;

    strcpy (ci->mnem, op->name);

    if ((condpos = strchr(ci->mnem, '~')))
    {
        register int offset;
        int ent = (ci->cmd_wrd >> 8) & 0x0f;

        switch (ent)
        {
            case 0:
                strcpy (condpos, "rn");
                break;
            case 1:
                strcpy (condpos, "ra");
                break;
            default:
                strcpy(condpos, typecondition[ent].condition);
        }

        offset = getnext_w(ci);
        /*dest  = br_from + offset;*/

        /*process_label (ci, 'L', dest);*/
        AMode = AM_REL;
        PCPos -= 2;
        EaString[0] = '\0';
        LblCalc (EaString, offset, AM_REL, PCPos);
        PCPos += 2;
        sprintf (ci->opcode, "d%d,%s", ci->cmd_wrd & 7, EaString);

        return 1;
    }

    return 0;
}

int cmd_scc(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    char *condpos;

    if (mode == 1)
    {
        return 0;
    }

    if ((mode == 7) && (reg > 1))
    {
        return 0;
    }

    strcpy (ci->mnem, op->name);

    if ((condpos = strchr(ci->mnem, '~')))
    {
        strcpy(condpos, typecondition[(ci->cmd_wrd >> 8) & 0x0f].condition);

        if ( get_eff_addr(ci, EaString, mode, reg, SIZ_BYTE))
        {
            strcpy(ci->opcode, EaString);
            return 1;
        }
    }

    return 0;
}

int cmd_exg(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int regnumSrc = (ci->cmd_wrd >> 9) & 7;
    register int regnumDst = ci->cmd_wrd & 7;
    char regnameSrc = 'd';
    char regnameDst = 'd';
    char *dot;

    switch ((ci->cmd_wrd >> 3) & 0x1f)
    {
    case 0x08:
        break;
    case 0x81:
        regnameSrc = 'a';
    case 0x11:
        regnameDst = 'a';
        break;
    default:
        return 0;
    }

    sprintf (ci->opcode, "%c%d,%c%d", regnameSrc,regnumSrc,regnameDst, regnumDst);
    strcpy (ci->mnem, op->name);

    if ((dot = strchr(ci->mnem, '.')))
    {
        *dot = '\0';
    }

    return 1;
}

int ext_extb(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register char *sufx;

    sprintf (ci->opcode, "d%d", ci->cmd_wrd & 7);
    strcpy (ci->mnem, op->name);

    switch (ci->cmd_wrd & 0x01c0)
    {
    case 0x80:
        sufx = "w";
        break;
    case 0xc0:
        sufx = "l";
        break;
    case 0x1c0:
        if (cpu < 2)
        {
            return 0;
        }

        sufx = "l";
    default:
        return 0;
    }

    strcat (ci->mnem, sufx);
    return 1;
}

int cmpm_addx_subx(CMD_ITMS *ci, int j, OPSTRUCTURE *op)
{
    register int srcRegno = ci->cmd_wrd & 7;
    register int dstRegno = (ci->cmd_wrd >> 9) & 7;
    register int size = (ci->cmd_wrd >> 6) & 3;
    char *opcodeFmt;

    if (size == 3)
    {
        return 0;
    }

    switch (ci->cmd_wrd & 0xf000)
    {
    case 0xb000:            /* cmpm */
        opcodeFmt = "(a%d)+,(a%d)+";
        break;
    default:                /* addx/subx */
        if (ci->cmd_wrd & 8)
        {
            opcodeFmt = "-(a%d),-(a%d)";
        }
        else
        {
            opcodeFmt = "D%d,D%d";
        }
    }

    sprintf (ci->opcode, opcodeFmt, srcRegno, dstRegno);
    strcpy (ci->mnem, op->name);
    strcat (ci->mnem, SizSufx[size]);

    return 1;
}
