
#ifndef DIS_MAIN_H
#define DIS_MAIN_H

#include <stdio.h>

#include "userdef.h"
#include "externc.h"

struct modnam;
struct cmd_items;
struct options;

struct module_header {
	unsigned int id;
	unsigned int sysRev;
	long size;
	long owner;
	long nameOffset;
	int access;
	char type;
	char lang;
	char attributes;
	char revision;
	int edition;
	int usageOffset;
	int symbolTableOffset;
	int parity;

	/* These fields are used for:
	 * MT_PROGRAM, MT_SYSTEM, MT_TRAPLIB, MT_FILEMAN, MT_DEVDRVR 
	 */
	int execOffset;
	int exceptionOffset;

	/* This field is used for:
	 * MT_PROGRAM, MT_TRAPLIB, MT_DEVDRVR
	 */
	int memorySize;

	/* These fields are used for: MT_PROGRAM, MT_TRAPLIB */
	int stackSize;
	int initDataHeaderOffset;
	int refTableOffset;

	/* These fields are used for: MT_TRAPLIB */
	int initRoutineOffset;
	int terminationRoutineOffset;
};

cfunc struct modnam* modnam_find(struct modnam* pt, int desired);
cfunc int dopass(int mypass, struct options* opt);
cfunc int showem(void);
cfunc int notimplemented(struct cmd_items* ci, int tblno, const OPSTRUCTURE* op, struct parse_state* state);
cfunc void MovBytes(struct data_bounds* db, struct parse_state* state);
cfunc void MovASC(int nb, char aclass, struct parse_state* state);
cfunc void NsrtBnds(struct data_bounds* bp, struct parse_state* state); \

cfunc struct module_header* module_new();
cfunc void module_destroy(struct module_header* module_);

cglobal int error;
cglobal int CodeEnd;

cglobal struct module_header *modHeader;
cglobal int IDataBegin;
cglobal int IDataCount;
cglobal int HdrEnd;   /* The first byte past end of header, usefull for begin of Pass 2 */

cglobal int AMode;
cglobal int NowClass;
cglobal int PBytSiz;

#endif
