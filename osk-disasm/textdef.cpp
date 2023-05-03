
#include "textdef.h"
#include "opcode00.h"

extern const SIZETYPES sizefield[] = {
    {"bwl~~~~"}, /* entry 0  */
    {"b~~~~~~"}, /* entry 1  */
    {"w~~~~~~"}, /* entry 2  */
    {"lbbbb~~"}, /* entry 3  */
    {"wl~~~~~"}, /* entry 4  */
    {"l~~~~~~"}, /* entry 5  */
    {"bbbbb~~"}, /* entry 6  */
    {"~wl~~~~"}, /* entry 7  */
    {"~b~~~~~"}, /* entry 8  */
    {"~w~l~~~"}, /* entry 9  */
    {"~~wl~~~"}, /* entry 10  */
    {"~~~w~~~"}, /* entry 11  */
    {"~l~~~~~"}, /* entry 12  */
    {"wwwww~~"}, /* entry 13  */
    {"~bwl~~~"}, /* entry 14  */
    {"lsx~wdb"}, /* entry 15  */
    {"x~~~~~~"}, /* entry 16  */
    {"ls~~w~b"}, /* entry 17  */
    {"~~~p~~~"}, /* entry 18  */
    {"lsx~wdb"}  /* entry 19  */
};

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

extern const EAALLOWED_TYPE EAtype[] = {
    {0xbf8},   /* entry 0 */
    {0xbfe},   /* entry 1 */
    {0xbff},   /* entry 2 */
    {0x400},   /* entry 3 */
    {0x800},   /* entry 4 */
    {0x27e},   /* entry 5 */
    {0x2f8},   /* entry 6 */
    {0x37e},   /* entry 7 */
    {0x001},   /* entry 8 */
    {0xff8},   /* entry 9 */
    {0xfff},   /* entry 10 */
    {0x600},   /* entry 11 */
    {0x3f8},   /* entry 12 */
    {0x080},   /* entry 13 */
    {0x278},   /* entry 14 */
    {0xa78},   /* entry 15 */
    {0xa7e},   /* entry 16 */
    {0x1000},  /* entry 17 'C'	ccr		*/
    {0x2000},  /* entry 18 'S' status register	*/
    {0x040},   /* entry 19 */
    {0x3000},  /* entry 20 'R'	register list	*/
    {0x4000},  /* entry 21 'N'	none		*/
    {0x015},   /* entry 22 */
    {0x019},   /* entry 23 */
    {0x100},   /* entry 24 */
    {0xc00},   /* entry 25 */
    {0x5000},  /* entry 26 'U' USP		*/
    {0x6000},  /* entry 27 'Z'	control register*/
    {0x7000},  /* entry 28 'Y'	D_:D_		*/
    {0x8000},  /* entry 29 'W'	A/D_:A/D_	*/
    {0x9000},  /* entry 30 			*/
    {0xa000},  /* entry 31 			*/
    {0xb000},  /* entry 32 'X'	E{_:_}		*/
    {0xc000},  /* entry 33 			*/
    {0xd000},  /* entry 34 'Q'	melds into EA[SOURCE]		*/
    {0xe000},  /* entry 35 			*/
    {0xf000},  /* entry 36 			*/
    {0x10000}, /* entry 37 			*/
    {0x11000}, /* entry 38 'F'	function code	*/
    {0x12000}, /* entry 39 'M'	mmu register	*/
    {0x13000}, /* entry 40 'FE,E'		*/
    {0x020},   /* entry 41 */
    {0x001},   /* entry 42 */
    {0x008},   /* entry 43 */
    {0x300},   /* entry 44 */
    {0x14000}, /* entry 45 'H'	FPm list	*/
    {0x15000}, /* entry 46 'I'	FPm		*/
    {0x16000}, /* entry 47 'J'	<ea>{Dn} or {#k}*/
    {0x3ff},   /* entry 48 */
    {0x801},   /* entry 49 */
    {0x17000}, /* entry 50 'K'	single FPcr	*/
    {0xaff},   /* entry 51 */
    {0x18000}, /* entry 52 'L'	FPIAR only	*/
    {0x19000}, /* entry 53 'M'	FPm:FPn		*/
    {0x1a000}  /* entry 54 'O' Fpcr list	*/
};

/* The DEVICE that the target system uses will determine which OPSTRUCTURE
   will be compiled into the monitor */

/* NOTE: FOR INSTRUCTION ENTRIES OF THE SAME TYPE THE LONGEST SIZE OPTION
     SHOULD BE ENTERED FIRST!!!!!!!!!!!!!				*/

extern const OPSTRUCTURE instr00[] =
    /* ******************************************************************** */
    /* **************************68000 INSTRUCTIONS************************ */
    /* ******************************************************************** */
    {{"dc", 13, 8, 21, "xxxxxxxxxxxxxxxx", 0, 0, MC68000, 0, notimplemented},
     {"ori.", 0, 8, 0, "00000000xxxxxxxx", 7, 6, MC68000, 1, biti_size},
     /* OR Immediate to CCR */
     {"ori", 1, 8, 17, "0000000000111100", 0, 0, MC68000, 2, biti_reg},
     /* OR Immediate to SR */
     {"ori", 2, 8, 18, "0000000001111100", 0, 0, MC68000, 3, biti_reg},
     /* DYNAMIC  BIT */
     {"btst.", 3, 4, 2, "0000xxx100xxxxxx", 5, 3, MC68000, 4, bit_dynamic},
     {"bchg.", 3, 4, 0, "0000xxx101xxxxxx", 5, 3, MC68000, 5, bit_dynamic},
     {"bclr.", 3, 4, 0, "0000xxx110xxxxxx", 5, 3, MC68000, 6, bit_dynamic},
     {"bset.", 3, 4, 0, "0000xxx111xxxxxx", 5, 3, MC68000, 7, bit_dynamic},
     /* MOVEP */
     {"movep.", 4, 19, 4, "0000xxx10x001xxx", 6, 6, MC68000, 8, movep},
     {"movep.", 4, 4, 19, "0000xxx11x001xxx", 6, 6, MC68000, 9, movep},
     /* AND Immediate to CCR */
     {"andi", 1, 8, 17, "0000001000111100", 0, 0, MC68000, 10, biti_reg},
     /* AND Immediate to SR */
     {"andi", 2, 8, 18, "0000001001111100", 0, 0, MC68000, 11, biti_reg},
     {"andi.", 0, 8, 0, "00000010xxxxxxxx", 7, 6, MC68000, 12, biti_size},
     {"subi.", 0, 8, 0, "00000100xxxxxxxx", 7, 6, MC68000, 13, biti_size},
     {"addi.", 0, 8, 0, "00000110xxxxxxxx", 7, 6, MC68000, 14, biti_size},
     /* STATIC BIT */
     {"btst.", 3, 8, 1, "0000100000xxxxxx", 5, 3, MC68000, 15, bit_static},
     {"bchg.", 3, 8, 0, "0000100001xxxxxx", 5, 3, MC68000, 16, bit_static},
     {"bclr.", 3, 8, 0, "0000100010xxxxxx", 5, 3, MC68000, 17, bit_static},
     {"bset.", 3, 8, 0, "0000100011xxxxxx", 5, 3, MC68000, 18, bit_static},
     /* EOR IMMEDIATE to CCR */
     {"eori", 1, 8, 17, "0000101000111100", 0, 0, MC68000, 19, biti_reg},
     /* EOR IMMEDIATE to SR*/
     {"eori", 2, 8, 18, "0000101001111100", 0, 0, MC68000, 20, biti_reg},
     {"eori.", 0, 8, 0, "00001010xxxxxxxx", 7, 6, MC68000, 21, biti_size},
     {"cmpi.", 0, 8, 1, "00001100xxxxxxxx", 7, 6, MC68000, 22, biti_size},
     {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr01[] = {
    /* MOVE BYTE */
    {"move.", 1, 2, 0, "0001xxxxxxxxxxxx", 15, 15, MC68000, 25, move_instr},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr02[] = {
    /* MOVE LONG */
    {"move.", 5, 10, 0, "0010xxxxxxxxxxxx", 15, 15, MC68000, 23, move_instr},
    /* MOVEA LONG */
    {"movea.", 5, 10, 3, "0010xxx001xxxxxx", 15, 15, MC68000, 24, move_instr},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr03[] = {
    /* MOVEA WORD */
    {"movea.", 2, 10, 3, "0011xxx001xxxxxx", 15, 15, MC68000, 26, move_instr},
    /* MOVE WORD */
    {"move.", 2, 10, 0, "0011xxxxxxxxxxxx", 15, 15, MC68000, 27, move_instr},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr04[] = {
    /* MOVE from SR */
    {"move.", 2, 18, 0, "0100000011xxxxxx", 8, 8, MC68000, 28, move_ccr_sr},
    {"negx.", 0, 0, 21, "01000000xxxxxxxx", 7, 6, MC68000, 29, one_ea},
    /* CHK 68000 */
    {"chk.", 2, 2, 4, "0100xxx110xxxxxx", 6, 6, MC68000, 30, reg_ea},
    {"lea.", 5, 5, 3, "0100xxx111xxxxxx", 12, 12, MC68000, 31, reg_ea},
    {"clr.", 0, 0, 21, "01000010xxxxxxxx", 7, 6, MC68000, 32, one_ea},
    /* MOVE to CCR */
    {"move.", 2, 2, 17, "0100010011xxxxxx", 8, 8, MC68000, 33, move_ccr_sr},
    {"neg.", 0, 0, 21, "01000100xxxxxxxx", 7, 6, MC68000, 34, one_ea},
    /* MOVE to SR */
    {"move.", 2, 2, 18, "0100011011xxxxxx", 8, 8, MC68000, 35, move_ccr_sr},
    {"not.", 0, 0, 21, "01000110xxxxxxxx", 7, 6, MC68000, 36, one_ea},
    {"nbcd.", 1, 0, 21, "0100100000xxxxxx", 6, 6, MC68000, 37, one_ea},
    {"swap.", 2, 4, 21, "0100100001000xxx", 3, 3, MC68000, 38, one_ea},
    {"pea", 5, 5, 21, "0100100001xxxxxx", 7, 7, MC68000, 39, one_ea},
    /* MOVEM Registers to EA */
    {"movem.", 4, 20, 6, "010010001xxxxxxx", 6, 6, MC68000, 40, movem_cmd},
    {"illegal", 6, 21, 21, "0100101011111100", 0, 0, MC68000, 41, cmd_no_opcode},
    {"tas.", 1, 0, 21, "0100101011xxxxxx", 8, 8, MC68000, 42, one_ea},
    {"tst.", 0, 1, 21, "01001010xxxxxxxx", 7, 6, MC68000, 43, one_ea},
    /* MOVEM EA to Registers */
    {"movem.", 4, 7, 20, "010011001xxxxxxx", 6, 6, MC68000, 44, movem_cmd},
    {"trap", 6, 8, 21, "010011100100xxxx", 0, 0, MC68000, 45, trap},
    {"link.", 2, 3, 8, "0100111001010xxx", 3, 3, MC68000, 46, link_unlk},
    {"unlk", 6, 3, 21, "0100111001011xxx", 0, 0, MC68000, 47, link_unlk},
    /* MOVE to USP */
    {"move.", 5, 3, 26, "0100111001100xxx", 4, 4, MC68000, 48, move_usp},
    /* MOVE from USP */
    {"move.", 5, 26, 3, "0100111001101xxx", 4, 4, MC68000, 49, move_usp},
    {"reset", 6, 21, 21, "0100111001110000", 0, 0, MC68000, 50, cmd_no_opcode},
    {"nop", 6, 21, 21, "0100111001110001", 0, 0, MC68000, 51, cmd_no_opcode},
    {"stop", 6, 8, 21, "0100111001110010", 0, 0, MC68000, 52, cmd_stop},
    {"rte", 6, 21, 21, "0100111001110011", 0, 0, MC68000, 53, cmd_no_opcode},
    {"rts", 6, 21, 21, "0100111001110101", 0, 0, MC68000, 54, cmd_no_opcode},
    {"trapv", 6, 21, 21, "0100111001110110", 0, 0, MC68000, 55, cmd_no_opcode},
    {"rtr", 6, 21, 21, "0100111001110111", 0, 0, MC68000, 56, cmd_no_opcode},
    {"jsr", 6, 5, 21, "0100111010xxxxxx", 0, 0, MC68000, 57, one_ea},
    {"jmp", 6, 5, 21, "0100111011xxxxxx", 0, 0, MC68000, 58, one_ea},
    {"ext.", 10, 4, 21, "01001000xx000xxx", 7, 6, MC68000, 106, ext_extb},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr05[] = {
    /* DBcc */
    {"db~~.", 2, 4, 23, "0101xxxx11001xxx", 4, 4, MC68000, 59, cmd_dbcc},
    /* Scc */
    {"s~~.", 8, 0, 21, "0101xxxx11xxxxxx", 6, 6, MC68000, 60, cmd_scc},
    /* ADDQ */
    {"addq.", 0, 8, 0, "0101xxx0xxxxxxxx", 7, 6, MC68000, 61, addq_subq},
    {"subq.", 0, 8, 0, "0101xxx1xxxxxxxx", 7, 6, MC68000, 62, addq_subq},
    {"subq.", 7, 8, 3, "0101xxx1xxxxxxxx", 7, 6, MC68000, 63, addq_subq},
    {"addq.", 7, 8, 3, "0101xxx0xxxxxxxx", 7, 6, MC68000, 107, addq_subq},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr06[] = {{"bra.", 0, 23, 21, "01100000xxxxxxxx", 10, 10, MC68000, 64, bra_bsr},
                                      {"bsr.", 0, 23, 21, "01100001xxxxxxxx", 10, 10, MC68000, 65, bra_bsr},
                                      /* Bcc */
                                      {"b~~.", 0, 23, 21, "0110xxxxxxxxxxxx", 10, 10, MC68000, 66, br_cond},
                                      {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr07[] = {{"moveq.", 5, 8, 4, "0111xxx0xxxxxxxx", 8, 8, MC68000, 67, moveq},
                                      {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr08[] = {
    /* SBCD */
    {"sbcd.", 1, 4, 4, "1000xxx100000xxx", 4, 4, MC68000, 68, abcd_sbcd},
    {"sbcd.", 1, 13, 13, "1000xxx100001xxx", 4, 4, MC68000, 69, abcd_sbcd},
    /* DIVU */
    {"divu.", 2, 2, 4, "1000xxx011xxxxxx", 8, 8, MC68000, 70, reg_ea},
    /* DIVS */
    {"divs.", 2, 2, 4, "1000xxx111xxxxxx", 12, 12, MC68000, 71, reg_ea},
    /* OR  */
    {"or.", 0, 4, 12, "1000xxx1xxxxxxxx", 7, 6, MC68000, 120, add_sub},
    {"or.", 0, 2, 4, "1000xxx0xxxxxxxx", 7, 6, MC68000, 121, add_sub},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr09[] = {
    /* SUBA */
    {"suba.", 9, 10, 3, "1001xxxx11xxxxxx", 8, 7, MC68000, 72, add_sub},
    /* SUBX */
    {"subx.", 0, 4, 4, "1001xxx1xx000xxx", 7, 6, MC68000, 73, cmpm_addx_subx},
    {"subx.", 0, 13, 13, "1001xxx1xx001xxx", 7, 6, MC68000, 74, cmpm_addx_subx},
    /* SUB */
    {"sub.", 0, 2, 4, "1001xxx0xxxxxxxx", 7, 6, MC68000, 122, add_sub},
    {"sub.", 7, 3, 4, "1001xxx0xxxxxxxx", 7, 6, MC68000, 123, add_sub},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr11[] = {{"cmpa.", 9, 10, 3, "1011xxxx11xxxxxx", 8, 7, MC68000, 75, cmp_cmpa},
                                      {"cmp.", 0, 10, 4, "1011xxx0xxxxxxxx", 7, 6, MC68000, 76, cmp_cmpa},
                                      {"eor.", 0, 4, 0, "1011xxx1xxxxxxxx", 7, 6, MC68000, 77, add_sub},
                                      {"cmpm.", 0, 24, 24, "1011xxx1xx001xxx", 7, 6, MC68000, 78, cmpm_addx_subx},
                                      {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr12[] = {
    /* MULU WORD */
    {"mulu.", 2, 2, 4, "1100xxx011xxxxxx", 8, 8, MC68000, 79, reg_ea},
    /* MULS WORD */
    {"muls.", 2, 2, 4, "1100xxx111xxxxxx", 12, 12, MC68000, 80, reg_ea},
    /* ABCD */
    {"abcd.", 1, 4, 4, "1100xxx100000xxx", 7, 6, MC68000, 81, abcd_sbcd},
    {"abcd.", 1, 13, 13, "1100xxx100001xxx", 7, 6, MC68000, 82, abcd_sbcd},
    /* EXG data registers  */
    {"exg.", 5, 4, 4, "1100xxx101000xxx", 3, 3, MC68000, 83, cmd_exg},
    /* EXG address registers  */
    {"exg.", 5, 3, 3, "1100xxx101001xxx", 4, 4, MC68000, 84, cmd_exg},
    /* EXG data register and address  */
    {"exg.", 5, 4, 3, "1100xxx110001xxx", 4, 4, MC68000, 85, cmd_exg},
    /* AND  */
    {"and.", 0, 2, 4, "1100xxx0xxxxxxxx", 7, 6, MC68000, 86, add_sub},
    {"and.", 0, 4, 12, "1100xxx1xxxxxxxx", 7, 6, MC68000, 87, add_sub},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr13[] = {
    /* ADDA */
    {"adda.", 9, 10, 3, "1101xxxx11xxxxxx", 8, 7, MC68000, 88, add_sub},
    /* ADDX */
    {"addx.", 0, 4, 4, "1101xxx1xx000xxx", 7, 6, MC68000, 89, cmpm_addx_subx},
    {"addx.", 0, 13, 13, "1101xxx1xx001xxx", 7, 6, MC68000, 90, cmpm_addx_subx},
    /* ADD */
    {"add.", 0, 2, 4, "1101xxx0xxxxxxxx", 7, 6, MC68000, 91, add_sub},
    {"add.", 7, 3, 4, "1101xxx0xxxxxxxx", 7, 6, MC68000, 92, add_sub},
    {"add.", 0, 4, 12, "1101xxx1xxxxxxxx", 7, 6, MC68000, 93, add_sub},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};

extern const OPSTRUCTURE instr14[] = {
    /* SHIFT ROTATE memory */
    {"rol.", 11, 12, 21, "1110011111xxxxxx", 7, 6, MC68000, 94, bit_rotate_mem},
    {"ror.", 11, 12, 21, "1110011011xxxxxx", 7, 6, MC68000, 95, bit_rotate_mem},
    /* SHIFT ROTATE logical memory */
    {"roxl.", 11, 12, 21, "1110010111xxxxxx", 7, 6, MC68000, 96, bit_rotate_mem},
    {"roxr.", 11, 12, 21, "1110010011xxxxxx", 7, 6, MC68000, 97, bit_rotate_mem},
    /* SHIFT ROTATE */
    {"rol.", 0, 8, 4, "1110xxx1xx011xxx", 7, 6, MC68000, 98, bit_rotate_reg},
    {"rol.", 0, 4, 4, "1110xxx1xx111xxx", 7, 6, MC68000, 99, bit_rotate_reg},
    /* SHIFT ROTATE */
    {"ror.", 0, 8, 4, "1110xxx0xx011xxx", 7, 6, MC68000, 100, bit_rotate_reg},
    {"ror.", 0, 4, 4, "1110xxx0xx111xxx", 7, 6, MC68000, 101, bit_rotate_reg},
    /* SHIFT ROTATE */
    {"roxl.", 0, 8, 4, "1110xxx1xx010xxx", 7, 6, MC68000, 102, bit_rotate_reg},
    {"roxl.", 0, 4, 4, "1110xxx1xx110xxx", 7, 6, MC68000, 103, bit_rotate_reg},
    /* SHIFT ROTATE */
    {"roxr.", 0, 8, 4, "1110xxx0xx010xxx", 7, 6, MC68000, 104, bit_rotate_reg},
    {"roxr.", 0, 4, 4, "1110xxx0xx110xxx", 7, 6, MC68000, 105, bit_rotate_reg},
    /* SHIFT ROTATE */
    {"asl.", 11, 12, 21, "1110000111x11xxx", 7, 6, MC68000, 108, bit_rotate_mem},
    {"asl.", 0, 8, 4, "1110xxx1xx000xxx", 7, 6, MC68000, 109, bit_rotate_reg},
    {"asl.", 0, 4, 4, "1110xxx1xx100xxx", 7, 6, MC68000, 110, bit_rotate_reg},
    {"asr.", 11, 12, 21, "1110000011x11xxx", 7, 6, MC68000, 111, bit_rotate_mem},
    {"asr.", 0, 8, 4, "1110xxx0xx000xxx", 7, 6, MC68000, 112, bit_rotate_reg},
    {"asr.", 0, 4, 4, "1110xxx0xx100xxx", 7, 6, MC68000, 113, bit_rotate_reg},
    /* LOGICAL SHIFT ROTATE */
    {"lsl.", 11, 12, 21, "1110001111xxxxxx", 7, 6, MC68000, 114, bit_rotate_mem},
    {"lsl.", 0, 8, 4, "1110xxx1xx001xxx", 7, 6, MC68000, 115, bit_rotate_reg},
    {"lsl.", 0, 4, 4, "1110xxx1xx101xxx", 7, 6, MC68000, 116, bit_rotate_reg},
    {"lsr.", 11, 12, 21, "1110001011xxxxxx", 7, 6, MC68000, 117, bit_rotate_mem},
    {"lsr.", 0, 8, 4, "1110xxx0xx001xxx", 7, 6, MC68000, 118, bit_rotate_reg},
    {"lsr.", 0, 4, 4, "1110xxx0xx101xxx", 7, 6, MC68000, 119, bit_rotate_reg},
    {NULL, 0, 0, 0, NULL, 0, 0, 0, 0, NULL}};
/*#endif*/ /* end for OPSTRUCTURE */
