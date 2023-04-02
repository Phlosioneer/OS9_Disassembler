
#ifndef OPCODE_00_H
#define OPCODE_00_H

#include "userdef.h"

struct cmd_items;

int biti_reg(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int biti_size(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int bit_static(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int bit_dynamic(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int move_instr(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int move_ccr_sr(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int move_usp(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int movep(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int moveq(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int one_ea(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int bra_bsr(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int cmd_no_opcode(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int bit_rotate_mem(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int bit_rotate_reg(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int br_cond(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int add_sub(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int cmp_cmpa(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int addq_subq(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int abcd_sbcd(struct cmd_items* ci, int j, OPSTRUCTURE* op);
void addTrapOpt(struct cmd_items* ci, int ppos);
int trap(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int cmd_stop(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int cmd_dbcc(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int cmd_scc(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int cmd_exg(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int ext_extb(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int cmpm_addx_subx(struct cmd_items* ci, int j, OPSTRUCTURE* op);

#endif