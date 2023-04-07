
#ifndef DIS_68_H
#define DIS_68_H

#include <stdio.h>
#include "externc.h"

cfunc void usage(void);
cfunc void getoptions(int argc, char** argv);
cfunc FILE* build_path(char* p, char* faccs);
cfunc void do_opt(char* c);
cfunc char* pass_eq(char* p);

cglobal char* PsectName;

#endif
