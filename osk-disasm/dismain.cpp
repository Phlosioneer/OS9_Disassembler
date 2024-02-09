
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

#include "pch.h"

#include "dismain.h"

#include <ctype.h>
#include <iomanip>

#include "address_space.h"
#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "def68def.h"
#include "dprint.h"
#include "exit.h"
#include "main_support.h"
#include "modtypes.h"
#include "textdef.h"

#ifdef _WIN32
#define strcasecmp _stricmp
#endif

static const char* DriverJumpTableNames[] = {"Init", "Read", "Write", "GetStat", "SetStat", "Term", "Except", NULL};

static const char* FileManagerJumpTableNames[] = {"Open",  "Create", "Makdir",  "Chgdir",  "Delete",  "Seek",  "Read",
                                 "Write", "Readln", "Writeln", "Getstat", "Setstat", "Close", NULL};

const OPSTRUCTURE* opmains[] = {instr00, instr01, instr02, /* Repeat 3 times for 3 move sizes */
                                instr03, instr04, instr05, instr06, instr07, instr08, instr09, NULL, /* No instr 010 */
                                instr11, instr12, instr13, instr14, NULL};

static void readOpword(struct cmd_items* ci, struct parse_state* state);
static void getModuleHeader(struct options* opt);
static void HandleDataRegion(const DataRegion* bp, struct parse_state* state, AddrSpaceHandle literalSpace);
static void HandleRegion(const DataRegion* bp, struct parse_state* state);

inline void getRofHdr(struct options* opt)
{
    opt->IsROF = true;
    opt->ROFHd = std::make_unique<RoffFile>(opt->Module.get());
}

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
            labelManager.addLabel('L', jmpdst, *pt);
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
    case MT_Program:
    case MT_System:
    case MT_TrapLibrary:
    case MT_FileManager:
    case MT_DeviceDriver:
        mod->execOffset = opt->Module->read<uint32_t>();

        /* Add label for Exception Handler, if applicable */
        /* Only for specific Module Types??? */
        mod->exceptionOffset = opt->Module->read<uint32_t>();
        if (mod->exceptionOffset)
        {
            labelManager.addLabel(&CODE_SPACE, mod->exceptionOffset);
        }

        if ((mod->type != MT_System) && (mod->type != MT_FileManager))
        {
            mod->memorySize = opt->Module->read<uint32_t>();

            if (mod->type == MT_TrapLibrary || mod->type == MT_Program)
            {
                mod->stackSize = opt->Module->read<uint32_t>();
                mod->initDataHeaderOffset = opt->Module->read<uint32_t>();
                mod->refTableOffset = opt->Module->read<uint32_t>();

                if (mod->type == MT_TrapLibrary)
                {
                    mod->initRoutineOffset = opt->Module->read<uint32_t>();
                    mod->terminationRoutineOffset = opt->Module->read<uint32_t>();
                }
            }
        }

        mod->startPC = (uint32_t)opt->Module->position();

        if ((mod->type == MT_DeviceDriver) || (mod->type == MT_FileManager))
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

                auto label = labelManager.getLabel(realCategory, address);

                if (label)
                {
                    label->setName(labelname);
                    label->setStdName(true);
                }
            }
        }
    }
}

// For module files, sort all the labels in UNKNOWN_DATA_SPACE into INIT_DATA_SPACE
// and UNINIT_DATA_SPACE.
static void resoveUnknownDataSpace(struct options* opt)
{
    LabelCategory& unkCategory = labelManager.getCategory(&UNKNOWN_DATA_SPACE);
    LabelCategory& initCategory = labelManager.getCategory(&INIT_DATA_SPACE);
    LabelCategory& uninitCategory = labelManager.getCategory(&UNINIT_DATA_SPACE);

    auto cutoffAddr = opt->modHeader->uninitDataSize;

    for (auto label : unkCategory)
    {
        LabelCategory& dest = label->address() < cutoffAddr ? uninitCategory : initCategory;

        std::shared_ptr<Label> newLabel;
        if (label->nameIsDefault())
        {
            newLabel = dest.add(label->value);
        }
        else
        {
            newLabel = dest.add(label->value, label->name().c_str());
        }

        if (label->global()) newLabel->setGlobal(true);
        if (label->stdName()) newLabel->setStdName(true);

        unkCategory.addRedirect(newLabel->value, newLabel);
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

void doDataDirective(struct parse_state& parseState, OperandSize size)
{
    uint32_t value = parseState.Module->read(size);

    if (parseState.Pass == 2)
    {
        std::string text;

        std::string directive{"dc"};
        directive += OperandSizes::getSuffix(size);

        // Amod = 0 to suppress label creation.
        if (LblCalc(text, value, AM_NO_LABELS, parseState.PCPos, parseState.opt->IsROF, parseState.Pass, size))
        {
            std::vector<uint16_t> rawData;
            if (size == OperandSize::Long)
            {
                rawData.push_back(static_cast<uint16_t>(value >> 16));
            }
            rawData.push_back(static_cast<uint16_t>(value));
            
            PrintDirective("", directive.c_str(), text, parseState.CmdEnt, parseState.PCPos, parseState.opt,
                            rawData, &CODE_SPACE);
        }
        else
        {
            auto formatted = FormattedNumber(value, size, &LITERAL_HEX_SPACE);
            PrintDirective("", directive.c_str(), formatted, parseState.CmdEnt, parseState.PCPos, parseState.opt, &CODE_SPACE);
        }
    }
    parseState.PCPos += OperandSizes::getByteCount(size);
    parseState.CmdEnt = parseState.PCPos;
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
            labelManager.addLabel(&CODE_SPACE, opt->modHeader->execOffset);
        }
        else
        {
            // TODO: The label in a ROF psect is broken in pass 1. This line shouldn't be necessary.
            labelManager.addLabel(&CODE_SPACE, 0);
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

        WrtEquates(true, opt);
        WrtEquates(false, opt);

        if (opt->IsROF)
        {
            PrintPsect(opt, false);
            ROFDataPrint(opt);
        }
        else
        {
            PrintPsect(opt, true);
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
        CodeEnd = opt->ROFHd->codeSize;
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
        // Check for user-specified data region (via json)
        if (bp = allRegions.classHere(parseState.PCPos))
        {
            HandleRegion(bp, &parseState);
            continue;
        }

        // Check for references that cover the current byte; they can't possibly be instructions.
        const auto maybeRefList = refManager.find_extrn(&CODE_SPACE, parseState.PCPos);
        if (maybeRefList)
        {
            OperandSize largestRefSize = OperandSize::Byte;
            for (const rof_extrn& ref : *maybeRefList)
            {
                largestRefSize = OperandSizes::max(largestRefSize, ref.info.opSize());
            }

            doDataDirective(parseState, largestRefSize);
            continue;
        }

        // Correct alignment if needed before trying to parse code.
        if (parseState.PCPos % 2 == 1)
        {
            doDataDirective(parseState, OperandSize::Byte);
            continue;
        }

        if (parseState.CmdEnt >= CodeEnd) continue;

        if (get_asmcmd(&Instruction, &parseState))
        {
            if (Pass == 2)
            {
                PrintLine(&Instruction, &CODE_SPACE, parseState.CmdEnt, parseState.PCPos, opt);

                if (opt->PrintAllCode && Instruction.rawDataSize > 0)
                {
                    std::ostringstream buffer;
                    buffer << std::hex << std::setfill('0');

                    for (size_t i = 0; i < Instruction.rawDataSize; i++)
                    {
                        buffer << std::setw(4) << Instruction.rawData[i];
                    }

                    printXtraBytes(buffer.str());
                }
            }
        }
        else
        {
            doDataDirective(parseState, OperandSize::Word);
        }
    }

    if (Pass == 2)
    {
        WrtEnds(opt, parseState.PCPos);
    }

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

bool get_asmcmd(struct cmd_items* Instruction, struct parse_state* state)
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
static void HandleDataRegion(const DataRegion* db, struct parse_state* state, AddrSpaceHandle literalSpace)
{
    std::string tmps;
    uint32_t value;

    state->CmdEnt = state->PCPos;

    std::string directive("dc");
    directive += OperandSizes::getSuffix(db->size);

    std::vector<std::string> paramsBuffer;
    std::vector<uint16_t> rawData;
    paramsBuffer.reserve(4);
    rawData.reserve(4);
    size_t paramsBufferStringLen = 0;
    size_t bytesRead = 0;
    while (state->PCPos <= db->range.end)
    {
        /* Init dest buffer to empty string for LblCalc concatenation */
        tmps.clear();

        switch (db->size)
        {
        case OperandSize::Byte:
            value = state->Module->read<uint8_t>();
            if (bytesRead % 2 == 0)
            {
                rawData.push_back(value << 8);
            }
            else
            {
                uint16_t prev = rawData.back();
                rawData.pop_back();
                rawData.push_back(prev | value);
            }
            break;
        case OperandSize::Word:
            value = state->Module->read<uint16_t>();
            rawData.push_back(value);
            break;
        case OperandSize::Long:
            value = state->Module->read<uint32_t>();
            rawData.push_back(value >> 16);
            rawData.push_back(value & 0xFFFF);
            break;
        default:
            throw std::runtime_error("Unexpected size");
        }
        bytesRead += OperandSizes::getByteCount(db->size);

        auto dataEnt = state->PCPos;
        state->PCPos += OperandSizes::getByteCount(db->size);

        /* AMode = 0 to prevent LblCalc from defining class */
        if (!LblCalc(tmps, value, AM_NO_LABELS, dataEnt, state->opt->IsROF, state->Pass, db->size))
        {
            tmps = PrintNumber(value, 0, OperandSizes::getByteCount(db->size), literalSpace);
        }

        if (state->Pass == 2)
        {
            if (!paramsBuffer.empty())
            {
                // Account for the comma
                paramsBufferStringLen += 1;
            }

            paramsBufferStringLen += tmps.size();
            paramsBuffer.push_back(tmps);

            // If length of operand string is max, print a line
            // Baked-in assumption that this function is only called within CODE_SPACE.
            if ((paramsBufferStringLen > 22) || labelManager.getLabel(&CODE_SPACE, state->PCPos))
            {
                PrintDirective("", directive.c_str(), paramsBuffer, state->CmdEnt, state->PCPos, state->opt, rawData, &CODE_SPACE);
                // TODO: this should be a setting, not an extra call. Need more internal printer state for
                // that though, which is on hold until the printer is a class.
                rawData.erase(rawData.begin());
                printXtraBytes(rawData);

                paramsBuffer.clear();
                paramsBufferStringLen = 0;
                rawData.clear();
                tmps.clear();
                state->CmdEnt = state->PCPos;
            }
        }
    }

    /* Loop finished.. print any unprinted data */

    if ((state->Pass == 2) && !paramsBuffer.empty())
    {
        // Baked-in assumption that this function is only called within CODE_SPACE.
        PrintDirective("", directive.c_str(), paramsBuffer, state->CmdEnt, state->PCPos, state->opt, rawData, &CODE_SPACE);
        // TODO: this should be a setting, not an extra call. Need more internal printer state for
        // that though, which is on hold until the printer is a class.
        rawData.erase(rawData.begin());
        printXtraBytes(rawData);
    }
}

/*
 * Insert boundary area. Only called within CODE_SPACE.
 */
static void HandleRegion(const DataRegion* bp, struct parse_state* state)
{
    // For now, this is just a pass-through. When more Region types are supported, this
    // function will dispatch by type.
    HandleDataRegion(bp, state, &LITERAL_HEX_SPACE);
}