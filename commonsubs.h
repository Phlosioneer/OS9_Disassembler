
#ifndef COMMON_SUBS_H
#define COMMON_SUBS_H

#include <stdio.h>
#include "structs.h"
#include "userdef.h"
struct cmd_items;

int get_eff_addr(struct cmd_items* ci, char* ea, int mode, int reg, int size);
char* pass_eq(char* p);
int strpos(char* s, char c);
char* skipblank(char* p);
int get_extends_common(struct cmd_items* ci, char* mnem);
int ctl_addrmodesonly(int mode, int reg);
int reg_ea(struct cmd_items* ci, int j, OPSTRUCTURE* op);
char* regbyte(char* s, unsigned char regmask, char* ad, int doslash);
int revbits(int num, int lgth);
int movem_cmd(struct cmd_items* ci, int j, OPSTRUCTURE* op);
int link_unlk(struct cmd_items* ci, int j, OPSTRUCTURE* op);
unsigned int fget_w(FILE* fp);
unsigned int fget_l(FILE* fp);
char fread_b(FILE* fp);
char getnext_b(struct cmd_items* ci);
int getnext_w(struct cmd_items* ci);
void ungetnext_w(struct cmd_items* ci);
short fread_w(FILE* fp);
int fread_l(FILE* fp);
short bufReadW(char** pt);
int bufReadL(char** pt);
void* mem_alloc(size_t req);
char* freadString(void);
char* lbldup(char* lbl);

#endif