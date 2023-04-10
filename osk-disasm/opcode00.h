
#ifndef OPCODE_00_H
#define OPCODE_00_H

#include "userdef.h"
#include "externc.h"

struct cmd_items;

cfunc int biti_reg(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int biti_size(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int bit_static(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int bit_dynamic(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int move_instr(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int move_ccr_sr(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int move_usp(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int movep(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int moveq(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int one_ea(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int bra_bsr(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int cmd_no_opcode(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int bit_rotate_mem(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int bit_rotate_reg(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int br_cond(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int add_sub(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int cmp_cmpa(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int addq_subq(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int abcd_sbcd(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc void addTrapOpt(struct cmd_items* ci, int ppos, struct parse_state* state);
cfunc int trap(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int cmd_stop(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int cmd_dbcc(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int cmd_scc(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int cmd_exg(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int ext_extb(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
cfunc int cmpm_addx_subx(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);

#endif