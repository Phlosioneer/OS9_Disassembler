/* ******************************************************************** *
 *                                                                      *
 *  oskdisasm - OS9-68K DISASSEMBLER                                    *
 *         following the example of Dynamite+                           *
 *                                                                      *
 *  Edition History:                                                    *
 *  *  Date       Comments                                          by  *
 *  -- ---------- ---------------------------------------------     --- *
 *  01 2003/01/31 First began project                               dlb *
 * ******************************************************************** *
 * File:  dprint.c                                                      *
 * Purpose: handle printing and output function                         *
 *                                                                      *
 * ******************************************************************** *
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
 * ************************************************************************ */

#include "pch.h"

#include "dprint.h"

#include <algorithm>
#include <ctype.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "command_items.h"
#include "commonsubs.h"
#include "disglobs.h"
#include "dismain.h"
#include "exit.h"
#include "label.h"
#include "main_support.h"
#include "modtypes.h"
#include "rof.h"
#include "userdef.h"
#include "writer.h"

#include <iomanip>

#ifdef _WIN32
#define snprintf _snprintf
#endif

#define MAX_ASCII_LINE_LEN 26

struct modnam
{
    const char* name;
    int val;
};

struct ireflist* IRefs = NULL;
static void BlankLine(struct options* opt);
static void PrintFormatted(struct cmd_items* ci, struct options* opt, int CmdEnt);
static void NonBoundsLbl(AddrSpaceHandle space, struct options* opt, uint32_t startPC, uint32_t endPC);
static void TellLabels(LabelCategory& me, bool printStdLabels, AddrSpaceHandle space, int minval, struct options* opt);


static const char* xtraFmt = "             %s\n";

static std::string ClsHd{}; /* header format string for label equates */
static int HadWrote;     /* flag that header has been written */
static const char* SrcHd;      /* ptr for header for source file */
int LinNum;

const std::unordered_map<uint8_t, const char*> ModTypes{{1, "Prgrm"},   {2, "Sbrtn"},    {3, "Multi"},  {4, "Data"},
                                                        {5, "CSDData"}, {11, "TrapLib"}, {12, "Systm"}, {13, "FlMgr"},
                                                        {14, "Drivr"},  {15, "Devic"}};

const std::unordered_map<uint8_t, const char*> ModLangs{{1, "Objct"}, {2, "ICode"},   {3, "PCode"},
                                                        {4, "CCode"}, {5, "CblCode"}, {6, "FrtnCode"}};

const struct modnam ModAtts[] = {{"SupStat", 0x20}, {"Ghost", 0x40}, {"ReEnt", 0x80}, {"", 0}};

/// <summary>Search a modna struct for the desired value</summary>
/// <returns>Pointer to the desired value, or `nullptr` if missing.</returns>
static const struct modnam* modnam_find(const struct modnam* pt, int desired)
{
    while ((pt->val) && (pt->val != desired))
    {
        ++pt;
    }

    return (pt->val ? pt : NULL);
}

/* **********
 * PrintPsect() - Set up the Psect for printout
 *
 */

void PrintPsect(struct options* opt, bool printEquates)
{
    int pgWdthSave;
    std::vector<std::string> psectParams;

    if (printEquates) BlankLine(opt);

    /* Type/Language */
    std::string ProgType;
    uint16_t type = opt->modHeader ? opt->modHeader->type : opt->ROFHd->type;
    auto it = ModTypes.find(type);
    if (it != ModTypes.end())
    {
        ProgType = it->second;
        if (printEquates)
        {
            auto formatted = FormattedNumber(type, OperandSize::Byte, &LITERAL_HEX_SPACE);
            PrintDirective(ProgType, "set", formatted, 0, 0, opt, nullptr);
        }
    }
    else
    {
        ProgType = FormattedNumber(type).str();
    }

    int lang = opt->modHeader ? opt->modHeader->lang : opt->ROFHd->language;
    std::string ProgLang;
    it = ModLangs.find(lang);
    if (it != ModLangs.end())
    {
        ProgLang = it->second;
        if (printEquates)
        {
            auto formatted = FormattedNumber(lang, OperandSize::Byte, &LITERAL_HEX_SPACE);
            PrintDirective(ProgLang, "set", formatted, 0, 0, opt, nullptr);
        }
    }
    else
    {
        ProgLang = FormattedNumber(lang).str();
    }

    /* Att/Rev */
    std::string ProgAtts;
    int attributes = opt->modHeader ? opt->modHeader->attributes : opt->ROFHd->attributes;
    for (size_t c = 0; ModAtts[c].val; c++)
    {
        if (attributes & ModAtts[c].val)
        {
            if (!ProgAtts.empty())
            {
                ProgAtts += "+";
            }
            ProgAtts += ModAtts[c].name;

            if (printEquates)
            {
                std::string attName(ModAtts[c].name);
                auto formatted = FormattedNumber(ModAtts[c].val, OperandSize::Byte, &LITERAL_HEX_SPACE);
                PrintDirective(attName, "set", formatted, 0, 0, opt, nullptr);
            }
        }
    }

    /* Module name */
    if (!opt->psectName.empty())
    {
        psectParams.push_back(opt->psectName + "_a");
    }
    else if (opt->IsROF)
    {
        psectParams.push_back(opt->ROFHd->moduleName);
    }
    else if (strrchr(opt->ModFile.c_str(), PATHSEP))
    {
        std::string name(strrchr(opt->ModFile.c_str(), PATHSEP) + 1);
        psectParams.push_back(name + "_a");
    }
    else
    {
        psectParams.push_back(opt->ModFile + "_a");
    }

    if (type == 0 && lang == 0)
    {
        psectParams.push_back("0");
    }
    else
    {
        psectParams.push_back("(" + ProgType + "<<8)|" + ProgLang);
    }

    int revision = opt->modHeader ? opt->modHeader->revision : opt->ROFHd->revision;
    if (revision == 0 && attributes == 0)
    {
        psectParams.push_back("0");
    }
    else
    {
        if (ProgAtts.empty()) ProgAtts = "0";
        std::ostringstream attRevBuffer;
        attRevBuffer << '(' << ProgAtts << "<<8)|" << revision;
        psectParams.push_back(attRevBuffer.str());
    }

    int edition = opt->modHeader ? opt->modHeader->edition : opt->ROFHd->edition;
    psectParams.push_back(FormattedNumber(edition).str());

    int stack = opt->modHeader ? opt->modHeader->stackSize : opt->ROFHd->stackSize;
    psectParams.push_back(FormattedNumber(stack).str());

    int execOffset = opt->modHeader ? opt->modHeader->execOffset : opt->ROFHd->entryPointOffset;
    auto execOffsetLabel = labelManager.getLabel(&CODE_SPACE, execOffset);
    if (execOffsetLabel)
    {
        psectParams.push_back(execOffsetLabel->name());
    }
    else
    {
        psectParams.push_back(FormattedNumber(execOffset).str());
    }

    uint32_t exceptOffset = opt->modHeader ? opt->modHeader->exceptionOffset : opt->ROFHd->trapHandlerOffset;
    if (exceptOffset != (uint32_t)-1)
    {
        auto exceptOffsetLabel = labelManager.getLabel(&CODE_SPACE, exceptOffset);
        if (exceptOffsetLabel)
        {
            psectParams.push_back(exceptOffsetLabel->name());
        }
        else
        {
            psectParams.push_back(FormattedNumber(exceptOffset).str());
        }
    }

    /* Be sure to have enough space to write psect */
    pgWdthSave = opt->PgWidth;
    opt->PgWidth = 200;
    if (printEquates) BlankLine(opt);
    PrintDirective("", "psect", psectParams, 0, 0, opt, nullptr);
    BlankLine(opt);
    opt->PgWidth = pgWdthSave;
}

/* ************************************** *
 * OutputLine () - does the actual output *
 * to the listing and/or source file      *
 * ************************************** */

static void OutputLine(struct cmd_items* ci, struct options* opt, uint32_t CmdEnt,
                       AddrSpaceHandle space)
{
    if (space && ci->lblname.empty())
    {
        auto nl = labelManager.getLabel(space, CmdEnt);
        if (nl)
        {
            if (opt->IsROF && nl->global())
            {
                ci->lblname = nl->nameWithColon();
            }
            else
            {
                ci->lblname = nl->name();
            }
        }
    }

    PrintFormatted(ci, opt, CmdEnt);

    if (opt->asmFile)
    {
        std::ostringstream line;
        line << ci->lblname << ' ' << ci->mnem << ' ' << ci->renderParams();

        // writer_printf(opt->asmFile, "%s %s %s", ci->lblname.c_str(), ci->mnem, ci->params);

        if (!ci->comment.empty())
        {
            line << ' ' << ci->comment;
            // writer_printf(opt->asmFile, " %s", ci->comment);
        }

        // writer_printf(opt->asmFile, "\n");
        line << '\n';

        opt->asmFile->inner->write(line.str());
    }
}

/* Straighten/clean up - prepare for next line  */

static void PrintCleanup(int CmdEnt)
{
    ++LinNum;
}

static void BlankLine(struct options* opt) /* Prints a blank line */
{
    writer_printf(stdout_writer, "%5d\n", LinNum++);

    if (opt->asmFile)
    {
        writer_printf(opt->asmFile, "\n");
    }
}

/* ******************************************************** *
 * PrintLine () - The generic, global printline function    *
 *                It checks for unlisted boundaries, prints *
 *                the line, and then does cleanup           *
 * ******************************************************** */

void PrintLine(struct cmd_items* ci, AddrSpaceHandle space, uint32_t CmdEnt, uint32_t PCPos,
               options* opt)
{
    OutputLine(ci, opt, CmdEnt, space);
    PrintCleanup(CmdEnt);
    NonBoundsLbl(space, opt, CmdEnt, PCPos); /*Check for non-boundary labels */
}

void PrintDirective(const std::string& label, const char* directive, FormattedNumber value, uint32_t CmdEnt,
                    uint32_t PCPos, struct options* opt, AddrSpaceHandle space)
{
    // This is a hacky way to do this.

    struct cmd_items instr;
    if (value.size == OperandSize::Long)
    {
        uint16_t high = (value.number >> 16) & 0xFFFF;
        uint16_t low = value.number & 0xFFFF;
        instr.cmd_wrd = high;
        instr.rawData[0] = high;
        instr.rawData[1] = low;
        instr.rawDataSize = 2;
    }
    else
    {
        instr.cmd_wrd = OperandSizes::truncateUnsigned(value.size, value.number);
        instr.rawData[0] = instr.cmd_wrd;
        instr.rawDataSize = 1;
    }

    instr.lblname = label;
    instr.mnem = directive;
    instr.setSource(LiteralParam(value, false));
    PrintLine(&instr, space, CmdEnt, PCPos, opt);
}

void PrintDirective(const std::string& label, const char* directive, const std::vector<std::string>& params,
                    uint32_t CmdEnt, uint32_t PCPos, struct options* opt, AddrSpaceHandle space)
{
    std::ostringstream paramBuffer;

    auto it = params.cbegin();
    if (it != params.cend())
    {
        paramBuffer << *it;
        it++;
    }

    for (it; it != params.cend(); it++)
    {
        paramBuffer << ',' << *it;
    }

    PrintDirective(label, directive, paramBuffer.str(), CmdEnt, PCPos, opt, space);
}

void PrintDirective(const std::string& label, const char* directive, const std::string& param, uint32_t CmdEnt,
                    uint32_t PCPos, struct options* opt, AddrSpaceHandle space)
{
    // This is a hacky way to do this.

    struct cmd_items instr;
    instr.lblname = label;
    instr.mnem = directive;
    instr.setSource(LiteralParam(param, false));
    PrintLine(&instr, space, CmdEnt, PCPos, opt);
}

void PrintDirective(const std::string& label, const char* directive, const std::string& param, uint32_t CmdEnt,
                    uint32_t PCPos, struct options* opt, const std::vector<uint16_t>& rawData, AddrSpaceHandle space)
{
    // This is a hacky way to do this.

    struct cmd_items instr;
    instr.lblname = label;
    instr.mnem = directive;
    instr.setSource(LiteralParam(param, false));

    if (rawData.size() >= cmd_items::RAW_DATA_MAX) throw std::runtime_error("Too much data for directive!");
    for (size_t i = 0; i < rawData.size(); i++)
    {
        instr.rawData[i] = rawData[i];
    }
    instr.rawDataSize = rawData.size();

    if (!rawData.empty())
    {
        instr.cmd_wrd = rawData[0];
    }

    PrintLine(&instr, space, CmdEnt, PCPos, opt);
}

void PrintDirective(const std::string& label, const char* directive, const std::vector<std::string>& params, uint32_t CmdEnt,
                    uint32_t PCPos, struct options* opt, const std::vector<uint16_t>& rawData, AddrSpaceHandle space)
{
    std::ostringstream paramBuffer;

    auto it = params.cbegin();
    if (it != params.cend())
    {
        paramBuffer << *it;
        it++;
    }

    for (it; it != params.cend(); it++)
    {
        paramBuffer << ',' << *it;
    }

    PrintDirective(label, directive, paramBuffer.str(), CmdEnt, PCPos, opt, rawData, space);
}

static void PrintFormatted(struct cmd_items* ci, struct options* opt, int CmdEnt)
{
    using namespace std;

    auto params = ci->renderParams();
    ostringstream lineBuf;
    lineBuf << setw(5) << LinNum << "  ";
    lineBuf << setfill('0') << setw(5) << hex << CmdEnt << " ";
    lineBuf << setw(4) << ci->cmd_wrd << " ";
    lineBuf << setfill(' ') << left << setw(10) << ci->lblname << " ";
    lineBuf << setw(6) << ci->mnem << " ";
    lineBuf << setw(10) << ci->renderParams() << " ";
    lineBuf << ci->comment << "\n";
    auto line = lineBuf.str();

    if ((line.length() >= (size_t)opt->PgWidth - 2))
    {
        line.erase((size_t)opt->PgWidth - 3);
        line += '\n';
    }

    stdout_writer->inner->write(line);
    stdout_writer->inner->flush();
}

/* **************************************************************** *
 * Print additional data bytes in line following main line          *
 * **************************************************************** */

void printXtraBytes(std::string& data)
{
    if (!data.empty())
    {
        writer_printf(stdout_writer, xtraFmt, data.c_str());
    }
}

void printXtraBytes(const std::vector<uint16_t>& data)
{
    if (data.empty()) return;

    std::ostringstream buffer;
    for (auto word : data)
    {
        buffer << PrettyNumber<uint16_t>(word).width(4).fill('0').hex();
    }
    auto result = buffer.str();
    writer_printf(stdout_writer, xtraFmt, result.c_str());
}

void NonBoundsLbl(AddrSpaceHandle space, struct options* opt, uint32_t startPC, uint32_t endPC)
{
    if (space)
    {
        for (auto x = startPC + 1; x < endPC; x++)
        {
            auto label = labelManager.getLabel(space, x);
            if (label)
            {
                std::string name;
                if (opt->IsROF && label->global())
                {
                    name = label->nameWithColon();
                }
                else
                {
                    name = label->name();
                }

                std::ostringstream paramsBuffer;
                paramsBuffer << "*-" << (endPC - x);
                auto params = paramsBuffer.str();
                PrintDirective(name, "equ", params, label->value, label->value, opt, space);
            }
        }
    }
}

/* *************************************************** *
 * WrtEnds() - writes the "ends" command line          *
 * *************************************************** */

void WrtEnds(struct options* opt, int PCPos)
{
    BlankLine(opt);
    // CmdEnt = PCPos; /* This should always work */
    PrintDirective("", "ends", "", PCPos, PCPos, opt, nullptr);
    BlankLine(opt);
}

/* *******
 * ParseIRefs() - Parse through the Initialized Refs list for either
 *    class 'D' or 'L'.
 *    Insert appropriate labels into Label Trees and the
 *    IRef table.
 */
void ParseIRefs(AddrSpaceHandle space, struct options* opt)
{
    uint16_t rCount; /* The count for this block */
    uint32_t MSB;

    /* Get an initial reading */

    opt->Module->seekAbsolute(opt->modHeader->refTableOffset);

    MSB = ((uint32_t)opt->Module->read<uint16_t>()) << 16;
    rCount = opt->Module->read<uint16_t>();

    while (MSB || rCount) /* This will get All blocks for the Location */
    {
        while (rCount--)
        {
            struct ireflist *il, *ilpt;

            il = new ireflist();
            il->dAddr = MSB | opt->Module->read<uint16_t>();
            il->space = space;

            if (IRefs) /* First entry? */
            {
                ilpt = IRefs;

                if (il->dAddr < ilpt->dAddr)
                {
                    il->Next = ilpt;
                    ilpt->Prev = il;
                    IRefs = il;
                }
                else
                {
                    /* Find iref PRECEDING this entry */
                    while (ilpt->Next && (il->dAddr >= ilpt->Next->dAddr))
                    {
                        if ((il->dAddr == ilpt->dAddr) || (il->dAddr == ilpt->Next->dAddr))
                        {
                            delete il;
                            il = NULL;
                            break;
                        }

                        ilpt = ilpt->Next;
                    }

                    if (il)
                    {
                        if (ilpt->Next)
                        {
                            ilpt->Next->Prev = il;
                        }

                        il->Next = ilpt->Next;
                        il->Prev = ilpt;
                        ilpt->Next = il;
                    }
                }
            }
            else
            {
                IRefs = il;
            }
        }

        MSB = ((uint32_t)opt->Module->read<uint16_t>()) << 16;
        rCount = opt->Module->read<uint16_t>();
    }
}

/*
 * GetIRefs() - The mainline routine for getting the Initialized Refs.
 *    Seeks to the proper location and then calls ParseIRefs for each
 *    of 'D' and 'L'
 */
// TODO: This function is broken, and only does half of what it's supposed to.
void GetIRefs(struct options* opt)
{
    if (!opt->IsROF)
    {
        if (opt->modHeader->refTableOffset == 0) return;

        ParseIRefs(&CODE_SPACE, opt);
    }
}

static void dataprintHeader(AddrSpaceHandle space, struct options* opt)
{
    using namespace std;

    BlankLine(opt);

    std::ostringstream buffer;
    buffer << setw(5) << LinNum++ << " * ";
    buffer << SpaceKinds::getName(space->kind);
    buffer << " Data (Class \"" << space->shortcode << "\")\n";
    stdout_writer->inner->write(buffer.str());

    if (opt->asmFile)
    {
        opt->asmFile->inner->write("* ");
        opt->asmFile->inner->write(space->shortcode);
    }

    BlankLine(opt);

    std::string remoteString(space->isRemote ? "remote" : "");
    PrintDirective("", "vsect", remoteString, 0, 0, opt, nullptr);
}

// Attempt to match an ascii string within a data block.
int DoAsciiBlock(const std::string& labelName, uint32_t blockSize, AddrSpaceHandle space, struct parse_state* state)
{
    std::vector<char> buffer{};
    auto mark = state->Module->position();
    state->Module->readVec(buffer, blockSize);

    auto actualBytesUsed = DoAsciiBlock(labelName, buffer.data(), buffer.size(), space, state);
    state->Module->seekAbsolute(mark + actualBytesUsed);
    return actualBytesUsed;
}

int DoAsciiBlock(const std::string& labelName, const char* buf, size_t bufEnd, AddrSpaceHandle space,
                 struct parse_state* state)
{
    auto labelNameCopy(labelName);
    auto count = bufEnd;
    const char* ch = buf;
    int hasAscii = 0;

    // It seems improbable that a string would begin with NULL
    if (*buf < 0 || !(isprint(*buf)) && !(isspace(*buf)))
    {
        return 0;
    }

    // At least for the time being, skip any blocks < sizeof(int)
    // this may overlook some short strings, but it will avoid erroneous
    // identifying non-ascii numbers.

    if (bufEnd <= 4)
    {
        return 0;
    }

    // Ensure the entire block is ascii, and there's at least one printable
    // character. Multiple strings are allowed within the same block.

    while (count-- > state->CmdEnt)
    {
        register unsigned char c;

        c = *(ch++);

        if (!isprint(c) && !isspace(c) && c != '\0')
        {
            return 0;
        }

        if (isprint(c))
        {
            hasAscii = 1;
        }
    }

    if (!hasAscii)
    {
        return 0;
    }

    // Assume that a string _MUST_ be NULL-terminated

    if (*(--ch) != '\0')
    {
        return 0;
    }

    count = 0;
    size_t consumedThisLine = 0;
    size_t consumedByGroup = 0;
    std::string group;
    std::string paramBuffer;
    while (state->PCPos + consumedThisLine < bufEnd)
    {
        if (*buf == '\"')
        {
            group += "'\"'";
            consumedByGroup = 1;
            buf++;
        }
        else if (isprint((unsigned char)*buf))
        {
            // Compute how many characters we can use for this group.
            size_t maxGroupLen;
            if (consumedThisLine == 0)
            {
                // We can use the entire line, minus the two quotes.
                maxGroupLen = MAX_ASCII_LINE_LEN - 2;
            }
            else if (paramBuffer.size() > MAX_ASCII_LINE_LEN - 4)
            {
                // Need at least 4 characters to do anything meaningful
                // (comma, quote, print character, quote) so we must force
                // a new line.
                maxGroupLen = MAX_ASCII_LINE_LEN - 2;
            }
            else
            {
                maxGroupLen = MAX_ASCII_LINE_LEN - 3 - paramBuffer.size();
            }

            group += "\"";
            consumedByGroup = 0;
            while (isprint((unsigned char)*buf) && *buf != '\"' && consumedByGroup < maxGroupLen)
            {
                group += *buf;
                buf++;
                consumedByGroup++;

                // Note: we have already checked that the string is null-terminated,
                // so the block cannot end in the middle of a group of printable
                // characters. Therefore we don't need to check `PCPos + consumedThisLine < bufEnd`
                // during this loop.
            }
            group += '\"';
        }
        else
        {
            //snprintf(group, 10, "$%d", (unsigned char)*buf);
            group += '$';
            group += std::to_string(static_cast<uint8_t>(*buf));
            consumedByGroup = 1;
            buf++;
        }

        // Special case: if this is the first group this line, always append it,
        // without a comma.
        if (consumedThisLine == 0)
        {
            paramBuffer = group;
            consumedThisLine = consumedByGroup;
        }
        // Check if the group fits, accounting for a comma with +1.
        else if (paramBuffer.size() + 1 + group.size() <= MAX_ASCII_LINE_LEN)
        {
            paramBuffer += ",";
            paramBuffer += group;
            consumedThisLine += consumedByGroup;
        }
        else
        {
            // Output the line first.
            count += consumedThisLine;
            state->PCPos += (uint32_t)consumedThisLine;
            PrintDirective(labelNameCopy, "dc.b", paramBuffer, state->CmdEnt, state->PCPos, state->opt, space);
            labelNameCopy.clear();
            state->CmdEnt = state->PCPos;

            // Then copy the whole group to the start of the next line.
            paramBuffer.clear();
            paramBuffer += group;
            consumedThisLine = consumedByGroup;
        }
        group.clear();
    }

    // Output whatever is leftover.
    if (!paramBuffer.empty())
    {
        count += consumedThisLine;
        state->PCPos += (uint32_t)consumedThisLine;
        PrintDirective(labelNameCopy, "dc.b", paramBuffer, state->CmdEnt, state->PCPos, state->opt, space);
        labelNameCopy.clear();
        state->CmdEnt = state->PCPos;
    }

    return (uint32_t)count;
}

static void ListInitWithHeader(refmap* refsList, AddrSpaceHandle space, struct parse_state* state)
{
    struct cmd_items Ci;
    const char* what = "* Initialized Data Definitions";

    if (state->Module->size() == 0) return;

    uint32_t endAddress = (uint32_t)(state->PCPos + state->Module->size());

    BlankLine(state->opt);
    writer_printf(stdout_writer, "%5d %s\n", LinNum++, what);
    if (state->opt->asmFile)
    {
        writer_printf(state->opt->asmFile, "%s\n", what);
    }
    BlankLine(state->opt);

    ListInit(refsList, space, state);
}

/*
 * Moves initialized data into the listing. Really a setup routine.
 * Passed : (1) nl - Ptr to proper nlist, positioned at the first
 *                    element to be listed
 *          (2) mycount - count of elements in this sect.
 *          (3) class   - Label Class letter
 */
void ListInit(refmap* refsList, AddrSpaceHandle space, struct parse_state* state)
{
    if (state->Module->size() == 0) return;

    LabelCategory& category = labelManager.getCategory(space);
    uint32_t endAddress = (uint32_t)(state->PCPos + state->Module->size());

    std::vector<uint32_t> blockEnds;
    auto totalSize = category.size() + (refsList ? refsList->size() : 0);
    blockEnds.reserve(totalSize);
    if (refsList)
    {
        for (const auto& entry : *refsList)
        {
            blockEnds.push_back(entry.first);
        }
    }
    for (auto label : category)
    {
        blockEnds.push_back(label->address());
    }

    std::sort(blockEnds.begin(), blockEnds.end());

    while (state->Module->size() != 0)
    {
        uint32_t blkEnd;

        // ...or use the next ref as the end of the data block, whichever happens first.
        // Use PC+1 to avoid a block size of 0.
        auto nextRef = std::upper_bound(blockEnds.cbegin(), blockEnds.cend(), state->PCPos + 1);
        if (nextRef != blockEnds.cend())
        {
            blkEnd = std::min(*nextRef, endAddress);
        }
        else
        {
            blkEnd = endAddress;
        }

        DataDoBlock(refsList, blkEnd, space, state);
    }
}

/* *************************************************** *
 * ROFDataPrint() - Mainline routine to list data defs *
 *          for ROF's                                  *
 * *************************************************** */

void ROFDataPrint(struct options* opt)
{

    if (opt->ROFHd->statstorage)
    {
        dataprintHeader(&UNINIT_DATA_SPACE, opt);

        parse_state state;
        state.Module = opt->Module.get();
        state.opt = opt;
        state.Pass = 2;

        ListUninitData(opt->ROFHd->statstorage, &UNINIT_DATA_SPACE, opt);
        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
    }

    if (opt->ROFHd->combinedDataSize)
    {
        dataprintHeader(&INIT_DATA_SPACE, opt);

        parse_state state;
        state.Module = opt->ROFHd->initDataStream.get();
        state.opt = opt;
        state.Pass = 2;
        state.Module->reset();
        ListInit(&refManager.refs_idata, &INIT_DATA_SPACE, &state);

        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
    }

    if (opt->ROFHd->remoteStaticDataSize)
    {
        dataprintHeader(&UNINIT_REMOTE_SPACE, opt);

        parse_state state;
        state.Module = opt->Module.get();
        state.opt = opt;
        state.Pass = 2;

        ListUninitData(opt->ROFHd->remoteStaticDataSize, &UNINIT_REMOTE_SPACE, opt);
        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
    }

    if (opt->ROFHd->remoteCombinedDataSize)
    {
        dataprintHeader(&INIT_REMOTE_SPACE, opt);

        parse_state state;
        state.Module = opt->ROFHd->initRemoteDataStream.get();
        state.opt = opt;
        state.Pass = 2;
        state.Module->reset();
        ListInit(&refManager.refs_iremote, &INIT_REMOTE_SPACE, &state);
        // TODO: Remove extra blank line.
        BlankLine(opt);
        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
    }
}

/* ************
 * OS9DataPrint()	Mainline routine to list data defs
 *
 */

void OS9DataPrint(struct options* opt)
{
    const char* what = "* OS9 data area definitions";
    struct cmd_items Ci;
    size_t filePos = opt->Module->position();

    if (opt->modHeader->memorySize == 0)
    {
        return;
    }

    // Print the vsect header
    {
        BlankLine(opt);
        writer_printf(stdout_writer, "%5d %22s%s\n", LinNum++, "", what);
        if (opt->asmFile)
        {
            writer_printf(opt->asmFile, "%s\n", what);
        }
        BlankLine(opt);
        PrintDirective("", "vsect", std::string(), 0, 0, opt, nullptr);
    }

    // Print uninit data.
    ListUninitData(opt->modHeader->uninitDataSize, &UNINIT_DATA_SPACE, opt);

    // Print init data.
    parse_state state;
    state.opt = opt;
    state.Pass = 2;
    opt->Module->seekAbsolute((size_t)opt->modHeader->initDataHeaderOffset + 8);
    auto initDataStream = std::make_unique<BigEndianStream>(opt->Module->fork(opt->modHeader->initDataSize));
    state.Module = initDataStream.get();
    state.PCPos = opt->modHeader->uninitDataSize;
    state.CmdEnt = state.PCPos;
    ListInitWithHeader(nullptr, &INIT_DATA_SPACE, &state);

    // Print the vsect footer.
    WrtEnds(opt, state.CmdEnt);

    // Restore the stream to its original location
    // fseek(opt->ModFP, filePos, SEEK_SET);
    opt->Module->seekAbsolute(filePos);
}

// Lists the uninit data as a assemblerVersion of labels with ds.b directives. The algorithm
// is greedy, and assumes all space between labels is used by a label (no wasted
// bytes).
void ListUninitData(uint32_t maxAddress, AddrSpaceHandle space, struct options* opt)
{
    // Nothing to print.
    if (maxAddress == 0) return;

    LabelCategory& category = labelManager.getCategory(space);

    // If there are no labels, just print the whole thing as one directive.
    if (category.size() == 0)
    {
        PrintDirective("", "ds.b", FormattedNumber(maxAddress), 0, 0, opt, space);
        return;
    }

    // If the first entry is not 0, print an initial ds.b directive without a
    // corresponding label.
    if (category.getFirst()->value != 0)
    {
        auto first = category.getFirst();
        PrintDirective("", "ds.b", FormattedNumber(first->value), 0, first->value, opt, space);
    }

    // Iterate through all the other labels.
    for (auto it = category.cbegin(); it != category.cend(); it++)
    {
        // Don't print labels that are outside the maximum range of the address space.
        // These should have already been printed as equates.
        if ((*it)->address() >= maxAddress)
        {
            // Use "continue" instead of "break" because the labels might not be sorted.
            continue;
        }

        auto next = it + 1;

        uint32_t datasize;
        if (next != category.cend() && (*next)->address() < maxAddress)
        {
            datasize = (*next)->address() - (*it)->address();
        }
        else
        {
            datasize = maxAddress - (*it)->address();
        }

        std::string labelName;
        if (opt->IsROF && (*it)->global())
        {
            labelName = (*it)->nameWithColon();
        }
        else
        {
            labelName = (*it)->name();
        }
        PrintDirective(labelName, "ds.b", FormattedNumber(datasize), (*it)->value, (*it)->value, opt, space);
    }
}

/* ************************************************** *
 * WrtEquates() - Print out label defs                *
 * Passed: stdflg - 1 for std labels, 0 for externals *
 * ************************************************** */

void WrtEquates(bool pritnStdLabels, struct options* opt)
{
    const char* claspt = "_!^ABCDEFGHIJKMNOPQRSTUVWXYZ;";
    const char* curnt = claspt;
    const char* syshd = "* OS-9 system function equates\n";
    const char* aschd = "* ASCII control character equates\n";
    static const char* genhd[2] = {"* Class %s external label equates\n", "* Class %s standard named label equates\n"};
    curnt = claspt;

    if (!pritnStdLabels) /* print ! and ^ only on std cClass pass */
    {
        curnt += 2;
    }

    int minval;

    ClsHd = "%5d %21s";
    LabelCategory& category = labelManager.getCategory(&EQUATE_SPACE);

    if (category.size() > 0)
    {
        ClsHd += genhd[pritnStdLabels ? 1 : 0];
        SrcHd = genhd[pritnStdLabels ? 1 : 0];

        HadWrote = 0; /* flag header not written */

        /* Determine minimum value for printing *
         * minval will be the first value to    *
         * print                                */

        minval = 0; /* Default to "print all" */

        TellLabels(category, pritnStdLabels, &EQUATE_SPACE, minval, opt);
    }
}

/* TellLabels(me) - Print out the labels for cClass in "me" array */

static void TellLabels(LabelCategory& category, bool printStdLabels, AddrSpaceHandle space, int minval, struct options* opt)
{
    for (const auto me : category)
    {
        if (printStdLabels == me->stdName())
        {
            /* Don't print real OS9 Data variables here */

            if (me->value >= minval)
            {
                if (!HadWrote)
                {
                    BlankLine(opt);

                    writer_printf(stdout_writer, ClsHd.c_str(), LinNum++, "", space->name.c_str());
                    

                    if (opt->asmFile)
                    {
                        writer_printf(opt->asmFile, SrcHd, space->name.c_str());
                    }

                    HadWrote = 1;
                    BlankLine(opt);
                }

                std::string labelName;
                if (opt->IsROF && me->global())
                {
                    labelName = me->nameWithColon();
                }
                else
                {
                    labelName = me->name();
                }

                auto formatted = FormattedNumber(me->value, OperandSize::Byte, &LITERAL_HEX_SPACE);
                PrintDirective(labelName, "equ", formatted, me->value, me->value, opt, nullptr);
            }
        }
    }
}
