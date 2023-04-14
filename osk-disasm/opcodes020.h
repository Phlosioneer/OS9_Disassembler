
#ifndef OPCODES_020_H
#define OPCODES_020_H

#include "userdef.h"


int cmp2_chk2(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
int rtm_020(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_moves(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_cas(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_cas2(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_callm(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
int muldiv_020(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_rtd(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_trapcc(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);
int bitfields_020(struct cmd_items* ci, int j, const OPSTRUCTURE* op, struct parse_state* state);

#endif
