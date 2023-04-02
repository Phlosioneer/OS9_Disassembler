
#ifndef OPCODE_00_H
#define OPCODE_00_H

#include "userdef.h"

int biti_reg(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int biti_size(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int bit_static(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int bit_dynamic(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int move_instr(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int move_ccr_sr(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int move_usp(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int movep(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int moveq(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int one_ea(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int bra_bsr(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_no_opcode(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int bit_rotate_mem(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int bit_rotate_reg(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int br_cond(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int add_sub(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmp_cmpa(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int addq_subq(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int abcd_sbcd(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
void addTrapOpt(CMD_ITEMS* ci, int ppos);
int trap(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_stop(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_dbcc(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_scc(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_exg(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int ext_extb(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmpm_addx_subx(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);

#endif