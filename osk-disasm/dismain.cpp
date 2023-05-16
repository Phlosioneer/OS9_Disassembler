
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  *
 * dismain.c - The main disassembler routine.  This handles a single    *
 *      pass for the disassembler routine. For each command, it passes  *
 *      off the job of disassembling that command.                      *
 *                                                                      *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  *
 *                                                                      *
 * Copyright (c) 2017 David Breeding                                    *
 *                                                                      *
 * This file is part of osk-disasm.                                     *
 *                                                                      *
 * osk-disasm is free software: you can redistribute it and/or modify   *
 * it under the terms of the GNU General Public License as published by *
 * the Free Software Foundation, either version 3 of the License, or    *
 * (at your option) any later version.                                  *
 *                                                                      *
 * osk-disasm is distributed in the hope that it will be useful,        *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of       *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        *
 * GNU General Public License for more details.                         *
 *                                                                      *
 * You should have received a copy of the GNU General Public License    *
 * (see the file "COPYING") along with osk-disasm.  If not,             *
 * see <http://www.gnu.org/licenses/>.                                  *
 *                                                                      *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define _MAIN_ /* We will define all variables in one header file, then                                                \
                  define them extern from all other files */

#include "dismain.h"

#include <ctype.h>
#include <sstream>
#include <string.h>

#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "def68def.h"
#include "disglobs.h"
#include "dprint.h"
#include "exit.h"
#include "label.h"
#include "main_support.h"
#include "modtypes.h"
#include "rof.h"
#include "textdef.h"

#ifdef _WIN32
#define strcasecmp _stricmp
#endif

#ifdef _OSK
#define strcasecmp strcmp
#endif

static bool get_asmcmd(struct cmd_items* ci, struct parse_state* state);

static const char* DrvrJmps[] = {"Init", "Read", "Write", "GetStat", "SetStat", "Term", "Except", NULL};

static const char* FmanJmps[] = {"Open",  "Create", "Makdir",  "Chgdir",  "Delete",  "Seek",  "Read",
                                 "Write", "Readln", "Writeln", "Getstat", "Setstat", "Close", NULL};

const OPSTRUCTURE* opmains[] = {instr00, instr01, instr02, /* Repeat 3 times for 3 move sizes */
                                instr03, instr04, instr05, instr06, instr07, instr08, instr09, NULL, /* No instr 010 */
                                instr11, instr12, instr13, instr14, NULL};

static void readOpword(struct cmd_items* ci, struct parse_state* state);
static void getModuleHeader(struct options* opt);

// Read the Driver initialization table and set up label names.
// NOT ACTIVELY MAINTAINED.
static void get_drvr_jmps(int mty, BigEndianStream* Module)
{
    throw std::runtime_error("driver modules aren't supported anymore");
    /*
    register const char** pt;
    register int jmpdst;
    int jmpbegin = ftell(ModFP);
    char boundstr[50];

    if (mty == MT_DEVDRVR)
    {
        pt = DrvrJmps;
    }
    else
    {
        pt = FmanJmps;
    }

    while (*pt)
    {
        jmpdst = fread_w(ModFP);

        if (jmpdst)
        {
            addlbl('L', jmpdst, *pt);
            sprintf(boundstr, "L W L %x-%lx", jmpbegin, ftell(ModFP) - 1);
        }
        else
        {
            sprintf(boundstr, "L W & %x-%lx", jmpbegin, ftell(ModFP) - 1);
        }

        setupbounds(boundstr);

        jmpbegin = ftell(ModFP);
        ++pt;
    }
    */
}

// Get the module header.  We will do this only in Pass 1.
static void getHeader(struct options* opt)
{
    /* Get standard (common to all modules) header fields */

    // Need to be careful to avoid sign-extension.
    // mod->id = (unsigned short)fread_w(opt->ModFP);
    // opt->Module->readInto(mod->id);
    auto syncCode = opt->Module->read<uint16_t>();
    switch (syncCode)
    {
    case 0x4afc:
        getModuleHeader(opt);
        break;
    case 0xdead:
        getRofHdr(opt);
        break;
    default:
        errexit("Unknown module type");
    }
}

static void getModuleHeader(struct options* opt)
{
    auto mod = std::make_unique<module_header>();
    opt->Module->reset();
    mod->id = opt->Module->read<uint16_t>();
    mod->sysRev = opt->Module->read<uint16_t>();
    mod->size = opt->Module->read<uint32_t>();
    mod->owner = opt->Module->read<uint32_t>();
    mod->nameOffset = opt->Module->read<uint32_t>();
    mod->access = opt->Module->read<uint16_t>();
    mod->type = opt->Module->read<uint8_t>();
    mod->lang = opt->Module->read<uint8_t>();
    mod->attributes = opt->Module->read<uint8_t>();
    mod->revision = opt->Module->read<uint8_t>();
    mod->edition = opt->Module->read<uint16_t>();
    mod->usageOffset = opt->Module->read<uint32_t>();
    mod->symbolTableOffset = opt->Module->read<uint32_t>();

    /* We have 14 bytes that are not used */
    opt->Module->seekRelative(14);

    mod->parity = opt->Module->read<uint16_t>();

    /* Now get any further Mod-type specific headers */
    switch (mod->type)
    {
    case MT_PROGRAM:
    case MT_SYSTEM:
    case MT_TRAPLIB:
    case MT_FILEMAN:
    case MT_DEVDRVR:
        mod->execOffset = opt->Module->read<uint32_t>();

        /* Add label for Exception Handler, if applicable */
        /* Only for specific Module Types??? */
        mod->exceptionOffset = opt->Module->read<uint32_t>();
        if (mod->exceptionOffset)
        {
            addlbl(&CODE_SPACE, mod->exceptionOffset, "");
        }

        if ((mod->type != MT_SYSTEM) && (mod->type != MT_FILEMAN))
        {
            mod->memorySize = opt->Module->read<uint32_t>();

            if (mod->type == MT_TRAPLIB || mod->type == MT_PROGRAM)
            {
                mod->stackSize = opt->Module->read<uint32_t>();
                mod->initDataHeaderOffset = opt->Module->read<uint32_t>();
                mod->refTableOffset = opt->Module->read<uint32_t>();

                if (mod->type == MT_TRAPLIB)
                {
                    mod->initRoutineOffset = opt->Module->read<uint32_t>();
                    mod->terminationRoutineOffset = opt->Module->read<uint32_t>();
                }
            }
        }

        mod->startPC = (uint32_t)opt->Module->position();

        if ((mod->type == MT_DEVDRVR) || (mod->type == MT_FILEMAN))
        {
            opt->Module->seekAbsolute(mod->execOffset);
            get_drvr_jmps(mod->type, opt->Module.get());
        }

        if (mod->initDataHeaderOffset)
        {
            // Read the init data header.
            opt->Module->seekAbsolute(mod->initDataHeaderOffset);
            mod->uninitDataSize = opt->Module->read<uint32_t>();
            mod->initDataSize = opt->Module->read<uint32_t>();
            mod->initDataStream = std::make_unique<BigEndianStream>(opt->Module->fork(mod->initDataSize));

            // Insure we have an entry for the first Initialized Data
            mod->CodeEnd = mod->initDataHeaderOffset;
        }
        else
        {
            /* This may be incorrect */
            mod->CodeEnd = mod->size - 3;
            // All memory is uninit.
            mod->uninitDataSize = mod->memorySize;
            mod->initDataSize = 0;
        }

        opt->Module->seekAbsolute(mod->startPC);
        auto codeSize = mod->CodeEnd - mod->startPC;
        mod->codeStream = std::make_unique<BigEndianStream>(opt->Module->fork(codeSize));
    }

    // Check if the file is complete.
    opt->Module->seekAbsolute(0);
    if (opt->Module->size() < mod->size)
    {
        errexit("\n*** ERROR!  File size < Module Size... Aborting...! ***\n");
    }
    opt->modHeader = std::move(mod);
}

/*
 * Reads a label file and stores label values into label tree if value (or
 * address) is present in tree. Path to file has already been opened and is
 * stored in "inpath".
 *
 * Lines are in the format:
 *      NAME equ ADDR CLASS
 * ADDR can be either decimal, or hex with the prefix $. CLASS is one "D" or "L".
 */
static void RdLblFile(FILE* inpath)
{
    char labelname[30], category[30], eq[10], strval[15], *lbegin;
    int address;
    Label* nl;

    while (!feof(inpath))
    {
        char rdbuf[81];

        fgets(rdbuf, 80, inpath);

        lbegin = skipblank(rdbuf);
        if (!lbegin || (*lbegin == '*'))
        {
            continue;
        }

        if (sscanf(rdbuf, "%s %s %s %s", labelname, eq, strval, category) == 4)
        {
            AddrSpaceHandle realCategory = nullptr;
            for (auto handle : allSpaces)
            {
                if (handle->name == category || handle->shortcode == category)
                {
                    realCategory = handle;
                }
            }
            if (!realCategory) throw std::runtime_error("Unrecognized label category in label file");

            if (!strcasecmp(eq, "equ"))
            {
                /* Store address in proper place */

                if (strval[0] == '$') /* if represented in hex */
                    sscanf(&strval[1], "%x", &address);
                else
                {
                    address = atoi(strval);
                }

                nl = findlbl(realCategory, address);

                if (nl)
                {
                    nl->setName(labelname);
                    nl->setStdName(true);
                }
            }
        }
    }
}

// For module files, sort all the labels in UNKNOWN_DATA_SPACE into INIT_DATA_SPACE
// and UNINIT_DATA_SPACE.
static void resoveUnknownDataSpace(struct options* opt)
{
    auto unkCategory = labelManager->getCategory(&UNKNOWN_DATA_SPACE);
    auto initCategory = labelManager->getCategory(&INIT_DATA_SPACE);
    auto uninitCategory = labelManager->getCategory(&UNINIT_DATA_SPACE);

    auto cutoffAddr = opt->modHeader->uninitDataSize;

    for (auto it = unkCategory->begin(); it != unkCategory->end(); it++)
    {
        auto dest = (*it)->address() < cutoffAddr ? uninitCategory : initCategory;

        Label* newLabel = nullptr;
        if ((*it)->nameIsDefault())
        {
            newLabel = dest->add((*it)->value, nullptr);
        }
        else
        {
            newLabel = dest->add((*it)->value, (*it)->name().c_str());
        }

        if ((*it)->global()) newLabel->setGlobal(true);
        if ((*it)->stdName()) newLabel->setStdName(true);

        unkCategory->addRedirect(newLabel->value, newLabel);
    }
}

/**
 * Set up all label definitions. Reads in all default label files and then reads
 * any files specified by the '-s' option.
 */
static void GetLabels(struct options* opt) /* Read the labelfiles */
{

    /* First, get built-in ascii definitions.  Later, if desired,
     * they can be redefined */

    /*for (x = 0; x < 33; x++)
    {
        if ((nl = FindLbl (ListRoot ('^'), x)))
        {
            strcpy (nl->sname, CtrlCod[x]);
        }
    }

    if ((nl = FindLbl (ListRoot ('^'), 0x7f)))
    {
        strcpy (nl->sname, "del");
    }*/

    /* Next read in the Standard systems names file */

    /*if ((OSType == OS_9) || (OSType == OS_Moto))
    {
        tmpnam = build_path ("sysnames");

        if ( ! (inpath = fopen (tmpnam, "rb")))
            fprintf (stderr, "Error in opening Sysnames file..%s\n",
                              filename);
        else
        {
            RdLblFile ();
            fclose (inpath);
        }
    }*/

    /* Now read in label files specified on the command line */

    for (const auto& filename : opt->labelFiles)
    {
        register FILE* inpath;

        inpath = build_path(filename, BINREAD, opt);
        if (inpath)
        {
            RdLblFile(inpath);
            fclose(inpath);
        }
        else
        {
            fprintf(stderr, "ERROR! cannot open Label File %s for read\n", filename.c_str());
        }
    }
}

/*
 * Do a complete single pass through the module. The first pass establishes the
 * addresses of necessary labels. On the second pass, the desired label names
 * have been inserted and printing of the listing and writing of the source file
 * is done, if either or both is desired.
 */
int dopass(int Pass, struct options* opt)
{
    if (Pass == 1)
    {
        opt->Module->reset();

        getHeader(opt);
        if (opt->modHeader)
        {
            addlbl(&CODE_SPACE, opt->modHeader->execOffset, NULL);
        }
        else
        {
            // TODO: The label in a ROF psect is broken in pass 1. This line shouldn't be necessary.
            addlbl(&CODE_SPACE, 0, NULL);
        }

        GetIRefs(opt);
        do_cmd_file(opt);
    }
    else /* Do Pass 2 Setup */
    {
        if (!opt->IsROF)
        {
            resoveUnknownDataSpace(opt);
        }
        GetLabels(opt);

        WrtEquates(1, opt);
        WrtEquates(0, opt);

        if (opt->IsROF)
        {
            ROFPsect(opt);
            ROFDataPrint(opt);
        }
        else
        {
            PrintPsect(opt);
            OS9DataPrint(opt);
        }
    }

    uint32_t CodeEnd;
    struct parse_state parseState;
    parseState.opt = opt;
    parseState.Pass = Pass;
    if (opt->IsROF)
    {
        parseState.PCPos = 0;
        CodeEnd = opt->ROFHd->CodeEnd;
        parseState.Module = opt->ROFHd->codeStream.get();
    }
    else
    {
        parseState.PCPos = opt->modHeader->startPC;
        CodeEnd = opt->modHeader->CodeEnd;
        parseState.Module = opt->modHeader->codeStream.get();
    }
    parseState.Module->reset();

    int instrNum = -1;
    while (parseState.PCPos < CodeEnd)
    {
        const DataRegion* bp;

        instrNum += 1;

        if (parseState.PCPos + parseState.Module->size() != CodeEnd)
        {
            throw std::runtime_error("PC and bytestream desync!");
        }

        struct cmd_items Instruction;
        parseState.CmdEnt = parseState.PCPos;

        /* NOTE: The 6809 version did an "if" and it apparently worked,
         *     but we had to do this to get it to work with consecutive bounds.
         */
        for (bp = allRegions.classHere(parseState.PCPos); bp; bp = allRegions.classHere(parseState.PCPos))
        {
            HandleRegion(bp, &parseState);
            parseState.CmdEnt = parseState.PCPos;
        }

        if (parseState.CmdEnt >= CodeEnd) continue;

        if (get_asmcmd(&Instruction, &parseState))
        {
            if (Pass == 2)
            {
                PrintLine(pseudcmd, &Instruction, &CODE_SPACE, parseState.CmdEnt, parseState.PCPos, opt);

                if (opt->PrintAllCode && Instruction.wcount)
                {
                    int count = Instruction.wcount;
                    std::ostringstream codbuf;
                    int wpos = 0;

                    while (count)
                    {
                        char tmpcod[10];

                        sprintf(tmpcod, "%04x ", (unsigned short)Instruction.code[wpos++]);
                        codbuf << tmpcod;
                        --count;
                    }

                    printXtraBytes(codbuf.str());
                }
            }
        }
        else
        {
            readOpword(&Instruction, &parseState);
            if (Pass == 2)
            {
                strcpy(Instruction.mnem, "dc.w");
                std::ostringstream params;
                params << '$' << PrettyNumber<uint16_t>(Instruction.cmd_wrd & 0xffff).hex();
                auto result = params.str();
                strcpy(Instruction.params, result.c_str());
                PrintLine(pseudcmd, &Instruction, &CODE_SPACE, parseState.CmdEnt, parseState.PCPos, opt);
                parseState.CmdEnt = parseState.PCPos;
            }
        }
    }

    if (Pass == 2)
    {
        WrtEnds(opt, parseState.PCPos);
    }

    return 0;
}

/*
 * noimplemented() - A dummy function which simply returns NULL for instructions
 *       that do not yet have handler functions
 */
int notimplemented(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state)
{
    return 0;
}

static void readOpword(struct cmd_items* ci, struct parse_state* state)
{
    *ci = {};
    if (state->Module->size() < 2)
    {
        throw std::runtime_error("get_asmcmd called without 2 bytes in buffer!");
    }
    ci->cmd_wrd = state->Module->read<uint16_t>();
    state->PCPos += 2;
}

static bool get_asmcmd(struct cmd_items* Instruction, struct parse_state* state)
{
    register const OPSTRUCTURE* optbl;
    auto mark = state->Module->position();
    int j;

    readOpword(Instruction, state);

    /* This may be temporary.  Opword %1111xxxxxxxxxxxx is available
     * for 68030-68040 CPU's, but we are not yet making this available
     */
    if ((Instruction->cmd_wrd & 0xf000) == 0xf000)
    {
        state->Module->seekAbsolute(mark);
        state->PCPos = state->CmdEnt;
        return false;
    }

    optbl = opmains[(Instruction->cmd_wrd >> 12) & 0x0f];
    if (!optbl)
    {
        state->Module->seekAbsolute(mark);
        state->PCPos = state->CmdEnt;
        return false;
    }

    for (j = 0; j <= MAXINST; j++)
    {
        const OPSTRUCTURE* curop = &optbl[j];

        if (!(curop->name)) break;

        curop = tablematch(Instruction->cmd_wrd, curop);

        /* The table must be organized such that the "cpulvl" field
         * is sorted in ascending order.  Therefore, if a "cpulvl"
         * higher than "cpu" is encountered we can abort the search.
         */
        /*
        if (curop->cpulvl > state->cpu)
        {
            return 0;
        }
        */

        if (curop)
        {
            if (curop->opfunc(Instruction, curop, state))
            {
                return true;
            }
            else
            {
                // Restore state to the start of the function.
                state->Module->seekAbsolute(mark);
                state->PCPos = state->CmdEnt;

                // Reset Instruction and re-read the instruction opcode word.
                readOpword(Instruction, state);
            }
        }
    }

    // Restore state to the start of the function.
    state->Module->seekAbsolute(mark);
    state->PCPos = state->CmdEnt;
    return false;
}

/*
 * Reads data for Data Boundary range from input file and places it onto the print
 * buffer (and does any applicable printing if in pass 2). Only called within
 * CODE_SPACE, which is a bit weird.
 */
void HandleDataRegion(const DataRegion* db, struct parse_state* state, AddrSpaceHandle literalSpace)
{
    struct cmd_items Ci;
    char tmps[20];
    unsigned int valu;
    int bmask;
    std::ostringstream xtrabytes;
    int cCount = 0, maxLst;

    state->CmdEnt = state->PCPos;

    /* This may be temporary, and we may set PBytSiz
     * to the appropriate value */
    strcpy(Ci.mnem, "dc");
    Ci.params[0] = '\0';
    Ci.lblname = "";
    Ci.comment = NULL;
    Ci.cmd_wrd = 0;

    switch (db->size())
    {
    case 1:
        strcat(Ci.mnem, ".b");
        maxLst = 4;
        bmask = 0xff;
        break;
    case 2:
        strcat(Ci.mnem, ".w");
        maxLst = 2;
        bmask = 0xffff;
        break;
    case 4:
        strcat(Ci.mnem, ".l");
        maxLst = 1;
        bmask = 0xffff;
        break;
    default:
        throw std::runtime_error("Unexpected byte size");
    }

    while (state->PCPos <= db->range.end)
    {
        /* Init dest buffer to null string for LblCalc concatenation */

        tmps[0] = '\0';

        switch (db->size())
        {
        case 1:
            valu = state->Module->read<uint8_t>();
            break;
        case 2:
            valu = state->Module->read<uint16_t>();
            break;
        case 4:
            valu = state->Module->read<uint32_t>();
            break;
        default:
            errexit("Unexpected byte size");
        }

        state->PCPos += db->size();
        ++cCount;

        /* AMode = 0 to prevent LblCalc from defining class */
        if (!LblCalc(tmps, valu, 0, state->PCPos - db->size(), state->opt->IsROF, state->Pass))
        {
            PrintNumber(tmps, valu, 0, db->size(), literalSpace);
        }

        if (state->Pass == 2)
        {
            if (cCount == 0)
            {
                Ci.cmd_wrd = valu & bmask;
            }
            else if (cCount < maxLst)
            {
                Ci.cmd_wrd = ((Ci.cmd_wrd << (db->size() * 8)) | (valu & bmask));
            }
            else
            {
                xtrabytes << PrettyNumber<uint32_t>(valu & bmask).fill('0').hex().width(4);
            }

            ++cCount;

            if (strlen(Ci.params))
            {
                strcat(Ci.params, ",");
            }

            strcat(Ci.params, tmps);

            // If length of operand string is max, print a line
            // Baked-in assumption that this function is only called within CODE_SPACE.
            if ((strlen(Ci.params) > 22) || findlbl(&CODE_SPACE, state->PCPos))
            {
                PrintLine(pseudcmd, &Ci, &CODE_SPACE, state->CmdEnt, state->PCPos, state->opt);

                printXtraBytes(xtrabytes.str());
                xtrabytes = {};

                Ci.params[0] = '\0';
                Ci.cmd_wrd = 0;
                Ci.lblname.clear();
                state->CmdEnt = state->PCPos;
                cCount = 0;
            }
        }

        /*PCPos += db->size();*/
    }

    /* Loop finished.. print any unprinted data */

    if ((state->Pass == 2) && strlen(Ci.params))
    {
        // Baked-in assumption that this function is only called within CODE_SPACE.
        PrintLine(pseudcmd, &Ci, &CODE_SPACE, state->CmdEnt, state->PCPos, state->opt);

        printXtraBytes(xtrabytes.str());
    }
}

/*
 * Insert boundary area. Only called within CODE_SPACE.
 */
void HandleRegion(const DataRegion* bp, struct parse_state* state)
{
    switch (bp->type)
    {
    case DataRegion::DataSize::String:
        // TODO: Replace with a call to DoAsciiData.
        // MovASC(bp->range.end - PCPos + 1, 'L', state);
        throw std::runtime_error("Explicit string region not supported yet.");
        break; /* bump PC  */
    case DataRegion::DataSize::Words:
        HandleDataRegion(bp, state, &LITERAL_HEX_SPACE);
        break;
    case DataRegion::DataSize::Longs:
        HandleDataRegion(bp, state, &LITERAL_HEX_SPACE);
        break;
    case DataRegion::DataSize::Bytes:
        HandleDataRegion(bp, state, &LITERAL_HEX_SPACE);
        break;
    default:
        throw std::runtime_error("Unexpected DataSize enum value");
    }
}