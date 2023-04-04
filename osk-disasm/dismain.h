
#ifndef DIS_MAIN_H
#define DIS_MAIN_H

#include "userdef.h"
#include "externc.h"

struct modnam;
struct cmd_items;

cfunc struct modnam* modnam_find(struct modnam* pt, int desired);
cfunc int dopass(int argc, char** argv, int mypass);
cfunc int showem(void);
cfunc int notimplemented(struct cmd_items* ci, int tblno, OPSTRUCTURE* op);
cfunc void MovBytes(struct data_bounds* db);
cfunc void MovASC(int nb, char aclass);
cfunc void NsrtBnds(struct data_bounds* bp);

#endif
