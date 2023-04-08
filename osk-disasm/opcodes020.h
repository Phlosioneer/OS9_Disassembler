
#ifndef OPCODES_020_H
#define OPCODES_020_H

#include "userdef.h"
#include "externc.h"

cfunc int cmp2_chk2(struct cmd_items* ci, int j, const OPSTRUCTURE* op);
cfunc int rtm_020(struct cmd_items* ci, int j, const OPSTRUCTURE* op);
cfunc int cmd_moves(struct cmd_items* ci, int j, const OPSTRUCTURE* op);
cfunc int cmd_cas(struct cmd_items* ci, int j, const OPSTRUCTURE* op);
cfunc int cmd_cas2(struct cmd_items* ci, int j, const OPSTRUCTURE* op);
cfunc int cmd_callm(struct cmd_items* ci, int j, const OPSTRUCTURE* op);
cfunc int muldiv_020(struct cmd_items* ci, int j, const OPSTRUCTURE* op);
cfunc int cmd_rtd(struct cmd_items* ci, int j, const OPSTRUCTURE* op);
cfunc int cmd_trapcc(struct cmd_items* ci, int j, const OPSTRUCTURE* op);
cfunc int bitfields_020(struct cmd_items* ci, int j, const OPSTRUCTURE* op);

#endif
