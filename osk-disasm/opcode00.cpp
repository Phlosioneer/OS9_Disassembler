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
#include "raw_params.h"

static const uint8_t MATH_TRAP_LIB = 15;
static const char* const MATH_TRAP_LIB_NAME = "T$Math";

enum
{
    EA2REG,
    REG2EA
};

// Note: Doesn't save the displacement
static int branch_common(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state,
                         const std::unique_ptr<RawRelativeParam>& displacement, uint8_t conditionCode);

/*
 * Immediate bit operations involving the status registers (ori, andi, eori)
 * Returns 1 on success, 0 on failure
 */
int biti_reg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    auto rawSource = parseImmediateParam(state, OperandSize::Word);
    if (!rawSource) return 0;

    auto reg = ((ci->cmd_wrd >> 6) & 1) == 0 ? Register::CCR : Register::SR;

    if ((reg == Register::CCR) && (rawSource->rawValue > 0x1f))
    {
        ungetnext_w_raw(state);
        return 0;
    }

    ci->rawSource = std::move(rawSource);

    ci->mnem = op->name;
    ci->rawDest = std::make_unique<RegParam>(reg, RegParamMode::Direct);

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

    if (op->id != InstrId::SUBI && op->id != InstrId::CMPI)
    {
        ci->literalSpaceHint = &LITERAL_HEX_SPACE;
    }

    ci->rawSource = parseImmediateParam(state, sizeOp);
    if (!ci->rawSource) return 0;
    
    ci->rawDest = parseEffectiveAddressWithMode(state, mode, regCode, sizeOp);
    if (!ci->rawDest) return 0;

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

    auto rawSource = parseImmediateParam(state, OperandSize::Byte); 
    
    // Also the bit number has limits: 32 for D registers, 8 for all other modes.
    if (mode == DirectDataReg && rawSource->rawValue > 32)
    {
        ungetnext_w_raw(state);
        return 0;
    }
    else if (mode != DirectDataReg && rawSource->rawValue > 8)
    {
        ungetnext_w_raw(state);
        return 0;
    }
    ci->rawSource = std::move(rawSource);

    OperandSize sizeOp = mode == DirectDataReg ? OperandSize::Long : OperandSize::Byte;

    // TODO: Any literals tested should be hexadecimal.
    //ci->literalSpaceHint = &LITERAL_HEX_SPACE;
    ci->rawDest = parseEffectiveAddressWithMode(state, mode, regCode, sizeOp);
    if (!ci->rawDest) return 0;

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

    ci->rawDest = parseEffectiveAddressWithMode(state, destMode, destRegCode, size);
    if (!ci->rawDest) return 0;
    
    ci->rawSource = std::make_unique<RegParam>(Registers::makeDReg(sourceRegCode), RegParamMode::Direct);
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

    ci->rawSource = parseEffectiveAddressWithMode(state, src_mode, src_reg, size);
    if (!ci->rawSource) return 0;
    
    ci->rawDest = parseEffectiveAddressWithMode(state, d_mode, d_reg, size);
    if (!ci->rawDest) return 0;

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
    {
        ci->rawSource = parseEffectiveAddressWithMode(state, mode, regCode, OperandSize::Word);
        if (!ci->rawSource) return 0;
        ci->rawDest = std::make_unique<RegParam>(specialReg, RegParamMode::Direct);
        break;
    }
    case InstrId::MOVE_FROM_SR:
    case InstrId::MOVE_FROM_CCR:
    {
        // Check that the destination is writable first.
        if (!isWritableMode(mode, regCode)) return 0;

        ci->rawSource = std::make_unique<RegParam>(specialReg, RegParamMode::Direct);
        ci->rawDest = parseEffectiveAddressWithMode(state, mode, regCode, OperandSize::Word);
        if (!ci->rawDest) return 0;
        break;
    }
    default:
        // Unreachable
        throw std::exception();
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
        ci->rawSource = std::make_unique<RegParam>(usp);
        ci->rawDest = std::make_unique<RegParam>(otherReg);
    }
    else
    {
        ci->rawSource = std::make_unique<RegParam>(otherReg);
        ci->rawDest = std::make_unique<RegParam>(usp);
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
        ci->rawDest = parseDisplacementParam(state, Registers::makeAReg(addrRegCode));
        if (!ci->rawDest) return 0;
        ci->rawSource = std::make_unique<RegParam>(dataParam);
    }
    else
    {
        ci->rawSource = parseDisplacementParam(state, Registers::makeAReg(addrRegCode));
        if (!ci->rawSource) return 0;
        ci->rawDest = std::make_unique<RegParam>(dataParam);
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
    ci->rawSource = std::make_unique<RawLiteralParam>(immParamValue, OperandSize::Byte, immParamAddress);

    uint8_t destRegCode = (ci->cmd_wrd >> 9) & 7;
    ci->rawDest = std::make_unique<RegParam>(Registers::makeDReg(destRegCode), RegParamMode::Direct);

    ci->mnem = op->name;
    return 1;
}

/* * A generic handler for when the basic command is a
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

    ci->rawSource = parseEffectiveAddressWithMode(state, mode, reg, sizeOp);
    if (!ci->rawSource) return 0;

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(sizeOp);
    return 1;
}

int one_ea(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t mode = (ci->cmd_wrd >> 3) & 7;
    uint8_t reg = ci->cmd_wrd & 7;

    /* eliminate modes */
    if (mode == DirectDataReg || mode == DirectAddrReg) return 0;
    if (mode == PostIncrement || mode == PreDecrement) return 0;
    if (mode == Special && reg == ImmediateData) return 0;
    
    /* PEA is often (ab)used to push arbitrary words and longs onto the stack. */
    std::unique_ptr<RawParam> rawSource;
    if (op->id == InstrId::PEA)
    {
        ci->suppressAbsoluteAddressLabels = true;
    }

    ci->rawSource = parseEffectiveAddressWithMode(state, mode, reg, OperandSize::Long);
    if (!ci->rawSource) return 0;

    ci->mnem = op->name;
    return 1;
}

int swap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t regCode = ci->cmd_wrd & 7;
    ci->rawSource = std::make_unique<RegParam>(Registers::makeDReg(regCode), RegParamMode::Direct);
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

    ci->rawSource = parseEffectiveAddressWithMode(state, mode, regCode, OperandSize::Byte);
    if (!ci->rawSource) return 0;

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
        ci->rawSource = std::make_unique<RegParam>(Registers::makeDReg(countOrReg), RegParamMode::Direct);
    }
    else
    {
        if (countOrReg == 0) countOrReg = 8;
        ci->rawSource = std::make_unique<RawLiteralParam>(countOrReg, OperandSize::Byte, state->CmdEnt);
    }

    ci->rawDest = std::make_unique<RegParam>(Registers::makeDReg(destRegCode), RegParamMode::Direct);

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

    std::unique_ptr<RawRelativeParam> rawDisplacement;
    if (displ == 0)
    {
        rawDisplacement = parseRelativeParam(state, OperandSize::Word);
        if (!rawDisplacement) return 0;
    }
    else if (displ == 0xff)
    {
        return 0; /* Long branch not available for < 68020 */
    }
    else
    {
        rawDisplacement = std::make_unique<RawRelativeParam>(displ, OperandSize::Byte, state->CmdEnt + 1, state->CmdEnt + 2);
    }

    // Condition codes 0 (true) and 1 (false) aren't allowed, if the branch is conditional at all.
    if (op->id != InstrId::BRA && op->id != InstrId::BSR && conditionCode <= 1) return 0;

    auto ret = branch_common(ci, op, state, rawDisplacement, conditionCode);
    if (ret)
    {
        ci->rawSource = std::move(rawDisplacement);
    }
    return ret;
}

int cmd_dbcc(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t conditionCode = (ci->cmd_wrd >> 8) & 0x0f;

    auto rawDisplacement = parseRelativeParam(state, OperandSize::Word);

    if (branch_common(ci, op, state, rawDisplacement, conditionCode))
    {
        ci->rawDest = std::move(rawDisplacement);

        // Decode the register parameter.
        uint8_t regCode = ci->cmd_wrd & 7;
        auto reg = Registers::makeDReg(regCode);
        ci->rawSource = std::make_unique<RegParam>(reg, RegParamMode::Direct);

        return 1;
    }
    return 0;
}

static int branch_common(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state,
                         const std::unique_ptr<RawRelativeParam>& displacement, uint8_t conditionCode)
{
    ci->forceRelativeImmediateMode = true;
    // Branches omit the # symbol, I guess because that's the only addressing mode?
    ci->suppressAbsoluteAddressLabels = true;
    if (displacement->rawValue & 1) return 0;

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
        if (displacement->size == OperandSize::Byte)
        {
            ci->mnem += ".s";
        }
        else
        {
            ci->mnem += OperandSizes::getSuffix(displacement->size);
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

    // For bitwise operators, use hex literals. For add and sub, use decimal literals.
    ci->literalSpaceHint = (op->id == InstrId::ADD || op->id == InstrId::SUB) ? &LITERAL_DEC_SPACE : &LITERAL_HEX_SPACE;

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
        ci->rawSource = std::make_unique<RegParam>(dataReg, RegParamMode::Direct);

        ci->rawDest = parseEffectiveAddressWithMode(state, ea_mode, ea_reg, sizeOp);
        if (!ci->rawDest) return 0;
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

        ci->rawSource = parseEffectiveAddressWithMode(state, ea_mode, ea_reg, sizeOp);
        if (!ci->rawSource) return 0;
        ci->rawDest = std::make_unique<RegParam>(dataReg, RegParamMode::Direct);
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
    ci->rawSource = parseEffectiveAddressWithMode(state, sourceMode, sourceRegCode, size);
    if (!ci->rawSource) return 0;

    ci->rawDest = std::make_unique<RegParam>(destReg, RegParamMode::Direct);

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

    ci->rawSource = parseEffectiveAddressWithMode(state, sourceMode, sourceReg, size);
    if (!ci->rawSource) return 0;

    ci->rawDest = std::make_unique<RegParam>(destReg, RegParamMode::Direct);

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

    ci->rawDest = parseEffectiveAddressWithMode(state, mode, reg, sizeOp);
    if (!ci->rawDest) return 0;

    // TODO: Write a unit test that puts an external ref in an addq or subq
    ci->rawSource = std::make_unique<RawLiteralParam>(data, OperandSize::Byte, state->CmdEnt + 1);

    ci->mnem = op->name;
    ci->mnem += OperandSizes::getLetter(sizeOp);
    return 1;
}

int os9_trap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    // If the vector is nonzero or an extern, let the tcall handler take it.
    const RawLiteralParam rawVector{0, OperandSize::Byte, state->CmdEnt + 1};
    if (rawVector.findRefs(&CODE_SPACE)) return 0;

    auto rawTrap = parseImmediateParam(state, OperandSize::Word);
    if (!rawTrap) return 0;

    // "os9" is a directive, not an opcode, so the # is not needed.
    ci->suppressHashTagForImmediates = true;

    const size_t sysCallCount = sizeof(SysNames) / sizeof(SysNames[0]);
    auto refs = rawTrap->findRefs(&CODE_SPACE);
    if ((!refs || refs->size() == 0) && rawTrap->rawValue < sysCallCount)
    {
        auto syscall = SysNames[rawTrap->rawValue];
        if (strlen(syscall) != 0)
        {
            ci->rawSource = std::make_unique<RawEquateParam>(*rawTrap, syscall);
        }
        else
        {
            ci->rawSource = std::move(rawTrap);
        }
    }
    else
    {
        ci->rawSource = std::move(rawTrap);
    }

    ci->mnem = op->name;
    return 1;
}

int math_trap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    auto rawTrap = parseImmediateParam(state, OperandSize::Word);
    if (!rawTrap) return 0;

    ci->rawSource =
        std::make_unique<RawEquateParam>(MATH_TRAP_LIB, OperandSize::Byte, state->CmdEnt + 1, MATH_TRAP_LIB_NAME);
    
    const size_t mathCallCount = sizeof(MathCalls) / sizeof(MathCalls[0]);
    auto refs = rawTrap->findRefs(&CODE_SPACE);
    if ((!refs || refs->size() == 0) && rawTrap->rawValue < mathCallCount)
    {
        auto functionName = MathCalls[rawTrap->rawValue];
        if (strlen(functionName) != 0)
        {
            ci->rawDest = std::make_unique<RawEquateParam>(*rawTrap, functionName);
        }
        else
        {
            ci->rawDest = std::move(rawTrap);
        }
    }
    else
    {
        ci->rawDest = std::move(rawTrap);
    }

    ci->mnem = op->name;
    return 1;
}

int trap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t vector = ci->cmd_wrd & 0x0f;
    ci->rawSource = std::make_unique<RawLiteralParam>(vector, OperandSize::Byte, state->CmdEnt + 1);

    ci->rawDest = parseImmediateParam(state, OperandSize::Word);
    if (!ci->rawDest) return 0;

    ci->mnem = op->name;
    return 1;
}

int cmd_stop(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    ci->rawSource = parseImmediateParam(state, OperandSize::Word);
    if (!ci->rawSource) return 0;
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

    ci->rawSource = parseEffectiveAddressWithMode(state, mode, reg, OperandSize::Byte);
    if (!ci->rawSource) return 0;

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

    ci->rawSource = std::make_unique<RegParam>(sourceReg, RegParamMode::Direct);
    ci->rawDest = std::make_unique<RegParam>(destReg, RegParamMode::Direct);
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

    ci->rawSource = std::make_unique<RegParam>(reg, RegParamMode::Direct);

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

    ci->rawSource = std::make_unique<RegParam>(maker(srcRegno), mode);
    ci->rawDest = std::make_unique<RegParam>(maker(dstRegno), mode);
    return 1;
}

int cmd_cmpm(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    uint8_t srcRegno = ci->cmd_wrd & 7;
    uint8_t dstRegno = (ci->cmd_wrd >> 9) & 7;
    uint8_t size = (ci->cmd_wrd >> 6) & 3;

    OperandSize sizeOp;
    if (!parseStandardSize(size, sizeOp)) return 0;

    ci->rawSource = std::make_unique<RegParam>(Registers::makeAReg(srcRegno), RegParamMode::PostIncrement);
    ci->rawDest = std::make_unique<RegParam>(Registers::makeAReg(dstRegno), RegParamMode::PostIncrement);

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