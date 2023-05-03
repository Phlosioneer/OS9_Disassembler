
#ifndef DIS_MAIN_H
#define DIS_MAIN_H

#include <stdio.h>

#include "userdef.h"

struct modnam;
struct cmd_items;
struct options;
class DataRegion;

struct module_header
{
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

struct modnam* modnam_find(struct modnam* pt, int desired);
int dopass(int mypass, struct options* opt);
int notimplemented(struct cmd_items* ci, int tblno, const OPSTRUCTURE* op, struct parse_state* state);
void MovBytes(const DataRegion* bp, struct parse_state* state);
void NsrtBnds(const DataRegion* bp, struct parse_state* state);

struct module_header* module_new();
void module_destroy(struct module_header* module_);

extern int error;
extern int CodeEnd;

extern struct module_header* modHeader;
extern int IDataBegin;
extern int IDataCount;
extern int HdrEnd; /* The first byte past end of header, usefull for begin of Pass 2 */

extern int NowClass;
extern int PBytSiz;

#endif
