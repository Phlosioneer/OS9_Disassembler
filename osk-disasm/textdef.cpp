
#include "pch.h"

#include "textdef.h"

#include "opcode00.h"
#include "command_items.h"
#include "commonsubs.h"

extern const CONDITIONALS typecondition[] = {
    {"t"},  /* entry 0  */
    {"f"},  /* entry 1  */
    {"hi"}, /* entry 2  */
    {"ls"}, /* entry 3  */
    {"cc"}, /* entry 4  */
    {"cs"}, /* entry 5  */
    {"ne"}, /* entry 6  */
    {"eq"}, /* entry 7  */
    {"vc"}, /* entry 8  */
    {"vs"}, /* entry 9  */
    {"pl"}, /* entry 10  */
    {"mi"}, /* entry 11  */
    {"ge"}, /* entry 12 */
    {"lt"}, /* entry 13 */
    {"gt"}, /* entry 14 */
    {"le"}  /* entry 15 */
};

/* The DEVICE that the target system uses will determine which OPSTRUCTURE
   will be compiled into the monitor */

/* NOTE: FOR INSTRUCTION ENTRIES OF THE SAME TYPE THE LONGEST SIZE OPTION
     SHOULD BE ENTERED FIRST!!!!!!!!!!!!!				*/

extern const OPSTRUCTURE instr00[] =
    /* ******************************************************************** */
    /* **************************68000 INSTRUCTIONS************************ */
    /* ******************************************************************** */
    {{"dc", 13, 8, 21, "xxxxxxxxxxxxxxxx", 0, 0, MC68000, InstrId::DC, notimplemented},
     {"ori.", 0, 8, 0, "00000000xxxxxxxx", 7, 6, MC68000, InstrId::ORI, biti_size},
     /* OR Immediate to CCR (size = 0, mode = 7, reg = 4)*/
     {"ori", 1, 8, 17, "0000000000111100", 0, 0, MC68000, InstrId::ORI_TO_CCR, biti_reg},
     /* OR Immediate to SR (size = 1, mode = 7, reg = 4) */
     {"ori", 2, 8, 18, "0000000001111100", 0, 0, MC68000, InstrId::ORI_TO_SR, biti_reg},
     /* DYNAMIC  BIT */
     {"btst.", 3, 4, 2, "0000xxx100xxxxxx", 5, 3, MC68000, InstrId::BTST_DYNAMIC, bit_dynamic},
     {"bchg.", 3, 4, 0, "0000xxx101xxxxxx", 5, 3, MC68000, InstrId::BCHG_DYNAMIC, bit_dynamic},
     {"bclr.", 3, 4, 0, "0000xxx110xxxxxx", 5, 3, MC68000, InstrId::BCLR_DYNAMIC, bit_dynamic},
     {"bset.", 3, 4, 0, "0000xxx111xxxxxx", 5, 3, MC68000, InstrId::BSET_DYNAMIC, bit_dynamic},
     /* MOVEP */
     {"movep.", 4, 19, 4, "0000xxx10x001xxx", 6, 6, MC68000, InstrId::MOVEP_TO_MEM, movep},
     {"movep.", 4, 4, 19, "0000xxx11x001xxx", 6, 6, MC68000, InstrId::MOVEP_FROM_MEM, movep},
     /* AND Immediate to CCR (size = 0, mode = 7, reg = 4) */
     {"andi", 1, 8, 17, "0000001000111100", 0, 0, MC68000, InstrId::ANDI_TO_CCR, biti_reg},
     /* AND Immediate to SR (size = 1, mode = 7, reg = 4) */
     {"andi", 2, 8, 18, "0000001001111100", 0, 0, MC68000, InstrId::ANDI_TO_SR, biti_reg},
     {"andi.", 0, 8, 0, "00000010xxxxxxxx", 7, 6, MC68000, InstrId::ANDI, biti_size},
     {"subi.", 0, 8, 0, "00000100xxxxxxxx", 7, 6, MC68000, InstrId::SUBI, biti_size},
     {"addi.", 0, 8, 0, "00000110xxxxxxxx", 7, 6, MC68000, InstrId::ADDI, biti_size},
     /* STATIC BIT */
     {"btst.", 3, 8, 1, "0000100000xxxxxx", 5, 3, MC68000, InstrId::BTST_STATIC, bit_static},
     {"bchg.", 3, 8, 0, "0000100001xxxxxx", 5, 3, MC68000, InstrId::BCHG_STATIC, bit_static},
     {"bclr.", 3, 8, 0, "0000100010xxxxxx", 5, 3, MC68000, InstrId::BCLR_STATIC, bit_static},
     {"bset.", 3, 8, 0, "0000100011xxxxxx", 5, 3, MC68000, InstrId::BSET_STATIC, bit_static},
     /* EOR  Immediate to CCR (size = 0, mode = 7, reg = 4) */
     {"eori", 1, 8, 17, "0000101000111100", 0, 0, MC68000, InstrId::EORI_TO_CCR, biti_reg},
     /* EOR Immediate to SR (size = 1, mode = 7, reg = 4)*/
     {"eori", 2, 8, 18, "0000101001111100", 0, 0, MC68000, InstrId::EORI_TO_SR, biti_reg},
     {"eori.", 0, 8, 0, "00001010xxxxxxxx", 7, 6, MC68000, InstrId::EORI, biti_size},
     {"cmpi.", 0, 8, 1, "00001100xxxxxxxx", 7, 6, MC68000, InstrId::CMPI, biti_size},
     {0}};

extern const OPSTRUCTURE instr01[] = {
    /* MOVE BYTE */
    {"move.", 1, 2, 0, "0001xxxxxxxxxxxx", 15, 15, MC68000, InstrId::MOVE_BYTE, move_instr},
    {0}};

extern const OPSTRUCTURE instr02[] = {
    /* MOVE LONG */
    {"move.", 5, 10, 0, "0010xxxxxxxxxxxx", 15, 15, MC68000, InstrId::MOVE_LONG, move_instr},
    /* MOVEA LONG */
    {"movea.", 5, 10, 3, "0010xxx001xxxxxx", 15, 15, MC68000, InstrId::MOVEA_LONG, move_instr},
    {0}};

extern const OPSTRUCTURE instr03[] = {
    /* MOVEA WORD */
    {"movea.", 2, 10, 3, "0011xxx001xxxxxx", 15, 15, MC68000, InstrId::MOVEA_WORD, move_instr},
    /* MOVE WORD */
    {"move.", 2, 10, 0, "0011xxxxxxxxxxxx", 15, 15, MC68000, InstrId::MOVE_WORD, move_instr},
    {0}};

extern const OPSTRUCTURE instr04[] = {
    /* MOVE to/from CCR/SR */
    {"move", 2, 18, 0, "0100000011xxxxxx", 8, 8, MC68000, InstrId::MOVE_FROM_SR, move_ccr_sr},
    {"move", 2, 17, 0, "0100001011xxxxxx", 8, 8, MC68000, InstrId::MOVE_FROM_CCR, move_ccr_sr},
    {"move", 2, 2, 17, "0100010011xxxxxx", 8, 8, MC68000, InstrId::MOVE_TO_CCR, move_ccr_sr},
    {"move", 2, 2, 18, "0100011011xxxxxx", 8, 8, MC68000, InstrId::MOVE_TO_SR, move_ccr_sr},
    {"negx.", 0, 0, 21, "01000000xxxxxxxx", 7, 6, MC68000, InstrId::NEGX, one_ea_sized},
    /* CHK 68000 */
    {"chk", 2, 2, 4, "0100xxx110xxxxxx", 6, 6, MC68000, InstrId::CHK, reg_ea},
    {"lea", 5, 5, 3, "0100xxx111xxxxxx", 12, 12, MC68000, InstrId::LEA, reg_ea},
    {"clr.", 0, 0, 21, "01000010xxxxxxxx", 7, 6, MC68000, InstrId::CLR, one_ea_sized},
    {"neg.", 0, 0, 21, "01000100xxxxxxxx", 7, 6, MC68000, InstrId::NEG, one_ea_sized},
    {"not.", 0, 0, 21, "01000110xxxxxxxx", 7, 6, MC68000, InstrId::NOT, one_ea_sized},
    {"nbcd.", 1, 0, 21, "0100100000xxxxxx", 6, 6, MC68000, InstrId::NBCD, one_ea_sized},
    {"swap", 2, 4, 21, "0100100001000xxx", 3, 3, MC68000, InstrId::SWAP, swap},
    {"pea", 5, 5, 21, "0100100001xxxxxx", 7, 7, MC68000, InstrId::PEA, one_ea},
    /* MOVEM Registers to EA */
    {"movem.", 4, 20, 6, "010010001xxxxxxx", 6, 6, MC68000, InstrId::MOVEM_FROM_REGS, cmd_movem},
    {"illegal", 6, 21, 21, "0100101011111100", 0, 0, MC68000, InstrId::ILLEGAL, cmd_no_params},
    {"tas.", 1, 0, 21, "0100101011xxxxxx", 8, 8, MC68000, InstrId::TAS, one_ea_sized},
    {"tst.", 0, 1, 21, "01001010xxxxxxxx", 7, 6, MC68000, InstrId::TST, one_ea_sized},
    /* MOVEM EA to Registers */
    {"movem.", 4, 7, 20, "010011001xxxxxxx", 6, 6, MC68000, InstrId::MOVEM_TO_REGS, cmd_movem},
    {"os9", 6, 8, 21, "0100111001000000", 0, 0, MC68000, InstrId::TRAP, os9_trap},
    {"tcall", 6, 8, 21, "0100111001001111", 0, 0, MC68000, InstrId::TRAP, math_trap},
    {"tcall", 6, 8, 21, "010011100100xxxx", 0, 0, MC68000, InstrId::TRAP, trap},
    {"link.w", 2, 3, 8, "0100111001010xxx", 3, 3, MC68000, InstrId::LINK, link_unlk},
    {"unlk", 6, 3, 21, "0100111001011xxx", 0, 0, MC68000, InstrId::UNLK, link_unlk},
    /* MOVE to/from USP */
    {"move", 5, 3, 26, "010011100110xxxx", 4, 4, MC68000, InstrId::MOVE_USP, move_usp},
    {"reset", 6, 21, 21, "0100111001110000", 0, 0, MC68000, InstrId::RESET, cmd_no_params},
    {"nop", 6, 21, 21, "0100111001110001", 0, 0, MC68000, InstrId::NOP, cmd_no_params},
    {"stop", 6, 8, 21, "0100111001110010", 0, 0, MC68000, InstrId::STOP, cmd_stop},
    {"rte", 6, 21, 21, "0100111001110011", 0, 0, MC68000, InstrId::RTE, cmd_no_params},
    {"rts", 6, 21, 21, "0100111001110101", 0, 0, MC68000, InstrId::RTS, cmd_no_params},
    {"trapv", 6, 21, 21, "0100111001110110", 0, 0, MC68000, InstrId::TRAPV, cmd_no_params},
    {"rtr", 6, 21, 21, "0100111001110111", 0, 0, MC68000, InstrId::RTR, cmd_no_params},
    {"jsr", 6, 5, 21, "0100111010xxxxxx", 0, 0, MC68000, InstrId::JSR, one_ea},
    {"jmp", 6, 5, 21, "0100111011xxxxxx", 0, 0, MC68000, InstrId::JMP, one_ea},
    {"ext.", 10, 4, 21, "01001000xx000xxx", 7, 6, MC68000, InstrId::EXT, cmd_ext},
    {0}};

extern const OPSTRUCTURE instr05[] = {
    /* DBcc */
    {"db~~", 2, 4, 23, "0101xxxx11001xxx", 4, 4, MC68000, InstrId::DBCC, cmd_dbcc},
    /* Scc */
    {"s~~.", 8, 0, 21, "0101xxxx11xxxxxx", 6, 6, MC68000, InstrId::SCC, cmd_scc},
    /* ADDQ */
    {"addq.", 0, 8, 0, "0101xxx0xxxxxxxx", 7, 6, MC68000, InstrId::ADDQ, addq_subq},
    {"subq.", 0, 8, 0, "0101xxx1xxxxxxxx", 7, 6, MC68000, InstrId::SUBQ, addq_subq},
    {"subq.", 7, 8, 3, "0101xxx1xxxxxxxx", 7, 6, MC68000, InstrId::ADDQ_DUP, addq_subq},
    {"addq.", 7, 8, 3, "0101xxx0xxxxxxxx", 7, 6, MC68000, InstrId::SUBQ_DUP, addq_subq},
    {0}};

extern const OPSTRUCTURE instr06[] = {{"bra", 0, 23, 21, "01100000xxxxxxxx", 10, 10, MC68000, InstrId::BRA, branch},
                                      {"bsr", 0, 23, 21, "01100001xxxxxxxx", 10, 10, MC68000, InstrId::BSR, branch},
                                      /* Bcc */
                                      {"b~~", 0, 23, 21, "0110xxxxxxxxxxxx", 10, 10, MC68000, InstrId::BCC, branch},
                                      {0}};

extern const OPSTRUCTURE instr07[] = {{"moveq", 5, 8, 4, "0111xxx0xxxxxxxx", 8, 8, MC68000, InstrId::MOVEQ, moveq},
                                      {0}};

extern const OPSTRUCTURE instr08[] = {
    /* SBCD */
    {"sbcd", 1, 4, 4, "1000xxx10000xxxx", 4, 4, MC68000, InstrId::SBCD, data_or_predec},
    /* DIVU */
    {"divu.w", 2, 2, 4, "1000xxx011xxxxxx", 8, 8, MC68000, InstrId::DIVU, reg_ea},
    /* DIVS */
    {"divs.w", 2, 2, 4, "1000xxx111xxxxxx", 12, 12, MC68000, InstrId::DIVS, reg_ea},
    /* OR  */
    {"or.", 0, 2, 4, "1000xxxxxxxxxxxx", 7, 6, MC68000, InstrId::OR, add_sub},
    {0}};

extern const OPSTRUCTURE instr09[] = {
    /* SUBA */
    {"suba.", 9, 10, 3, "1001xxxx11xxxxxx", 8, 7, MC68000, InstrId::SUBA, add_sub_addr},
    /* SUBX */
    {"subx.", 0, 4, 4, "1001xxx1xx00xxxx", 7, 6, MC68000, InstrId::SUBX, data_or_predec},
    /* SUB */
    {"sub.", 0, 2, 4, "1001xxxxxxxxxxxx", 7, 6, MC68000, InstrId::SUB, add_sub},
    {0}};

extern const OPSTRUCTURE instr11[] = {
    {"cmpa.", 9, 10, 3, "1011xxxx11xxxxxx", 8, 7, MC68000, InstrId::CMPA, cmp_cmpa},
    {"cmp.", 0, 10, 4, "1011xxx0xxxxxxxx", 7, 6, MC68000, InstrId::CMP, cmp_cmpa},
    {"eor.", 0, 4, 0, "1011xxx1xxxxxxxx", 7, 6, MC68000, InstrId::EOR, add_sub},
    {"cmpm.", 0, 24, 24, "1011xxx1xx001xxx", 7, 6, MC68000, InstrId::CMPM, cmd_cmpm},
    {0}};

extern const OPSTRUCTURE instr12[] = {
    /* MULU WORD */
    {"mulu.w", 2, 2, 4, "1100xxx011xxxxxx", 8, 8, MC68000, InstrId::MULU, reg_ea},
    /* MULS WORD */
    {"muls.w", 2, 2, 4, "1100xxx111xxxxxx", 12, 12, MC68000, InstrId::MULS, reg_ea},
    /* ABCD */
    {"abcd", 1, 4, 4, "1100xxx10000xxxx", 7, 6, MC68000, InstrId::ABCD, data_or_predec},
    /* EXG data registers  */
    {"exg", 5, 4, 4, "1100xxx101000xxx", 3, 3, MC68000, InstrId::EXG_DATA_REG, cmd_exg},
    /* EXG address registers  */
    {"exg", 5, 3, 3, "1100xxx101001xxx", 4, 4, MC68000, InstrId::EXG_ADDR_REG, cmd_exg},
    /* EXG data register and address  */
    {"exg", 5, 4, 3, "1100xxx110001xxx", 4, 4, MC68000, InstrId::EXG_DATA_AND_ADDR, cmd_exg},
    /* AND  */
    {"and.", 0, 2, 4, "1100xxxxxxxxxxxx", 7, 6, MC68000, InstrId::AND, add_sub},
    {0}};

extern const OPSTRUCTURE instr13[] = {
    /* ADDA */
    {"adda.", 9, 10, 3, "1101xxxx11xxxxxx", 8, 7, MC68000, InstrId::ADDA, add_sub_addr},
    /* ADDX */
    {"addx.", 0, 4, 4, "1101xxx1xx00xxxx", 7, 6, MC68000, InstrId::ADDX, data_or_predec},
    /* ADD */
    {"add.", 0, 2, 4, "1101xxxxxxxxxxxx", 7, 6, MC68000, InstrId::ADD, add_sub},
    {0}};

extern const OPSTRUCTURE instr14[] = {
    /* SHIFT ROTATE memory */
    {"rol", 11, 12, 21, "1110011111xxxxxx", 7, 6, MC68000, InstrId::ROL_MEM, bit_rotate_mem},
    {"ror", 11, 12, 21, "1110011011xxxxxx", 7, 6, MC68000, InstrId::ROR_MEM, bit_rotate_mem},
    /* SHIFT ROTATE logical memory */
    {"roxl", 11, 12, 21, "1110010111xxxxxx", 7, 6, MC68000, InstrId::ROXL_MEM, bit_rotate_mem},
    {"roxr", 11, 12, 21, "1110010011xxxxxx", 7, 6, MC68000, InstrId::ROXR_MEM, bit_rotate_mem},
    /* SHIFT ROTATE */
    {"rol.", 0, 8, 4, "1110xxx1xx011xxx", 7, 6, MC68000, InstrId::ROL_STATIC, bit_rotate_reg},
    {"rol.", 0, 4, 4, "1110xxx1xx111xxx", 7, 6, MC68000, InstrId::ROL_DYNAMIC, bit_rotate_reg},
    /* SHIFT ROTATE */
    {"ror.", 0, 8, 4, "1110xxx0xx011xxx", 7, 6, MC68000, InstrId::ROR_STATIC, bit_rotate_reg},
    {"ror.", 0, 4, 4, "1110xxx0xx111xxx", 7, 6, MC68000, InstrId::ROR_DYNAMIC, bit_rotate_reg},
    /* SHIFT ROTATE */
    {"roxl.", 0, 8, 4, "1110xxx1xx010xxx", 7, 6, MC68000, InstrId::ROXL_STATIC, bit_rotate_reg},
    {"roxl.", 0, 4, 4, "1110xxx1xx110xxx", 7, 6, MC68000, InstrId::ROXL_DYNAMIC, bit_rotate_reg},
    /* SHIFT ROTATE */
    {"roxr.", 0, 8, 4, "1110xxx0xx010xxx", 7, 6, MC68000, InstrId::ROXR_STATIC, bit_rotate_reg},
    {"roxr.", 0, 4, 4, "1110xxx0xx110xxx", 7, 6, MC68000, InstrId::ROXR_DYNAMIC, bit_rotate_reg},
    /* SHIFT ROTATE */
    {"asl", 11, 12, 21, "1110000111xxxxxx", 7, 6, MC68000, InstrId::ASL_MEM, bit_rotate_mem},
    {"asl.", 0, 8, 4, "1110xxx1xx000xxx", 7, 6, MC68000, InstrId::ASL_STATIC, bit_rotate_reg},
    {"asl.", 0, 4, 4, "1110xxx1xx100xxx", 7, 6, MC68000, InstrId::ASL_DYNAMIC, bit_rotate_reg},
    {"asr", 11, 12, 21, "1110000011xxxxxx", 7, 6, MC68000, InstrId::ASR_MEM, bit_rotate_mem},
    {"asr.", 0, 8, 4, "1110xxx0xx000xxx", 7, 6, MC68000, InstrId::ASR_STATIC, bit_rotate_reg},
    {"asr.", 0, 4, 4, "1110xxx0xx100xxx", 7, 6, MC68000, InstrId::ASR_DYNAMIC, bit_rotate_reg},
    /* LOGICAL SHIFT ROTATE */
    {"lsl", 11, 12, 21, "1110001111xxxxxx", 7, 6, MC68000, InstrId::LSL_MEM, bit_rotate_mem},
    {"lsl.", 0, 8, 4, "1110xxx1xx001xxx", 7, 6, MC68000, InstrId::LSL_STATIC, bit_rotate_reg},
    {"lsl.", 0, 4, 4, "1110xxx1xx101xxx", 7, 6, MC68000, InstrId::LSL_DYNAMIC, bit_rotate_reg},
    {"lsr", 11, 12, 21, "1110001011xxxxxx", 7, 6, MC68000, InstrId::LSR_MEM, bit_rotate_mem},
    {"lsr.", 0, 8, 4, "1110xxx0xx001xxx", 7, 6, MC68000, InstrId::LSR_STATIC, bit_rotate_reg},
    {"lsr.", 0, 4, 4, "1110xxx0xx101xxx", 7, 6, MC68000, InstrId::LSR_DYNAMIC, bit_rotate_reg},
    {0}};
