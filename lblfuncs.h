
#ifndef LABEL_H
#define LABEL_H

#include "userdef.h"

LBLCLAS* labelclass(char lblclass);
void PrintLbl(char* dest, char clas, int adr, LBLDEF* dl, int amod);
struct databndaries* ClasHere(struct databndaries* bp, int adrs);
LBLDEF* findlbl(char lblclass, int lblval);
char* lblstr(char lblclass, int lblval);
LBLDEF* addlbl(char lblclass, int val, char* newname);
void process_label(CMD_ITMS* ci, char lblclass, int addr);
void parsetree(char c);
int LblCalc(char* dst, int adr, int amod, int curloc);

#endif
