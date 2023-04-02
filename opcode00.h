
#ifndef OPCODE_00_H
#define OPCODE_00_H

#include "userdef.h"

int biti_reg(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int biti_size(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int bit_static(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int bit_dynamic(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int move_instr(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int move_ccr_sr(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int move_usp(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int movep(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int moveq(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int one_ea(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int bra_bsr(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int cmd_no_opcode(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int bit_rotate_mem(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int bit_rotate_reg(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int br_cond(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int add_sub(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int cmp_cmpa(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int addq_subq(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int abcd_sbcd(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
void addTrapOpt(CMD_ITMS* ci, int ppos);
int trap(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int cmd_stop(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int cmd_dbcc(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int cmd_scc(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int cmd_exg(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int ext_extb(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int cmpm_addx_subx(CMD_ITMS* ci, int j, OPSTRUCTURE* op);

#endif