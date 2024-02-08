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

#include "address_space.h"
#include "userdef.h"
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

static const uint8_t MATH_TRAP_LIB = 15;
static const char* const MATH_TRAP_LIB_NAME = "T$Math";

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
    if (!hasnext_w(state)) return 0;
    uint16_t ext1 = getnext_w(ci, state);
    auto reg = ((ci->cmd_wrd >> 6) & 1) == 0 ? Register::CCR : Register::SR;

    if ((reg == Register::CCR) && (ext1 > 0x1f))
    {
        ungetnext_w(ci, state);
        return 0;
    }

    ci->mnem = op->name;
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
    uint8_t size = (ci->cmd_wrd >> 6) & 3;
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t regCode = (ci->cmd_wrd) & 7;

    OperandSize sizeOp;
    if (!parseStandardSize(size, sizeOp)) return false;

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

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(sizeOp);
    return 1;
}

int bit_static(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
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

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(sizeOp);
    return 1;
}

int bit_dynamic(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
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
    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(size);
    return 1;
}

/*
 *  Build the "move"/"movea" commands
 */
int move_instr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
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

    ci->mnem = d_mode == DirectAddrReg ? "movea" : "move";
    ci->mnem += OperandSizes::getSuffix(size);
    return 1;
}

int move_ccr_sr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
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
    ci->mnem = op->name;
    return 1;
}

int move_usp(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
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

    ci->mnem = op->name;
    return 1;
}

int movep(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t addrRegCode = ci->cmd_wrd & 7;
    uint8_t dataRegCode = (ci->cmd_wrd >> 9) & 7;
    RegParam dataParam(Registers::makeDReg(dataRegCode), RegParamMode::Direct);
    auto size = ((ci->cmd_wrd >> 6) & 1) ? OperandSize::Long : OperandSize::Word;
    bool destIsMemory = (ci->cmd_wrd >> 7) & 1;

    if (destIsMemory)
    {
        ci->dest = get_eff_addr(ci, Displacement, addrRegCode, size, state);
        if (!ci->dest) return 0;
        ci->setSource(dataParam);
    }
    else
    {
        ci->source = get_eff_addr(ci, Displacement, addrRegCode, size, state);
        if (!ci->source) return 0;
        ci->setDest(dataParam);
    }

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(size);
    return 1;
}

int moveq(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t immParamValue = ci->cmd_wrd & 0xff;

    std::string labelBuffer;
    // The immediate value is at address+1
    auto immParamAddress = state->CmdEnt + 1;
    if (LblCalc(labelBuffer, immParamValue, AM_IMM, immParamAddress, state->opt->IsROF, state->Pass, OperandSize::Byte))
    {
        ci->setSource(LiteralParam(labelBuffer));
    }
    else
    {
        ci->setSource(LiteralParam(FormattedNumber(immParamValue, OperandSize::Byte)));
    }

    uint8_t destRegCode = (ci->cmd_wrd >> 9) & 7;
    ci->setDest(RegParam(Registers::makeDReg(destRegCode), RegParamMode::Direct));

    ci->mnem = op->name;
    return 1;
}

/*
 * A generic handler for when the basic command is a
 *      single word and the EA is in the lower 6 bytes
 */
int one_ea_sized(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t reg = ci->cmd_wrd & 7;
    uint8_t size = (ci->cmd_wrd >> 6) & 3;

    OperandSize sizeOp;
    if (!parseStandardSize(size, sizeOp)) return 0;

    // TST allows all modes.
    if (op->id != InstrId::TST)
    {
        // Disallow address regs, and the EA needs to be writable.
        if (mode == DirectAddrReg) return 0;
        if (!isWritableMode(mode, reg)) return 0;
    }

    ci->source = get_eff_addr(ci, mode, reg, sizeOp, state);
    if (!ci->source) return 0;

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(sizeOp);
    return 1;
}

int one_ea(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t reg = ci->cmd_wrd & 7;

    /* eliminate modes */
    if ((mode < 2) || (mode == 3) || (mode == 4)) return 0;
    if (mode == 7 && reg == 4) return 0;

    ci->source = get_eff_addr(ci, mode, reg, OperandSize::Long, state);
    if (!ci->source) return 0;

    ci->mnem = op->name;
    return 1;
}

int swap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t regCode = ci->cmd_wrd & 7;
    ci->setSource(RegParam(Registers::makeDReg(regCode), RegParamMode::Direct));
    ci->mnem = op->name;
    return 1;
}

int cmd_no_params(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->mnem = op->name;
    return 1;
}

int bit_rotate_mem(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t regCode = ci->cmd_wrd & 7;

    // Destination must be in memory.
    if (mode == DirectAddrReg || mode == DirectDataReg) return 0;

    // Destination must be writable.
    if (!isWritableMode(mode, regCode)) return 0;

    ci->source = get_eff_addr(ci, mode, regCode, OperandSize::Byte, state);
    if (!ci->source) return 0;

    ci->mnem = op->name;
    return 1;
}

int bit_rotate_reg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t countOrReg = (ci->cmd_wrd >> 9) & 7;
    bool sourceIsReg = (ci->cmd_wrd >> 5) & 1;
    uint8_t size = (ci->cmd_wrd >> 6) & 3;
    uint8_t destRegCode = ci->cmd_wrd & 7;

    if (sourceIsReg)
    {
        ci->setSource(RegParam(Registers::makeDReg(countOrReg), RegParamMode::Direct));
    }
    else
    {
        if (countOrReg == 0) countOrReg = 8;
        ci->setSource(LiteralParam(FormattedNumber(countOrReg, OperandSize::Byte)));
    }

    ci->setDest(RegParam(Registers::makeDReg(destRegCode), RegParamMode::Direct));

    OperandSize sizeOp;
    if (!parseStandardSize(size, sizeOp)) return 0;
    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(sizeOp);
    return 1;
}

int branch(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
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
    ci->forceRelativeImmediateMode = true;
    if (displ & 1) return 0;

    std::string temp;
    if (state->opt->IsROF && rof_setup_ref(temp, refManager.refs_code, immAddress, displ, state->Pass, size, true))
    {
        ci->setSource(LiteralParam(temp));
    }
    else if (LblCalc(temp, displ, AM_REL, state->CmdEnt + 2, state->opt->IsROF, state->Pass, size))
    {
        if (displ == 0) return 0;
        ci->setSource(LiteralParam(temp));
    }
    else
    {
        if (displ == 0) return 0;
        ci->setSource(LiteralParam(FormattedNumber(displ, size)));
    }

    ci->mnem = op->name;
    auto conditionStart = ci->mnem.find('~');
    if (conditionStart != std::string::npos)
    {
        ci->mnem = ci->mnem.substr(0, conditionStart);
        ci->mnem += typecondition[conditionCode].condition;
    }

    // DBcc is always word sized, so no suffix is needed.
    if (op->id != InstrId::DBCC)
    {
        // Branches use ".s" instead of ".b"
        if (size == OperandSize::Byte)
        {
            ci->mnem += ".s";
        }
        else
        {
            ci->mnem += OperandSizes::getSuffix(size);
        }
    }

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
    uint8_t ea_mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t ea_reg = ci->cmd_wrd & 7;
    uint8_t size = (ci->cmd_wrd >> 6) & 3;
    bool eaIsDest = ((ci->cmd_wrd >> 8) & 1) != 0;
    uint8_t dataRegCode = (ci->cmd_wrd >> 9) & 7;

    auto dataReg = Registers::makeDReg(dataRegCode);

    OperandSize sizeOp;
    if (!parseStandardSize(size, sizeOp)) return 0;

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

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(sizeOp);
    return 1;
}

int add_sub_addr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
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

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(size);
    return 1;
}

int cmp_cmpa(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t sourceMode = (ci->cmd_wrd >> 3) & 7;
    uint8_t sourceReg = ci->cmd_wrd & 7;
    uint8_t opmode = (ci->cmd_wrd >> 6) & 7;

    OperandSize size;
    switch (opmode)
    {
    case 0b000:
        size = OperandSize::Byte;
        break;
    case 0b001:
    case 0b011:
        size = OperandSize::Word;
        break;
    case 0b010:
    case 0b111:
        size = OperandSize::Long;
        break;
    default:
        return 0;
    }

    // Can't do byte operations on address registers.
    if (size == OperandSize::Byte && sourceMode == DirectAddrReg) return 0;

    uint8_t destRegCode = (ci->cmd_wrd >> 9) & 7;
    auto destReg = opmode > 2 ? Registers::makeAReg(destRegCode) : Registers::makeDReg(destRegCode);

    ci->source = get_eff_addr(ci, sourceMode, sourceReg, size, state);
    if (!ci->source) return 0;

    ci->setDest(RegParam(destReg, RegParamMode::Direct));

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(size);
    return 1;
}
int addq_subq(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
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
    if (!parseStandardSize(size, sizeOp)) return 0;

    ci->dest = get_eff_addr(ci, mode, reg, sizeOp, state);
    if (!ci->dest) return 0;

    ci->setSource(LiteralParam(FormattedNumber(data, OperandSize::Byte)));

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(sizeOp);
    return 1;
}

int trap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t vector = ci->cmd_wrd & 0x0f;
    if (!hasnext_w(state)) return 0;
    uint16_t trapNumber = getnext_w(ci, state);
    const size_t sysCallCount = sizeof(SysNames) / sizeof(SysNames[0]);
    const size_t mathCallCount = sizeof(MathCalls) / sizeof(MathCalls[0]);

    std::vector<rof_extrn>* vec_refs = nullptr;
    std::vector<rof_extrn>* call_refs = nullptr;
    if (state->opt->IsROF)
    {
        vec_refs = refManager.find_extrn(refManager.refs_code, state->CmdEnt + 1);
        call_refs = refManager.find_extrn(refManager.refs_code, state->CmdEnt + 2);
    }

    // Start with vec_ref.
    bool shouldGuessSyscall = false;
    bool shouldGuessMathLib = false;
    bool vectorHasName = true;
    if (vec_refs && vec_refs->size() > 0)
    {
        // TODO: Throw an error if more than one ref is detected here.

        rof_extrn &vec_ref = vec_refs->at(0);
        ci->setSource(LiteralParam(vec_ref.getName()));
        ci->mnem = "tcall";

        // Only guess math syscall if this is the math trap lib.
        shouldGuessMathLib = !strcmp(vec_ref.getName(), MATH_TRAP_LIB_NAME);
    }
    else if (vector == 0)
    {
        ci->mnem = "os9";
        shouldGuessSyscall = true;
    }
    else
    {
        ci->mnem = "tcall";
        vectorHasName = false;

        // We may change this later if the syscall matches something from T$Math
        ci->setSource(LiteralParam(FormattedNumber(vector, OperandSize::Byte)));
        shouldGuessMathLib = vector == MATH_TRAP_LIB;
    }

    // Then do call_ref.
    if (call_refs && call_refs->size() > 0)
    {
        // No need to guess anything.

        // TODO: Throw an error if more than one ref is detected here.
        ci->setDest(LiteralParam(call_refs->at(0).getName()));
    }
    else if (shouldGuessSyscall && trapNumber < sysCallCount)
    {
        auto syscall = SysNames[trapNumber];
        if (strlen(syscall) != 0)
        {
            labelManager.addLabel(&EQUATE_SPACE, trapNumber, syscall);
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
                labelManager.addLabel(&EQUATE_SPACE, MATH_TRAP_LIB, MATH_TRAP_LIB_NAME);
                ci->setSource(LiteralParam(MATH_TRAP_LIB_NAME));
            }

            labelManager.addLabel(&EQUATE_SPACE, trapNumber, functionName);
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
    uint8_t imm = getnext_w(ci, state);
    ci->setSource(LiteralParam(FormattedNumber(imm, OperandSize::Word)));
    ci->mnem = op->name;
    return 1;
}

int cmd_scc(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t reg = ci->cmd_wrd & 7;
    uint8_t conditionCode = (ci->cmd_wrd >> 8) & 0x0f;

    if (mode == DirectAddrReg) return 0;
    if (!isWritableMode(mode, reg)) return 0;

    ci->source = get_eff_addr(ci, mode, reg, OperandSize::Byte, state);
    if (!ci->source) return 0;

    auto mnem = std::string("s") + typecondition[conditionCode].condition;
    ci->mnem = mnem.c_str();

    return 1;
}

int cmd_exg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t sourceRegCode = (ci->cmd_wrd >> 9) & 7;
    uint8_t destRegCode = ci->cmd_wrd & 7;
    Register sourceReg;
    Register destReg;

    switch (op->id)
    {
    case InstrId::EXG_DATA_REG:
        // Both are data registers
        sourceReg = Registers::makeDReg(sourceRegCode);
        destReg = Registers::makeDReg(destRegCode);
        break;
    case InstrId::EXG_ADDR_REG:
        // Both are address registers
        sourceReg = Registers::makeAReg(sourceRegCode);
        destReg = Registers::makeAReg(destRegCode);
        break;
    case InstrId::EXG_DATA_AND_ADDR:
        // Source is data, dest is address
        sourceReg = Registers::makeDReg(sourceRegCode);
        destReg = Registers::makeAReg(destRegCode);
        break;
    default:
        return 0;
    }

    ci->setSource(RegParam(sourceReg, RegParamMode::Direct));
    ci->setDest(RegParam(destReg, RegParamMode::Direct));
    ci->mnem = op->name;
    return 1;
}

int cmd_ext(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t regCode = ci->cmd_wrd & 7;
    uint8_t opmode = (ci->cmd_wrd >> 6) & 7;
    OperandSize size;

    auto reg = Registers::makeDReg(regCode);
    switch (opmode)
    {
    case 0b010:
        size = OperandSize::Word;
        break;
    case 0b011:
        size = OperandSize::Long;
        break;
    case 0b111:
        // 68020+
        return 0;
    default:
        return 0;
    }

    ci->setSource(RegParam(reg, RegParamMode::Direct));

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(size);
    return 1;
}

int data_or_predec(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t srcRegno = ci->cmd_wrd & 7;
    uint8_t dstRegno = (ci->cmd_wrd >> 9) & 7;
    bool isAddressMode = (ci->cmd_wrd >> 3) & 1;

    auto maker = isAddressMode ? Registers::makeAReg : Registers::makeDReg;
    auto mode = isAddressMode ? RegParamMode::PreDecrement : RegParamMode::Direct;

    if (op->id == InstrId::ABCD || op->id == InstrId::SBCD)
    {
        ci->mnem = op->name;
    }
    else
    {
        uint8_t size = (ci->cmd_wrd >> 6) & 3;
        OperandSize sizeOp;
        if (!parseStandardSize(size, sizeOp)) return 0;

        ci->mnem = op->name;
        ci->mnem += OperandSizes::getLetter(sizeOp);
    }

    ci->setSource(RegParam(maker(srcRegno), mode));
    ci->setDest(RegParam(maker(dstRegno), mode));
    return 1;
}

int cmd_cmpm(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t srcRegno = ci->cmd_wrd & 7;
    uint8_t dstRegno = (ci->cmd_wrd >> 9) & 7;
    uint8_t size = (ci->cmd_wrd >> 6) & 3;

    OperandSize sizeOp;
    if (!parseStandardSize(size, sizeOp)) return 0;

    ci->setSource(RegParam(Registers::makeAReg(srcRegno), RegParamMode::PostIncrement));
    ci->setDest(RegParam(Registers::makeAReg(dstRegno), RegParamMode::PostIncrement));

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(sizeOp);
    return 1;
}

/*
 * noimplemented() - A dummy function which simply returns NULL for instructions
 *       that do not yet have handler functions
 */
int notimplemented(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    return 0;
}