/* ******************************************************************** *
 *                                                                      *
 * This file came from Motorola's FBug program and is in the public     *
 * domain.                                                              *
 *                                                                      *
 * ******************************************************************** */

#ifndef USERDEF_H
#define USERDEF_H

#include "pch.h"

#include "targetsys.h"

enum class InstrId : int
{
    DC = 0,
    ORI,
    ORI_TO_CCR,
    ORI_TO_SR,
    BTST_DYNAMIC,
    BCHG_DYNAMIC,
    BCLR_DYNAMIC,
    BSET_DYNAMIC,
    MOVEP_TO_MEM,
    MOVEP_FROM_MEM,
    ANDI_TO_CCR,
    ANDI_TO_SR,
    ANDI,
    SUBI,
    ADDI,
    BTST_STATIC,
    BCHG_STATIC,
    BCLR_STATIC,
    BSET_STATIC,
    EORI_TO_CCR,
    EORI_TO_SR,
    EORI,
    CMPI,

    MOVE_BYTE = 25,
    MOVE_LONG = 23,
    MOVEA_LONG = 24,
    MOVEA_WORD = 26,
    MOVE_WORD = 27,

    MOVE_FROM_SR = 28,
    NEGX,
    CHK,
    LEA,
    CLR,
    MOVE_TO_CCR,
    MOVE_FROM_CCR = 123,
    NEG = 34,
    MOVE_TO_SR,
    NOT,
    NBCD,
    SWAP,
    PEA,
    MOVEM_FROM_REGS,
    ILLEGAL,
    TAS,
    TST,
    MOVEM_TO_REGS,
    TRAP,
    LINK,
    UNLK,
    MOVE_USP,

    RESET = 50,
    NOP,
    STOP,
    RTE,
    RTS,
    TRAPV,
    RTR,
    JSR,
    JMP,
    EXT = 106,

    DBCC = 59,
    SCC,
    ADDQ,
    SUBQ,
    SUBQ_DUP,
    ADDQ_DUP = 107,

    BRA = 64,
    BSR,
    BCC,

    MOVEQ = 67,

    SBCD = 68,
    DIVU = 70,
    DIVS,
    OR = 120,

    SUBA = 72,
    SUBX,
    SUB = 122,

    CMPA = 75,
    CMP,
    EOR,
    CMPM,

    MULU = 79,
    MULS,
    ABCD,

    EXG_DATA_REG = 83,
    EXG_ADDR_REG,
    EXG_DATA_AND_ADDR,
    AND,

    ADDA = 88,
    ADDX,
    ADD = 91,

    ROL_MEM = 94,
    ROR_MEM,
    ROXL_MEM,
    ROXR_MEM,
    ROL_STATIC,
    ROL_DYNAMIC,
    ROR_STATIC,
    ROR_DYNAMIC,
    ROXL_STATIC,
    ROXL_DYNAMIC,
    ROXR_STATIC,
    ROXR_DYNAMIC,
    ASL_MEM = 108,
    ASL_STATIC,
    ASL_DYNAMIC,
    ASR_MEM,
    ASR_STATIC,
    ASR_DYNAMIC,
    LSL_MEM,
    LSL_STATIC,
    LSL_DYNAMIC,
    LSR_MEM,
    LSR_STATIC,
    LSR_DYNAMIC
};


struct SIZETYPES
{
    char* size;
};

struct CONDITIONALS
{
    char* condition;
};

struct EAALLOWED_TYPE
{
    int allowableEA;
};

struct OPSTRUCTURE
{
    const char* name = nullptr;
    short sizestr = 0; /* sizefield[size]   */
    short source = 0;  /* EAtype[source]    */
    short dest = 0;    /* EAtype[source]    */
    const char* opwordstr = nullptr;
    short sizestartbit = 0;
    short sizeendbit = 0;
    int cpulvl = 0;
    InstrId id = InstrId::DC;
    int (*opfunc)(struct cmd_items*, const OPSTRUCTURE*, struct parse_state*) = nullptr;
};

#endif
