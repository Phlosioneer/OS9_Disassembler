
#ifndef DIS_MAIN_H
#define DIS_MAIN_H

#include <stdint.h>
#include <stdio.h>

#include "userdef.h"

struct modnam;
struct cmd_items;
struct options;
class DataRegion;

struct module_header
{
    uint16_t id;
    uint16_t sysRev;
    uint32_t size;
    uint32_t owner;
    uint32_t nameOffset;
    uint16_t access;
    uint8_t type;
    uint8_t lang;
    uint8_t attributes;
    uint8_t revision;
    uint16_t edition;
    uint32_t usageOffset;
    uint32_t symbolTableOffset;
    uint16_t parity;

    /* These fields are used for:
     * MT_PROGRAM, MT_SYSTEM, MT_TRAPLIB, MT_FILEMAN, MT_DEVDRVR
     */
    uint32_t execOffset;
    uint32_t exceptionOffset;

    /* This field is used for:
     * MT_PROGRAM, MT_TRAPLIB, MT_DEVDRVR
     */
    uint32_t memorySize;

    /* These fields are used for: MT_PROGRAM, MT_TRAPLIB */
    uint32_t stackSize;
    uint32_t initDataHeaderOffset;
    uint32_t refTableOffset;

    /* These fields are used for: MT_TRAPLIB */
    uint32_t initRoutineOffset;
    uint32_t terminationRoutineOffset;
};

struct modnam* modnam_find(struct modnam* pt, int desired);
int dopass(int mypass, struct options* opt);
int notimplemented(struct cmd_items* ci, int tblno, const OPSTRUCTURE* op, struct parse_state* state);
void MovBytes(const DataRegion* bp, struct parse_state* state);
void NsrtBnds(const DataRegion* bp, struct parse_state* state);

struct module_header* module_new();
void module_destroy(struct module_header* module_);

extern int error;
extern uint32_t CodeEnd;

extern struct module_header* modHeader;
extern uint32_t IDataBegin;
extern uint32_t IDataCount;
extern size_t HdrEnd; /* The first byte past end of header, usefull for begin of Pass 2 */

extern int NowClass;
extern int PBytSiz;

#endif
