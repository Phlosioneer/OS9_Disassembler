
#ifndef DIS_MAIN_H
#define DIS_MAIN_H

#include <memory>
#include <stdint.h>
#include <stdio.h>

#include "address_space.h"
#include "reader.h"
#include "userdef.h"

struct modnam;
struct cmd_items;
struct options;
class DataRegion;

struct module_header
{
    uint16_t id = 0;
    uint16_t sysRev = 0;
    uint32_t size = 0;
    uint32_t owner = 0;
    uint32_t nameOffset = 0;
    uint16_t access = 0;
    uint8_t type = 0;
    uint8_t lang = 0;
    uint8_t attributes = 0;
    uint8_t revision = 0;
    uint16_t edition = 0;
    uint32_t usageOffset = 0;
    uint32_t symbolTableOffset = 0;
    uint16_t parity = 0;

    /* These fields are used for:
     * MT_PROGRAM, MT_SYSTEM, MT_TRAPLIB, MT_FILEMAN, MT_DEVDRVR
     */
    uint32_t execOffset = 0;
    uint32_t exceptionOffset = 0;

    /* This field is used for:
     * MT_PROGRAM, MT_TRAPLIB, MT_DEVDRVR
     */
    uint32_t memorySize = 0;

    /* These fields are used for: MT_PROGRAM, MT_TRAPLIB */
    uint32_t stackSize = 0;
    uint32_t initDataHeaderOffset = 0;
    uint32_t refTableOffset = 0;

    /* These fields are used for: MT_TRAPLIB */
    uint32_t initRoutineOffset = 0;
    uint32_t terminationRoutineOffset = 0;

    /* Derived fields */
    uint32_t startPC = 0;
    uint32_t CodeEnd = 0;
    uint32_t uninitDataSize = 0;
    uint32_t initDataSize = 0;

    std::unique_ptr<BigEndianStream> codeStream{};
    std::unique_ptr<BigEndianStream> initDataStream{};
};

struct modnam* modnam_find(struct modnam* pt, int desired);
int dopass(int mypass, struct options* opt);
int notimplemented(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
void HandleDataRegion(const DataRegion* bp, struct parse_state* state, AddrSpaceHandle literalSpace);
void HandleRegion(const DataRegion* bp, struct parse_state* state);

extern uint8_t PBytSiz;

#endif
