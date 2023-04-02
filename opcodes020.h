
#ifndef OPCODES_020_H
#define OPCODES_020_H

#include "userdef.h"

int cmp2_chk2(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int rtm_020(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_moves(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_cas(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_cas2(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_callm(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int muldiv_020(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_rtd(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int cmd_trapcc(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);
int bitfields_020(CMD_ITEMS* ci, int j, OPSTRUCTURE* op);

#endif
