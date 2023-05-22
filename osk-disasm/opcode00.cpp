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

#include "pch.h"

#include "opcode00.h"

#include <string.h>

#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "disglobs.h"
#include "dprint.h"
#include "label.h"
#include "main_support.h"
#include "rof.h"
#include "sysnames.h"
#include "textdef.h"
#include "userdef.h"

static const uint8_t MATH_TRAP_LIB = 15;
static const char const* MATH_TRAP_LIB_NAME = "T$Math";

enum
{
    EA2REG,
    REG2EA
};

static int branch_common(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state, int32_t displ,
                         OperandSize size, uint32_t immAddress, uint8_t conditionCode);

/*
 * Immediate bit operations involving the status registers (ori, andi, eori)
 * Returns 1 on success, 0 on failure
 */
int biti_reg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    if (!hasnext_w(state)) return 0;
    uint16_t ext1 = getnext_w(ci, state);
    auto reg = ((ci->cmd_wrd >> 6) & 1) == 0 ? Register::CCR : Register::SR;

    if ((reg == Register::CCR) && (ext1 > 0x1f))
    {
        ungetnext_w(ci, state);
        return 0;
    }

    strcpy(ci->mnem, op->name);
    ci->setSource(LiteralParam(FormattedNumber(ext1, OperandSize::Byte, &LITERAL_DEC_SPACE)));
    ci->setDest(RegParam(reg));

    return 1;
}

/*
 * Immediate bit operations not involving status registers
 */
// Note, all immediate values are unsigned (SUBI, CMPI don't sign extend, rest are
// bitwise.)
int biti_size(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    uint8_t size = (ci->cmd_wrd >> 6) & 3;
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t regCode = (ci->cmd_wrd) & 7;

    OperandSize sizeOp;
    switch (size)
    {
    case SIZ_BYTE:
        sizeOp = OperandSize::Byte;
        break;
    case SIZ_WORD:
        sizeOp = OperandSize::Word;
        break;
    case SIZ_LONG:
        sizeOp = OperandSize::Long;
        break;
    default:
        return 0;
    }

    if (mode == DirectAddrReg) return 0;
    if (!isWritableMode(mode, regCode)) return 0;

    AddrSpaceHandle space = &LITERAL_HEX_SPACE;
    if (op->id == InstrId::SUBI || op->id == InstrId::CMPI)
    {
        space = &LITERAL_DEC_SPACE;
    }

    /* The source here is always immediate, but go through
     * get_eff_addr to get the label, if needed
     */
    ci->source = get_eff_addr(ci, (uint8_t)Special, (uint8_t)ImmediateData, sizeOp, state, space);
    if (!ci->source) return 0;

    ci->dest = get_eff_addr(ci, mode, regCode, sizeOp, state);
    if (!ci->dest) return 0;

    auto mnem = std::string(op->name) + getOperandSizeLetter(sizeOp);
    strcpy(ci->mnem, mnem.c_str());
    return 1;
}

int bit_static(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t regCode = ci->cmd_wrd & 7;

    if (mode == DirectAddrReg) return 0;
    if (!isWritableMode(mode, regCode)) return 0;

    if (!hasnext_w(state)) return 0;
    uint16_t ext1 = getnext_w(ci, state);

    // Also the bit number has limits: 32 for D registers, 8 for all other modes.
    if (mode == DirectDataReg && ext1 > 32)
    {
        ungetnext_w(ci, state);
        return 0;
    }
    else if (mode != DirectDataReg && ext1 > 8)
    {
        ungetnext_w(ci, state);
        return 0;
    }

    OperandSize sizeOp = mode == DirectDataReg ? OperandSize::Long : OperandSize::Byte;

    // The literal only makes sense as a decimal number.
    ci->setSource(LiteralParam(FormattedNumber(ext1, OperandSize::Byte, &LITERAL_DEC_SPACE)));

    // Any literals tested should be hexadecimal.
    ci->dest = get_eff_addr(ci, mode, regCode, sizeOp, state, &LITERAL_HEX_SPACE);
    if (!ci->dest) return 0;

    auto mnem = std::string(op->name) + getOperandSizeLetter(sizeOp);
    strcpy(ci->mnem, mnem.c_str());
    return 1;
}

int bit_dynamic(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;
    uint8_t sourceRegCode = (ci->cmd_wrd >> 9) & 7;
    uint8_t destMode = (ci->cmd_wrd >> 3) & 7;
    uint8_t destRegCode = ci->cmd_wrd & 7;

    if (destMode == DirectAddrReg) return 0;

    switch (op->id)
    {
    case InstrId::BTST_DYNAMIC:
        // All modes (other than DirectAddrReg) are allowed.
        break;
    default:
        // Only writeable modes are allowed.
        if (!isWritableMode(destMode, destRegCode)) return 0;
    }

    OperandSize size = destMode == DirectDataReg ? OperandSize::Long : OperandSize::Byte;

    ci->dest = get_eff_addr(ci, destMode, destRegCode, size, state);
    if (!ci->dest) return 0;

    ci->setSource(RegParam(Registers::makeDReg(sourceRegCode), RegParamMode::Direct));
    auto mnem = std::string(op->name) + getOperandSizeLetter(size);
    strcpy(ci->mnem, mnem.c_str());
    return 1;
}

/*
 *  Build the "move"/"movea" commands
 */
int move_instr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    // Move instructions encode size a bit different
    OperandSize size;
    uint8_t sizeBits = (ci->cmd_wrd >> 12) & 3;
    switch (sizeBits)
    {
    case 0b01:
        size = OperandSize::Byte;
        break;
    case 0b11:
        size = OperandSize::Word;
        break;
    case 0b10:
        size = OperandSize::Long;
        break;
    default:
        return 0;
    }

    uint8_t d_reg = (ci->cmd_wrd >> 9) & 7;
    uint8_t d_mode = (ci->cmd_wrd >> 6) & 7;
    uint8_t src_mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t src_reg = ci->cmd_wrd & 7;

    if (size == OperandSize::Byte && d_mode == DirectAddrReg) return 0;
    if (!isWritableMode(d_mode, d_reg)) return 0;

    ci->source = get_eff_addr(ci, src_mode, src_reg, size, state);
    if (!ci->source) return 0;
    ci->dest = get_eff_addr(ci, d_mode, d_reg, size, state);
    if (!ci->dest) return 0;

    std::string mnem(d_mode == DirectAddrReg ? "movea" : "move");
    mnem += getOperandSizeSuffix(size);
    strcpy(ci->mnem, mnem.c_str());

    return 1;
}

int move_ccr_sr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    /* direction is actually 2 bytes, but this lets REG2EA/EA2REG to work */
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t regCode = ci->cmd_wrd & 7;

    // None of the directions or registers allow DirectAddrReg mode.
    if (mode == DirectAddrReg) return 0;

    // First, figure out the register to use.
    Register specialReg;
    switch (op->id)
    {
    case InstrId::MOVE_TO_CCR:
    case InstrId::MOVE_FROM_CCR:
        specialReg = Register::CCR;
        break;
    case InstrId::MOVE_TO_SR:
    case InstrId::MOVE_FROM_SR:
        specialReg = Register::SR;
        break;
    default:
        throw std::runtime_error("Unexpected op id");
    }

    // Next figure out direction.
    switch (op->id)
    {
    case InstrId::MOVE_TO_SR:
    case InstrId::MOVE_TO_CCR:
        ci->source = get_eff_addr(ci, mode, regCode, OperandSize::Word, state);
        ci->setDest(RegParam(specialReg, RegParamMode::Direct));
        if (!ci->source) return 0;
        break;
    case InstrId::MOVE_FROM_SR:
    case InstrId::MOVE_FROM_CCR:
        // Check that the destination is writable first.
        if (!isWritableMode(mode, regCode)) return 0;

        ci->setSource(RegParam(specialReg, RegParamMode::Direct));
        ci->dest = get_eff_addr(ci, mode, regCode, OperandSize::Word, state);
        if (!ci->dest) return 0;
        break;
    default:
        // Unreachable
        ;
    }
    strcpy(ci->mnem, op->name);
    return 1;
}

int move_usp(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    uint8_t regCode = ci->cmd_wrd & 7;
    bool moveFromUSP = ((ci->cmd_wrd >> 3) & 1) != 0;

    const RegParam usp(Register::USP, RegParamMode::Direct);
    const RegParam otherReg(Registers::makeAReg(regCode), RegParamMode::Direct);

    if (moveFromUSP)
    {
        ci->setSource(usp);
        ci->setDest(otherReg);
    }
    else
    {
        ci->setSource(otherReg);
        ci->setDest(usp);
    }

    strcpy(ci->mnem, op->name);

    return 1;
}

int movep(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int addr_reg = ci->cmd_wrd & 7;
    register int opMode = (ci->cmd_wrd >> 6) & 7;
    register int size = (opMode & 1) ? SIZ_LONG : SIZ_WORD;
    char DReg[4];
    char AReg[50];
    if (!hasnext_w(state)) return 0;
    int disp = getnext_w(ci, state);
    static char opcodeFmt[8];

    strcpy(opcodeFmt, "%s,%s");
    sprintf(DReg, "d%d", (ci->cmd_wrd >> 9) & 7);

    if (disp == 0)
    {
        sprintf(AReg, "(a%d)", addr_reg);
    }
    else
    {
        // TODO: Account for labels!
        sprintf(AReg, "%d(a%d)", disp, addr_reg);
    }

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

int moveq(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    uint8_t immParamValue = ci->cmd_wrd & 0xff;

    char labelBuffer[200];
    labelBuffer[0] = '\0';
    // The immediate value is at address+1
    auto immParamAddress = state->CmdEnt + 1;
    if (LblCalc(labelBuffer, immParamValue, AM_IMM, immParamAddress, state->opt->IsROF, state->Pass))
    {
        ci->setSource(LiteralParam(std::string(labelBuffer)));
    }
    else
    {
        ci->setSource(LiteralParam(FormattedNumber(immParamValue, OperandSize::Byte)));
    }

    uint8_t destRegCode = (ci->cmd_wrd >> 9) & 7;
    ci->setDest(RegParam(Registers::makeDReg(destRegCode), RegParamMode::Direct));

    strcpy(ci->mnem, op->name);

    return 1;
}

/*
 * A generic handler for when the basic command is a
 *      single word and the EA is in the lower 6 bytes
 */
int one_ea_sized(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t reg = ci->cmd_wrd & 7;
    uint8_t size = (ci->cmd_wrd >> 6) & 3;

    OperandSize sizeOp;
    switch (size)
    {
    case SIZ_BYTE:
        sizeOp = OperandSize::Byte;
        break;
    case SIZ_WORD:
        sizeOp = OperandSize::Word;
        break;
    case SIZ_LONG:
        sizeOp = OperandSize::Long;
        break;
    default:
        return 0;
    }

    // TST allows all modes.
    if (op->id != InstrId::TST)
    {
        // Disallow address regs, and the EA needs to be writable.
        if (mode == DirectAddrReg) return 0;
        if (!isWritableMode(mode, reg)) return 0;
    }

    ci->source = get_eff_addr(ci, mode, reg, sizeOp, state);
    if (!ci->source) return 0;

    auto mnem = std::string(op->name) + getOperandSizeLetter(sizeOp);
    strcpy(ci->mnem, mnem.c_str());
    return 1;
}

int one_ea(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t reg = ci->cmd_wrd & 7;

    /* eliminate modes */
    if ((mode < 2) || (mode == 3) || (mode == 4)) return 0;
    if (mode == 7 && reg == 4) return 0;

    ci->source = get_eff_addr(ci, mode, reg, OperandSize::Long, state);
    if (!ci->source) return 0;

    strcpy(ci->mnem, op->name);

    return 1;
}

int swap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    uint8_t regCode = ci->cmd_wrd & 7;
    ci->setSource(RegParam(Registers::makeDReg(regCode), RegParamMode::Direct));
    strcpy(ci->mnem, op->name);
    return 1;
}

int cmd_no_opcode(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->params[0] = '\0';
    strcpy(ci->mnem, op->name);

    return 1;
}

int bit_rotate_mem(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    int mode = (ci->cmd_wrd >> 3) & 7;
    int reg = ci->cmd_wrd & 7;
    char ea[150];

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

int bit_rotate_reg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
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

int branch(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;
    uint8_t conditionCode = (ci->cmd_wrd >> 8) & 0x0f;
    int32_t displ = ci->cmd_wrd & 0xff;
    OperandSize size;
    uint32_t immAddress;

    if (displ == 0)
    {
        immAddress = state->PCPos;
        if (!hasnext_w(state)) return 0;
        displ = (int16_t)getnext_w(ci, state);

        size = OperandSize::Word;
    }
    else if (displ == 0xff)
    {
        return 0; /* Long branch not available for < 68020 */
    }
    else
    {
        immAddress = state->CmdEnt + 1;
        /* Sign extend the 8-bit displacement */
        displ = (int8_t)displ;
        size = OperandSize::Byte;
    }

    // Condition codes 0 (true) and 1 (false) aren't allowed.
    if (op->id != InstrId::BRA && op->id != InstrId::BSR && conditionCode <= 1) return 0;

    return branch_common(ci, op, state, displ, size, immAddress, conditionCode);
}

int cmd_dbcc(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;

    uint8_t conditionCode = (ci->cmd_wrd >> 8) & 0x0f;
    uint32_t immAddress = state->PCPos;
    if (!hasnext_w(state)) return 0;
    int16_t displ = getnext_w(ci, state);

    if (branch_common(ci, op, state, displ, OperandSize::Word, immAddress, conditionCode))
    {
        // Swap the source into the destination.
        ci->source.swap(ci->dest);

        // Decode the register parameter.
        uint8_t regCode = ci->cmd_wrd & 7;
        auto reg = Registers::makeDReg(regCode);
        ci->setSource(RegParam(reg, RegParamMode::Direct));

        return 1;
    }
    return 0;
}

static int branch_common(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state, int32_t displ,
                         OperandSize size, uint32_t immAddress, uint8_t conditionCode)
{
    if (displ & 1) return 0;

    char temp[200];
    temp[0] = '\0';
    if (state->opt->IsROF && rof_setup_ref(refs_code, immAddress, temp, displ))
    {
        ci->setSource(LiteralParam(temp));
    }
    else if (LblCalc(temp, displ, AM_REL, state->CmdEnt + 2, state->opt->IsROF, state->Pass))
    {
        if (displ == 0) return 0;
        ci->setSource(LiteralParam(temp));
    }
    else
    {
        if (displ == 0) return 0;
        ci->setSource(LiteralParam(FormattedNumber(displ, size)));
    }

    std::string mnem(op->name);
    auto conditionStart = mnem.find('~');
    if (conditionStart != std::string::npos)
    {
        mnem = mnem.substr(0, conditionStart);
        mnem += typecondition[conditionCode].condition;
    }

    // DBcc is always word sized, so no suffix is needed.
    if (op->id != InstrId::DBCC)
    {
        // Branches use ".s" instead of ".b"
        if (size == OperandSize::Byte)
        {
            mnem += ".s";
        }
        else
        {
            mnem += getOperandSizeSuffix(size);
        }
    }
    strcpy(ci->mnem, mnem.c_str());

    return 1;
}

/*
 * Handles add, sub, and, or, eor instructions
 *   Cmd modes:
 *     1000 - "or"
 *     1001 - "sub"
 *     1011 - "eor"
 *     1100 - "and"
 *     1101 - "add"
 */
int add_sub(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;
    uint8_t ea_mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t ea_reg = ci->cmd_wrd & 7;
    uint8_t size = (ci->cmd_wrd >> 6) & 3;
    bool eaIsDest = ((ci->cmd_wrd >> 8) & 1) != 0;
    uint8_t dataRegCode = (ci->cmd_wrd >> 9) & 7;

    auto dataReg = Registers::makeDReg(dataRegCode);

    OperandSize sizeOp;
    switch (size)
    {
    case SIZ_BYTE:
        sizeOp = OperandSize::Byte;
        break;
    case SIZ_WORD:
        sizeOp = OperandSize::Word;
        break;
    case SIZ_LONG:
        sizeOp = OperandSize::Long;
        break;
    default:
        return 0;
    }

    if (eaIsDest)
    {
        if (!isWritableMode(ea_mode, ea_reg)) return 0;

        if (op->id == InstrId::EOR)
        {
            // EOR allows DirectDataReg destination, because it's not reversible.
            if (ea_mode == DirectAddrReg) return 0;
        }
        else
        {
            // Address and data registers aren't allowed.
            if (ea_mode == DirectAddrReg || ea_mode == DirectDataReg) return 0;
        }
        ci->setSource(RegParam(dataReg, RegParamMode::Direct));
        ci->dest = get_eff_addr(ci, ea_mode, ea_reg, sizeOp, state);
        if (!ci->dest) return 0;
    }
    else
    {
        switch (op->id)
        {
        case InstrId::EOR:
            // EOR only goes one direction.
            return 0;
        case InstrId::ADD:
        case InstrId::SUB:
            // Address registers can be used for "sub" and "add", unless the size is byte.
            if (ea_mode == DirectAddrReg && sizeOp == OperandSize::Byte) return 0;
            break;
        default:
            // Other opcodes don't allow address reg sources
            if (ea_mode == DirectAddrReg) return 0;
            break;
        }

        ci->source = get_eff_addr(ci, ea_mode, ea_reg, sizeOp, state);
        if (!ci->source) return 0;
        ci->setDest(RegParam(dataReg, RegParamMode::Direct));
    }

    auto mnem = std::string(op->name) + getOperandSizeLetter(sizeOp);
    strcpy(ci->mnem, mnem.c_str());
    return 1;
}

int add_sub_addr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;
    uint8_t sourceMode = (ci->cmd_wrd >> 3) & 7;
    uint8_t sourceRegCode = ci->cmd_wrd & 7;
    uint8_t destRegCode = (ci->cmd_wrd >> 9) & 7;
    auto destReg = Registers::makeAReg(destRegCode);

    bool isLong = (ci->cmd_wrd >> 8) & 1;
    OperandSize size = isLong ? OperandSize::Long : OperandSize::Word;

    // All EA modes are allowed
    ci->source = get_eff_addr(ci, sourceMode, sourceRegCode, size, state);
    if (!ci->source) return 0;

    ci->setDest(RegParam(destReg, RegParamMode::Direct));

    auto mnem = std::string(op->name) + getOperandSizeLetter(size);
    strcpy(ci->mnem, mnem.c_str());
    return 1;
}

int cmp_cmpa(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
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
        if (size >= 3) throw std::runtime_error("SizSufx overrun");
        strcat(ci->mnem, SizSufx[size]);
        return 1;
    }

    return 0;
}
int addq_subq(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t reg = ci->cmd_wrd & 7;
    uint8_t size = (ci->cmd_wrd >> 6) & 3;
    uint8_t data = (ci->cmd_wrd >> 9) & 7;

    if (!isWritableMode(mode, reg)) return 0;

    if (data == 0)
    {
        data = 8;
    }

    OperandSize sizeOp;
    switch (size)
    {
    case SIZ_BYTE:
        sizeOp = OperandSize::Byte;
        break;
    case SIZ_WORD:
        sizeOp = OperandSize::Word;
        break;
    case SIZ_LONG:
        sizeOp = OperandSize::Long;
        break;
    default:
        return 0;
    }

    ci->dest = get_eff_addr(ci, mode, reg, sizeOp, state);
    if (!ci->dest) return 0;

    ci->setSource(LiteralParam(FormattedNumber(data, OperandSize::Byte)));

    auto mnem = std::string(op->name) + getOperandSizeLetter(sizeOp);
    strcpy(ci->mnem, mnem.c_str());

    return 1;
}

int abcd_sbcd(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
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

int trap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->useNewParams = true;
    uint8_t vector = ci->cmd_wrd & 0x0f;
    if (!hasnext_w(state)) return 0;
    uint16_t trapNumber = getnext_w(ci, state);
    const size_t sysCallCount = sizeof(SysNames) / sizeof(SysNames[0]);
    const size_t mathCallCount = sizeof(MathCalls) / sizeof(MathCalls[0]);

    struct rof_extrn* vec_ref = nullptr;
    struct rof_extrn* call_ref = nullptr;
    if (state->opt->IsROF)
    {
        vec_ref = find_extrn(refs_code, state->CmdEnt + 1);
        call_ref = find_extrn(refs_code, state->CmdEnt + 2);
    }

    // Start with vec_ref.
    bool shouldGuessSyscall = false;
    bool shouldGuessMathLib = false;
    bool vectorHasName = true;
    if (vec_ref)
    {
        ci->setSource(LiteralParam(extern_def_name(vec_ref)));
        strcpy(ci->mnem, "tcall");

        // Only guess math syscall if this is the math trap lib.
        shouldGuessMathLib = !strcmp(extern_def_name(vec_ref), MATH_TRAP_LIB_NAME);
    }
    else if (vector == 0)
    {
        strcpy(ci->mnem, "os9");
        shouldGuessSyscall = true;
    }
    else
    {
        strcpy(ci->mnem, "tcall");
        vectorHasName = false;

        // We may change this later if the syscall matches something from T$Math
        ci->setSource(LiteralParam(FormattedNumber(vector, OperandSize::Byte)));
        shouldGuessMathLib = vector == MATH_TRAP_LIB;
    }

    // Then do call_ref.
    if (call_ref)
    {
        // No need to guess anything.
        ci->setDest(LiteralParam(extern_def_name(call_ref)));
    }
    else if (shouldGuessSyscall && trapNumber < sysCallCount)
    {
        auto syscall = SysNames[trapNumber];
        if (strlen(syscall) != 0)
        {
            addlbl(&EQUATE_SPACE, trapNumber, syscall);
            ci->setDest(LiteralParam(syscall));
        }
    }
    else if (shouldGuessMathLib && trapNumber < mathCallCount)
    {
        auto functionName = MathCalls[trapNumber];
        if (strlen(functionName) != 0)
        {
            // Successful match. Ensure the vector has the T$Math name.
            if (!vectorHasName)
            {
                addlbl(&EQUATE_SPACE, MATH_TRAP_LIB, MATH_TRAP_LIB_NAME);
                ci->setSource(LiteralParam(MATH_TRAP_LIB_NAME));
            }

            addlbl(&EQUATE_SPACE, trapNumber, functionName);
            ci->setDest(LiteralParam(functionName));
        }
    }

    // If we were unable to guess the trap name, give it a number literal.
    if (!ci->dest)
    {
        ci->setDest(LiteralParam(FormattedNumber(trapNumber, OperandSize::Word)));
    }

    // If ci->source is null (an os9 syscall), move dest to source.
    if (!ci->source)
    {
        ci->dest.swap(ci->source);
    }

    return 1;
}

int cmd_stop(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    if (!hasnext_w(state)) return 0;
    sprintf(ci->params, "#%d", getnext_w(ci, state));
    strcpy(ci->mnem, op->name);
    return 1;
}

int cmd_scc(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
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

int cmd_exg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    register int regnumSrc = (ci->cmd_wrd >> 9) & 7;
    register int regnumDst = ci->cmd_wrd & 7;
    char regnameSrc = 'd';
    char regnameDst = 'd';
    char* dot;

    int opMode = (ci->cmd_wrd >> 3) & 0x1f;
    switch (opMode)
    {
    case 0x08:
        // Both are data registers
        break;
    case 0x09:
        // Both are address registers
        regnameSrc = 'a';
        regnameDst = 'a';
        break;
    case 0x11:
        // Source is data, dest is address
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

int ext_extb(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
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

int cmpm_addx_subx(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
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
            opcodeFmt = "d%d,d%d";
        }
    }

    sprintf(ci->params, opcodeFmt, srcRegno, dstRegno);
    strcpy(ci->mnem, op->name);
    if (size >= 3) throw std::runtime_error("SizSufx overrun");
    strcat(ci->mnem, SizSufx[size]);

    return 1;
}
