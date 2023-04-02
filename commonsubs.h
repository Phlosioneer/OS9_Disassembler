
#ifndef COMMON_SUBS_H
#define COMMON_SUBS_H

#include <stdio.h>
#include "structs.h"
#include "userdef.h"

int get_eff_addr(CMD_ITMS* ci, char* ea, int mode, int reg, int size);
char* pass_eq(char* p);
int strpos(char* s, char c);
char* skipblank(char* p);
int get_extends_common(CMD_ITMS* ci, char* mnem);
int ctl_addrmodesonly(int mode, int reg);
int reg_ea(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
char* regbyte(char* s, unsigned char regmask, char* ad, int doslash);
int revbits(int num, int lgth);
int movem_cmd(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
int link_unlk(CMD_ITMS* ci, int j, OPSTRUCTURE* op);
unsigned int fget_w(FILE* fp);
unsigned int fget_l(FILE* fp);
char fread_b(FILE* fp);
char getnext_b(CMD_ITMS* ci);
int getnext_w(CMD_ITMS* ci);
void ungetnext_w(CMD_ITMS* ci);
short fread_w(FILE* fp);
int fread_l(FILE* fp);
short bufReadW(char** pt);
int bufReadL(char** pt);
void* mem_alloc(size_t req);
char* freadString(void);
char* lbldup(char* lbl);

#endif