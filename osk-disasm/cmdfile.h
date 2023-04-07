
#ifndef CMDFILE_H
#define CMDFILE_H

#include "externc.h"

cfunc void do_cmd_file(void);
cfunc int ApndCmnt(char* lpos);
cfunc char* cmntsetup(char* cpos, char* clas, int* adrs);
cfunc char* cmdsplit(char* dest, char* src);
cfunc void getrange(char* pt, int* lo, int* hi, int usize, int allowopen);
cfunc void boundsline(char* mypos);
cfunc void setupbounds(char* lpos);
cfunc void tellme(char* pt);

cglobal FILE* CmdFP;

#endif
