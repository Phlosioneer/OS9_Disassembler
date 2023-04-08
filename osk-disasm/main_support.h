
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
cglobal int cpu;
cglobal int PrintAllCode;
cglobal int Pass;    /* The disassembler is a two-pass assembler */
cglobal char* ModFile;   /* The module file to read */
cglobal FILE* ModFP;
cglobal int WrtSrc;
cglobal int IsUnformatted;
cglobal int PCPos;
cglobal int CmdEnt;   /* The Entry Point for the Command */
cglobal int ExtBegin; /* The position of the begin of the extended list (for PC-Relative addressing) */
cglobal char* DefDir;

#endif
