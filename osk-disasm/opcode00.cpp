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

#include <sstream>
#include <string.h>

#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "disglobs.h"
#include "dprint.h"
#include "label.h"
#include "main_support.h"
#include "opcode00.h"
#include "rof.h"
#include "sysnames.h"
#include "textdef.h"
#include "userdef.h"

enum
{
    EA2REG,
    REG2EA
};

/*
 * Immediate bit operations involving the status registers
 * Returns 1 on success, 0 on failure
 */
int biti_reg(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    static char* sr[2] = {"ccr", "sr"};
    register int size;

    register int ext1 = getnext_w(ci, state);
    size = (ci->cmd_wrd >> 6) & 1;

    /*    if (ext1 & 0xff00)
        {
            ungetnext_w(ci);
            return 0;
        }*/

    if ((size == 0) && (ext1 > 0x1f))
    {
        ungetnext_w(ci, state);
        return 0;
    }

    /* Add functions to retrieve label */
    if (state->Pass == 2)
    {
        strcpy(ci->mnem, op->name);
        sprintf(ci->params, "#%d,%s", ext1, sr[size]);
    }

    return 1;
}

/*
 * Immediate bit operations not involving status registers
 */
int biti_size(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int size = (ci->cmd_wrd >> 6) & 3;
    register int mode = (ci->cmd_wrd >> 3) & 7;
    register int reg;
    /*register int firstword = ci->wcount;*/
    char ea[30];
    int data;

    std::ostringstream EaStringBuffer;
    reg = (ci->cmd_wrd) & 7;

    if ((ci->cmd_wrd & 0x023c) == 0x023c)
    {
        switch (ci->cmd_wrd)
        {
        case 0x023c:
            EaStringBuffer << "ccr";
            size = SIZ_BYTE;
            break;
        case 0x027c:
            EaStringBuffer << "sr";
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
    if (!get_eff_addr(ci, ea, 7, 4, size, state))
    {
        return 0;
    }

    switch (size)
    {
    case SIZ_BYTE:
        data = ci->code[0];

        if ((data < -128) || (data > 0xff))
        {
            ungetnext_w(ci, state);
            return 0;
        }

        break;
    case SIZ_WORD:
        data = ci->code[0];

        if ((data < -32768) || (data > 0xffff))
        {
            ungetnext_w(ci, state);
            return 0;
        }

        break;
    case SIZ_LONG:
        break;
    }

    auto eaStringResult = EaStringBuffer.str();
    if (eaStringResult.empty())
    {
        char tmp[200];
        if (!get_eff_addr(ci, tmp, mode, reg, SIZ_LONG, state))
        {
            return 0;
        }
        eaStringResult = tmp;
    }

    auto params = (std::string(ea) + ",") + eaStringResult;
    strcpy(ci->params, params.c_str());

    auto mnem = std::string(op->name) + SizSufx[size];
    strcpy(ci->mnem, mnem.c_str());
    return 1;
}

int bit_static(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int ext0, mode, reg;
    char ea[30];

    mode = (ci->cmd_wrd >> 3) & 7;
    reg = ci->cmd_wrd & 7;

    if (mode == 1) return 0;

    ext0 = getnext_w(ci, state);

    /* The MS byte must be zero */
    if (ext0 & 0xff00)
    {
        ungetnext_w(ci, state);
        return 0;
    }

    /* Also the bt number has limits */
    if (((mode > 1) && (ext0 > 7)) || ext0 > 0x1f)
    {
        ungetnext_w(ci, state);
        return 0;
    }

    if (get_eff_addr(ci, ea, mode, reg, (ext0 > 7) ? SIZ_LONG : SIZ_BYTE, state))
    {
        sprintf(ci->params, "#%d,%s", ext0, ea);
        strcpy(ci->mnem, op->name);
        strcat(ci->mnem, (mode == 0) ? "l" : "b");
        return 1;
    }

    return 0;
}

int bit_dynamic(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int mode, reg;

    mode = (ci->cmd_wrd >> 3) & 7;
    reg = ci->cmd_wrd & 7;

    if (mode == 1) return 0;

    /*    switch (op->id)
        {
            case 4:
                if (mode == 4)
                    return 0;
            default:
                if (mode > 1)
                    return 0;
        }*/
    char ea[200];
    if (get_eff_addr(ci, ea, mode, reg, SIZ_LONG, state))
    {
        std::ostringstream paramBuffer;
        paramBuffer << 'd' << ((ci->cmd_wrd >> 9) & 7) << ',' << ea;
        auto params = paramBuffer.str();
        strcpy(ci->params, params.c_str());
        //sprintf(ci->params, "d%d,%s", (ci->cmd_wrd >> 9) & 7, ea);
        
        auto mnem = std::string(op->name) + ((mode == 0) ? "l" : "b");
        strcpy(ci->mnem, mnem.c_str());
        //strcpy(ci->mnem, op->name);
        //strcat(ci->mnem, (mode == 0) ? "l" : "b");
        return 1;
    }

    return 0;
}

/*
 *  Build the "move"/"movea" commands
 */
int move_instr(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
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

    if (get_eff_addr(ci, src_ea, src_mode, src_reg, size, state))
    {
        if (get_eff_addr(ci, dst_ea, d_mode, d_reg, size, state))
        {
            sprintf(ci->params, "%s,%s", src_ea, dst_ea);
            strcpy(ci->mnem, "move");

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

int move_ccr_sr(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    /* direction is actually 2 bytes, but this lets REG2EA/EA2REG to work */
    int dir;
    char* statReg;
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

    char EaStringBuffer[200];
    EaStringBuffer[0] = '\0';
    if (get_eff_addr(ci, EaStringBuffer, mode, reg, SIZ_WORD, state))
    {
        register char* dot;

        switch (dir)
        {
        case EA2REG:
            sprintf(ci->params, "%s,%s", EaStringBuffer, statReg);
            break;
        default:
            sprintf(ci->params, "%s,%s", statReg, EaStringBuffer);
        }

        strcpy(ci->mnem, op->name);

        dot = strchr(ci->mnem, '.');
        if (dot)
        {
            *dot = '\0';
        }

        return 1;
    }

    return 0;
}

int move_usp(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register char* dot;

    char EaStringBuffer[200];
    EaStringBuffer[0] = '\0';
    sprintf(EaStringBuffer, "A%d", ci->cmd_wrd & 7);

    if ((ci->cmd_wrd >> 3) & 1)
    {
        sprintf(ci->params, "%s,%s", "usp", EaStringBuffer);
    }
    else
    {
        sprintf(ci->params, "%s,%s", EaStringBuffer, "usp");
    }

    strcpy(ci->mnem, op->name);

    dot = strchr(ci->mnem, '.');
    if (dot)
    {
        *dot = '\0';
    }

    return 1;
}

int movep(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int addr_reg = ci->cmd_wrd & 7;
    register int opMode = (ci->cmd_wrd >> 6) & 7;
    register int size = (opMode & 1) ? SIZ_LONG : SIZ_WORD;
    char DReg[4];
    char AReg[50];
    int disp = getnext_w(ci, state);
    static char opcodeFmt[8];

    strcpy(opcodeFmt, "%s,%s");
    sprintf(DReg, "D%d", (ci->cmd_wrd >> 9) & 7);

    sprintf(AReg, "%d(A%d)", disp, addr_reg);

    if (opMode & 2)
    {
        sprintf(ci->params, opcodeFmt, DReg, AReg);
    }
    else
    {
        sprintf(ci->params, opcodeFmt, AReg, DReg);
    }

    strcpy(ci->mnem, op->name);
    strcat(ci->mnem, (size == SIZ_LONG) ? "l" : "w");
    return 1;
}

int moveq(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register char* dot;

    char EaStringBuffer[200];
    EaStringBuffer[0] = '\0';
    if (!LblCalc(EaStringBuffer, ci->cmd_wrd & 0xff, AM_IMM, state->CmdEnt, state->opt->IsROF, state->Pass))
    {
        PrintNumber(EaStringBuffer, ci->cmd_wrd & 0xff, AM_IMM, PBytSiz);
    }
    sprintf(ci->params, "#%s,d%d", EaStringBuffer, (ci->cmd_wrd >> 9) & 7);
    strcpy(ci->mnem, op->name);

    dot = strchr(ci->mnem, '.');
    if (dot)
    {
        *dot = '\0';
    }

    return 1;
}

/*
 * A generic handler for when the basic command is a
 *      single word and the EA is in the lower 6 bytes
 */
int one_ea(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    int size = (ci->cmd_wrd >> 6) & 3;
    char ea[50];

    if (strchr(op->name, '.'))
    {
        if (size >= sizeof(SizSufx) / sizeof(SizSufx[0]))
        {
            return 0;
        }
    }

    if (j == 38) /* swap */
    {
        sprintf(ci->params, "d%d", ci->cmd_wrd & 7);
    }
    else
    {
        /* eliminate modes */
        switch (op->id)
        {
        case 38:   /* swap */
        case 43:   /* tst  */
            break; /* Allow all modes */
        case 39:   /* pea  */
        case 57:   /* jsr  */
        case 58:   /* jmp  */
            if ((mode < 2) || (mode == 3) || (mode == 4)) return 0;
        default:
            if (mode == 1) return 0;
        }

        /* Eliminate mode-7 regs */

        if (mode == 7)
        {
            switch (op->id)
            {
            case 32: /* Allow all modes */
            case 38:
                break;
            case 39:
            case 57: /* jsr  */
            case 58: /* jmp  */
                if (reg == 4) return 0;
                break;
            default:
                if (reg > 1) return 0;
            }
        }

        /* Handle opcode */

        if (get_eff_addr(ci, ea, mode, reg, size, state))
        {
            char* statreg = "ccr";

            switch (op->id)
            {
            case 28: /* Move from SR */
                statreg = "sr";
            case 33: /* Move to CCR  */
            case 35: /* Move from CCR */
                if (ci->cmd_wrd & 0x400)
                    sprintf(ci->params, "%s,%s", ea, statreg);
                else
                    sprintf(ci->params, "%s,%s", statreg, ea);
                break;
            default: /* A single ea */
                strcpy(ci->params, ea);
                break;
            }
        }
        else
        {
            return 0;
        }
    }

    strcpy(ci->mnem, op->name);

    if (strchr(ci->mnem, '.'))
    {
        strcat(ci->mnem, SizSufx[size]);
    }

    return 1;
}

/*
 * Calculates the size of a branch and places the size
 *          suffix in the string provided in the parameters.
 * Returns: The branch size (sign extended) if valid, 0 on uneven branch size
 */
static int branch_displ(struct cmd_items* ci, int cmd_word, char* siz_suffix, struct parse_state* state)
{
    register int displ = cmd_word & 0xff;

    switch (displ)
    {
    case 0:
        displ = getnext_w(ci, state);

        if (displ & 1)
        {
            ungetnext_w(ci, state);
            return 0;
        }

        strcpy(siz_suffix, "w");
        break;
    case 0xff:
        return 0; /* Long branch not available for < 68020 */
    default:
        if (displ & 1) return 0;

        /* Sign extend the 8-bit displacement */
        if (displ & 0x80)
        {
            displ |= (-1 ^ 0xff);
        }

        strcpy(siz_suffix, "s");
    }

    return displ;
}

int bra_bsr(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int displ;
    register int jmp_base = state->PCPos;
    char siz[4];

    displ = branch_displ(ci, ci->cmd_wrd, siz, state);

    if (displ & 1) return 0;

    if (!state->opt->IsROF)
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
            ref_addr = state->CmdEnt + 2;
        }
        else
        {
            ref_addr = state->CmdEnt + 1;
        }

        if (rof_setup_ref(refs_code, ref_addr, ci->params, displ))
        {
            strcpy(ci->mnem, op->name);
            strcat(ci->mnem, siz);
            return 1;
        }
        else
        {
            if (displ == 0) return 0;
        }
    }

    strcpy(ci->mnem, op->name);
    strcat(ci->mnem, siz);
    /*dstAddr = jmp_base + displ;

    //if (IsROF && (Pass == 2))
    //{
    //    if (IsRef(ci->params, jmp_base))
    //    {
    //        return 1;
    //    }
    //}*/

    if (!LblCalc(ci->params, displ, AM_REL, jmp_base, state->opt->IsROF, state->Pass))
    {
        PrintNumber(ci->params, displ, AM_REL, PBytSiz);
    }

    return 1;
}

int cmd_no_opcode(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->params[0] = '\0';
    strcpy(ci->mnem, op->name);

    return 1;
}

int bit_rotate_mem(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
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

    if (get_eff_addr(ci, ea, mode, reg, 8, state))
    {
        if (state->Pass == 2)
        {
            strcpy(ci->params, ea);
            strcpy(ci->mnem, op->name);
        }

        return 1;
    }

    return 0;
}

int bit_rotate_reg(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int count_reg = (ci->cmd_wrd >> 9) & 7;
    char dest_ea[5];

    switch ((ci->cmd_wrd >> 5) & 1)
    {
    case 0:
        sprintf(ci->params, "#%d,", (count_reg == 0) ? 8 : count_reg);
        break;
    default:
        sprintf(ci->params, "d%d,", count_reg);
    }

    sprintf(dest_ea, "d%d", ci->cmd_wrd & 7);
    strcat(ci->params, dest_ea);
    strcpy(ci->mnem, op->name);

    /* Use count_reg to hold Size... */

    if ((count_reg = (ci->cmd_wrd >> 6) & 3) > 2)
    {
        return 0;
    }

    strcat(ci->mnem, SizSufx[count_reg]);
    return 1;
}

int br_cond(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int jmp_base = state->PCPos;
    register char* condit = typecondition[(ci->cmd_wrd >> 8) & 0x0f].condition;
    char siz[5];
    register int displ;
    char* subst;

    displ = branch_displ(ci, ci->cmd_wrd, siz, state);

    if (displ & 1) return 0;

    /* It wouldn't seem likely that a conditional branch would
     * ever branch to an external ref, and would probably ever
     * occur in C-generated code, but manually-written asm source
     * could contain this
     */

    if (state->opt->IsROF)
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
            ref_addr = state->CmdEnt + 2;
        }
        else
        {
            ref_addr = state->CmdEnt + 1;
        }

        if (rof_setup_ref(refs_code, ref_addr, ci->params, displ))
        {
            strcpy(ci->mnem, op->name);
            strcat(ci->mnem, siz);
            return 1;
        }
        else
        {
            if (displ == 0) return 0;
        }
    }

    strcpy(ci->mnem, op->name);

    subst = strchr(ci->mnem, '~');
    if (subst)
    {
        while (*condit)
        {
            *(subst++) = *(condit++);
        }

        *(subst++) = '.';
        strcpy(subst, siz);
    }
    else
    {
        return 0;
    }

    /* We need to calculate the address here */
    if (!LblCalc(ci->params, displ, AM_REL, jmp_base, state->opt->IsROF, state->Pass))
    {
        PrintNumber(ci->params, displ, AM_REL, PBytSiz);
    }
    /*sprintf (ci->params, "L%05x", jmp_base + displ);*/

    return 1;
}

typedef struct add_sub_def
{
    int size;
    int direction;
    char regname;
    int allmodes;
} ADDSUBDEF;

/*
 * Handles add, sub, and, or, eor instructions
 *   Cmd modes:
 *     1000 - "or"
 *     1001 - "sub"
 *     1011 - "eor"
 *     1100 - "and"
 *     1101 - "add"
 */
int add_sub(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    /*int datareg = (ci->cmd_wrd >> 9) & 7;*/
    int ea_mode = (ci->cmd_wrd >> 3) & 7;
    int ea_reg = ci->cmd_wrd & 7;
    register int opmode = (ci->cmd_wrd >> 6) & 7;
    register int cmdcode = ci->cmd_wrd >> 12;
    static ADDSUBDEF AddSubDefs[] = {{SIZ_BYTE, EA2REG, 'd', 0}, {SIZ_WORD, EA2REG, 'd', 0}, {SIZ_LONG, EA2REG, 'd', 0},
                                     {SIZ_WORD, EA2REG, 'a', 1}, {SIZ_BYTE, REG2EA, 'd', 0}, {SIZ_WORD, REG2EA, 'd', 0},
                                     {SIZ_LONG, REG2EA, 'd', 0}, {SIZ_LONG, EA2REG, 'a', 1}};
    register ADDSUBDEF* asDef = &AddSubDefs[opmode];
    char ea[50];

    if (asDef->direction == EA2REG)
    {
        if ((ea_mode == 1) && (asDef->size < SIZ_WORD))
        {
            return 0;
        }

        if (cmdcode == 0x1011) /* eor */
        {
            return 0;
        }

        if ((cmdcode & 3) != 1) /* Only "add"/"sub" allow An direct */
        {
            if (ea_mode == 1)
            {
                return 0;
            }
        }

        /* If not "add" or "sub", An cannot be a Dest */
        if ((cmdcode != 0x09) && (cmdcode != 0x0d))
        {
            if (asDef->regname == 'a') return 0;
        }
    }
    else /* else asDef->Direction = REG2EA */
    {
        if (cmdcode == 0x0b) /* "eor" allows Dn, others don't */
        {
            if (ea_mode == 1) return 0;
        }
        else
        {
            if (ea_mode < 2) return 0;
        }

        if ((ea_mode == 7) && (ea_reg > 1))
        {
            return 0;
        }
    }

    if (get_eff_addr(ci, ea, ea_mode, ea_reg, asDef->size, state))
    {
        if (asDef->direction == REG2EA)
        {
            sprintf(ci->params, "%c%d,%s", asDef->regname, (ci->cmd_wrd >> 9) & 7, ea);
        }
        else
        {
            sprintf(ci->params, "%s,%c%d", ea, asDef->regname, (ci->cmd_wrd >> 9) & 7);
        }

        strcpy(ci->mnem, op->name);
        strcat(ci->mnem, SizSufx[asDef->size]);
        return 1;
    }
    else
    {
        return 0;
    }
}

int cmp_cmpa(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
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

    char EaStringBuffer[200];
    EaStringBuffer[0] = '\0';
    if (get_eff_addr(ci, EaStringBuffer, mode, reg, size, state))
    {
        sprintf(ci->params, "%s,%c%d", EaStringBuffer, regName, (ci->cmd_wrd >> 9) & 7);
        strcpy(ci->mnem, op->name);
        strcat(ci->mnem, SizSufx[size]);
        return 1;
    }

    return 0;
}
int addq_subq(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
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

    char EaStringBuffer[200];
    EaStringBuffer[0] = '\0';
    if (get_eff_addr(ci, EaStringBuffer, mode, reg, size, state))
    {
        sprintf(ci->params, "#%d,%s", data, EaStringBuffer);
        strcpy(ci->mnem, op->name);
        strcat(ci->mnem, SizSufx[size]);
        return 1;
    }

    return 0;
}

int abcd_sbcd(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int srcReg = ci->cmd_wrd & 7;
    register int dstReg = (ci->cmd_wrd >> 9) & 7;
    register char* dot;

    if (ci->cmd_wrd & 0x08)
    {
        sprintf(ci->params, "-(a%d),-(a%d)", srcReg, dstReg);
    }
    else
    {
        sprintf(ci->params, "d%d,d%d", srcReg, dstReg);
    }

    strcpy(ci->mnem, op->name);

    dot = strchr(ci->mnem, '.');
    if (dot)
    {
        *dot = '\0';
    }

    return 1;
}

int trap(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int vector = ci->cmd_wrd & 0x0f;
    register int syscall = getnext_w(ci, state);
    unsigned int sysCallCount = sizeof(SysNames) / sizeof(SysNames[0]);
    unsigned int mathCallCount = sizeof(MathCalls) / sizeof(MathCalls[0]);

    ci->mnem[0] = '\0';

    switch (vector)
    {
    case 0: /* System Call */
        if (state->opt->IsROF)
        {
            if (state->Pass == 2)
            {
                struct rof_extrn* vec_ref = find_extrn(refs_code, state->CmdEnt + 1);
                struct rof_extrn* call_ref = find_extrn(refs_code, state->CmdEnt + 2);
                const char* callName = NULL;

                if (call_ref != NULL)
                {
                    register int x;

                    // callName = call_ref->EName.nam;
                    callName = extern_def_name(call_ref);

                    for (x = 0; x < sysCallCount; x++)
                    {
                        if (!strcmp(callName, SysNames[x]))
                        {

                            strcpy(ci->mnem, "os9");
                            strcpy(ci->params, callName);
                            return 1;
                        }
                    }
                } /* end - if call_ref != null */

                if (vec_ref)
                {
                    // register char *vN = vec_ref->EName.nam;
                    const char* vN = extern_def_name(vec_ref);
                    register int x;

                    for (x = 0; x < mathCallCount; x++)
                    {
                        if (!strcmp("T$Math", vN) || !strcmp("T$Math", vN))
                        {
                            register int matched = FALSE;

                            if (!strcmp(callName, MathCalls[x]))
                            {
                                matched = 1;
                                break;
                            }

                            if (!matched)
                            {
                                ungetnext_w(ci, state);
                                return 0;
                            }
                        }
                    }

                    if (callName)
                    {
                        sprintf(ci->params, "%s,%s", vN, callName);
                    }
                    else
                    {
                        sprintf(ci->params, "%s,$%x", vN, syscall);
                    }

                    strcpy(ci->mnem, "tcall");
                    return 1;
                }
                else
                {
                    /* TODO: Check for user defined labels?? */
                    if (callName)
                    {
                        sprintf(ci->params, "$%x,%s", vector, callName);
                    }
                    else
                    {
                        sprintf(ci->params, "$%x,$%x", vector, syscall);
                    }

                    strcpy(ci->mnem, "tcall");
                    return 1;
                }
                break;
            }
        }
        else
        {
            if (state->Pass == 1)
            {
                if (syscall < sysCallCount)
                {
                    addlbl('!', syscall, SysNames[syscall]);
                    return 1;
                }
                else
                {
                    ungetnext_w(ci, state);
                    return 0;
                }
            }
            else
            {
                strcpy(ci->params, SysNames[syscall]);
                strcpy(ci->mnem, "os9");
                return 1;
            }
        }
    case 0x0f: /* Math trap   */
        if (syscall < sizeof(MathCalls) / sizeof(MathCalls[0]))
        {
            strcpy(ci->params, "T$Math");
            strcpy(ci->mnem, "tcall");
            return 1;
        }

        ungetnext_w(ci, state);
        return 0;
        break;
    default:
        /* TODO: Provide for user-defined labels */
        sprintf(ci->params, "$%02x,", vector);
        sprintf(&ci->params[strlen(ci->params)], "%04x", syscall);
        strcpy(ci->mnem, "tcall");
        /*strcpy (ci->mnem, op->name);*/
        return 1;
    }

    ungetnext_w(ci, state);
    return 0;
}

int cmd_stop(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    sprintf(ci->params, "#%d", getnext_w(ci, state));
    strcpy(ci->mnem, op->name);
    return 1;
}

int cmd_dbcc(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    /*int br_from = PCPos;
    register int dest;*/
    char* condpos;

    strcpy(ci->mnem, op->name);

    condpos = strchr(ci->mnem, '~');
    if (condpos)
    {
        register int offset;
        int ent = (ci->cmd_wrd >> 8) & 0x0f;

        switch (ent)
        {
        case 0:
            strcpy(condpos, "rn");
            break;
        case 1:
            strcpy(condpos, "ra");
            break;
        default:
            strcpy(condpos, typecondition[ent].condition);
        }

        offset = getnext_w(ci, state);
        /*dest  = br_from + offset;*/

        char EaStringBuffer[200];
        EaStringBuffer[0] = '\0';
        if (!LblCalc(EaStringBuffer, offset, AM_REL, state->PCPos - 2, state->opt->IsROF, state->Pass))
        {
            PrintNumber(EaStringBuffer, offset, AM_REL, PBytSiz);
        }
        sprintf(ci->params, "d%d,%s", ci->cmd_wrd & 7, EaStringBuffer);

        return 1;
    }

    return 0;
}

int cmd_scc(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    char* condpos;

    if (mode == 1)
    {
        return 0;
    }

    if ((mode == 7) && (reg > 1))
    {
        return 0;
    }

    strcpy(ci->mnem, op->name);

    condpos = strchr(ci->mnem, '~');
    if (condpos)
    {
        strcpy(condpos, typecondition[(ci->cmd_wrd >> 8) & 0x0f].condition);

        char EaStringBuffer[200];
        EaStringBuffer[0] = '\0';
        if (get_eff_addr(ci, EaStringBuffer, mode, reg, SIZ_BYTE, state))
        {
            strcpy(ci->params, EaStringBuffer);
            return 1;
        }
    }

    return 0;
}

int cmd_exg(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int regnumSrc = (ci->cmd_wrd >> 9) & 7;
    register int regnumDst = ci->cmd_wrd & 7;
    char regnameSrc = 'd';
    char regnameDst = 'd';
    char* dot;

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

    sprintf(ci->params, "%c%d,%c%d", regnameSrc, regnumSrc, regnameDst, regnumDst);
    strcpy(ci->mnem, op->name);

    dot = strchr(ci->mnem, '.');
    if (dot)
    {
        *dot = '\0';
    }

    return 1;
}

int ext_extb(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register char* sufx;

    sprintf(ci->params, "d%d", ci->cmd_wrd & 7);
    strcpy(ci->mnem, op->name);

    switch (ci->cmd_wrd & 0x01c0)
    {
    case 0x80:
        sufx = "w";
        break;
    case 0xc0:
        sufx = "l";
        break;
    case 0x1c0:
        /* m68020+ */
        return 0;
    default:
        return 0;
    }

    strcat(ci->mnem, sufx);
    return 1;
}

int cmpm_addx_subx(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int srcRegno = ci->cmd_wrd & 7;
    register int dstRegno = (ci->cmd_wrd >> 9) & 7;
    register int size = (ci->cmd_wrd >> 6) & 3;
    char* opcodeFmt;

    if (size == 3)
    {
        return 0;
    }

    switch (ci->cmd_wrd & 0xf000)
    {
    case 0xb000: /* cmpm */
        opcodeFmt = "(a%d)+,(a%d)+";
        break;
    default: /* addx/subx */
        if (ci->cmd_wrd & 8)
        {
            opcodeFmt = "-(a%d),-(a%d)";
        }
        else
        {
            opcodeFmt = "D%d,D%d";
        }
    }

    sprintf(ci->params, opcodeFmt, srcRegno, dstRegno);
    strcpy(ci->mnem, op->name);
    strcat(ci->mnem, SizSufx[size]);

    return 1;
}
