
#ifndef DPRINT_H
#define DPRINT_H

#include "userdef.h"

struct cmd_items;

void tabinit(void);
void PrintAllCodLine(int w1, int w2);
void PrintAllCodL1(int w1);
void PrintPsect(void);
char* get_apcomment(char clas, int addr);
void PrintLine(char* pfmt, struct cmd_items* ci, char cClass, int cmdlow, int cmdhi);
void printXtraBytes(char* data);
void PrintComment(char lblcClass, int cmdlow, int cmdhi);
void ROFPsect(struct rof_header* rptr);
void WrtEnds(void);
void ParseIRefs(char rClass);
void GetIRefs(void);
int DoAsciiBlock(struct cmd_items* ci, char* buf, int bufEnd, char iClass);
void ROFDataPrint(void);
char* LoadIData(void);
void OS9DataPrint(void);
void ListData(struct symbol_def* me, int upadr, char cClass);
void WrtEquates(int stdflg);

#endif
