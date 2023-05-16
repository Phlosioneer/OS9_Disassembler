
#ifndef OPCODE_00_H
#define OPCODE_00_H

#include "userdef.h"

struct cmd_items;

int biti_reg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int biti_size(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int bit_static(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int bit_dynamic(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int move_instr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int move_ccr_sr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int move_usp(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int movep(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int moveq(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int one_ea(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int bra_bsr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_no_opcode(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int bit_rotate_mem(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int bit_rotate_reg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int br_cond(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int add_sub(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmp_cmpa(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int addq_subq(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int abcd_sbcd(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int trap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_stop(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_dbcc(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_scc(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_exg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int ext_extb(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmpm_addx_subx(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);

#endif