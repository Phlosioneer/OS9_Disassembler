
#ifndef DIS_68_H
#define DIS_68_H

#include <stdio.h>
#include "externc.h"

#define MAX_LBFIL 32
struct options {
	int PrintAllCode;
	char* CmdFileName;
	FILE* CmdFP;
	int cpu;
	struct writer_handle* asmFile;
	int IsROF;
	/* Count of Label files specified     */
	int LblFilz;
	/* Pointers to the path names for the files */
	char* LblFNam[MAX_LBFIL];
	int PgWidth;
	int IsUnformatted;
	char* DefDir;
	char* ModFile;
	FILE* ModFP;
};

cfunc void usage(void);
cfunc struct options* getoptions(int argc, char** argv);
cfunc FILE* build_path(char* p, char* faccs, struct options *opt);
cfunc void do_opt(char* c, struct options *opt);
cfunc char* pass_eq(char* p);

cfunc struct options* options_new();
cfunc void options_destroy(struct options* opt);
cfunc void options_addLabelFile(struct options* opt, const char* name);

cglobal char* PsectName;
cglobal int Pass;    /* The disassembler is a two-pass assembler */
cglobal int PCPos;
cglobal int CmdEnt;   /* The Entry Point for the Command */
cglobal int ExtBegin; /* The position of the begin of the extended list (for PC-Relative addressing) */

#endif
