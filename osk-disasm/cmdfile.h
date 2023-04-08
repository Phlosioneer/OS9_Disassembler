
#ifndef CMDFILE_H
#define CMDFILE_H

#include "externc.h"
#include "structs.h"
#include <stdio.h>

cfunc void do_cmd_file(void);
cfunc int ApndCmnt(char* lpos);
cfunc char* cmntsetup(char* cpos, char* clas, int* adrs);
cfunc char* cmdsplit(char* dest, char* src);
cfunc void getrange(char* pt, int* lo, int* hi, int usize, int allowopen);
cfunc void boundsline(char* mypos);
cfunc void setupbounds(char* lpos);
cfunc void tellme(char* pt);

cglobal FILE* CmdFP;
cglobal struct data_bounds* dbounds;
cglobal struct data_bounds* LAdds[];
/* The path for the Command File Name */
cglobal char* CmdFileName;
cglobal int DoingCmds;

#endif
