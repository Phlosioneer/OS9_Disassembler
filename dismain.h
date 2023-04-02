
#ifndef DIS_MAIN_H
#define DIS_MAIN_H

#include "userdef.h"
struct modnam;

struct modnam* modnam_find(struct modnam* pt, int desired);
int dopass(int argc, char** argv, int mypass);
int showem(void);
int notimplemented(CMD_ITMS* ci, int tblno, OPSTRUCTURE* op);
void MovBytes(struct databndaries* db);
void MovASC(int nb, char aclass);
void NsrtBnds(struct databndaries* bp);

#endif
