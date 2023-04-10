
#ifndef DIS_MAIN_H
#define DIS_MAIN_H

#include <stdio.h>

#include "userdef.h"
#include "externc.h"

struct modnam;
struct cmd_items;
struct options;

cfunc struct modnam* modnam_find(struct modnam* pt, int desired);
cfunc int dopass(int mypass, struct options* opt);
cfunc int showem(void);
cfunc int notimplemented(struct cmd_items* ci, int tblno, const OPSTRUCTURE* op, struct parse_state* state);
cfunc void MovBytes(struct data_bounds* db, struct parse_state* state);
cfunc void MovASC(int nb, char aclass, struct parse_state* state);
cfunc void NsrtBnds(struct data_bounds* bp, struct parse_state* state); \

cglobal int error;
cglobal int CodeEnd;

/* Module header variables */
cglobal unsigned int M_ID, M_SysRev;
cglobal long M_Size, M_Owner, M_Name;
cglobal int M_Accs;
cglobal char M_Type, M_Lang, M_Attr, M_Revs;
cglobal int M_Edit, M_Usage, M_Symbol, M_Parity,
	M_Exec, M_Except, M_Mem, M_Stack, M_IData,
	M_IRefs, M_Init, M_Term;
cglobal int IDataBegin;
cglobal int IDataCount;
cglobal int HdrEnd;   /* The first byte past end of header, usefull for begin of Pass 2 */

cglobal int AMode;
cglobal int NowClass;
cglobal int PBytSiz;

#endif
