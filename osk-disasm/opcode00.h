
#ifndef OPCODE_00_H
#define OPCODE_00_H

#include "pch.h"

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
int one_ea_sized(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int swap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int one_ea(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_no_params(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int bit_rotate_mem(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int bit_rotate_reg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int branch(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int add_sub(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int add_sub_addr(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmp_cmpa(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int addq_subq(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int trap(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_stop(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_dbcc(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_scc(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_exg(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_ext(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int data_or_predec(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_cmpm(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);

#endif