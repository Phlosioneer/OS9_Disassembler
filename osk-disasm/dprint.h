
#ifndef DPRINT_H
#define DPRINT_H

#include "userdef.h"
#include "externc.h"

struct cmd_items;

cfunc void PrintPsect(void);
cfunc char* get_apcomment(char clas, int addr);
cfunc void PrintLine(const char* pfmt, struct cmd_items* ci, char cClass, int cmdlow, int cmdhi);
cfunc void printXtraBytes(char* data);
cfunc void PrintComment(char lblcClass, int cmdlow, int cmdhi);
cfunc void ROFPsect(struct rof_header* rptr);
cfunc void WrtEnds(void);
cfunc void ParseIRefs(char rClass);
cfunc void GetIRefs(void);
cfunc int DoAsciiBlock(struct cmd_items* ci, char* buf, int bufEnd, char iClass);
cfunc void ROFDataPrint(void);
cfunc char* LoadIData(void);
cfunc void OS9DataPrint(void);
cfunc void ListData(struct symbol_def* me, int upadr, char cClass);
cfunc void WrtEquates(int stdflg);

#endif
