
#ifndef LABEL_H
#define LABEL_H

#include "userdef.h"

LABEL_CLASS* labelclass(char lblclass);
void PrintLbl(char* dest, char clas, int adr, LABEL_DEF* dl, int amod);
struct data_bounds* ClasHere(struct data_bounds* bp, int adrs);
LABEL_DEF* findlbl(char lblclass, int lblval);
char* lblstr(char lblclass, int lblval);
LABEL_DEF* addlbl(char lblclass, int val, char* newname);
void process_label(CMD_ITEMS* ci, char lblclass, int addr);
void parsetree(char c);
int LblCalc(char* dst, int adr, int amod, int curloc);

#endif
