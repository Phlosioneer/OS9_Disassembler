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
static void PrintFormatted(const char* pfmt, struct cmd_items* ci, struct options* opt, int CmdEnt);
static void NonBoundsLbl(AddrSpaceHandle space, struct options* opt, uint32_t startPC, uint32_t endPC);
static void TellLabels(Label* me, int flg, AddrSpaceHandle space, int minval, struct options* opt);

const char pseudcmd[80] = "%5d  %05x %04x %-10s %-6s %-10s %s\n";
const char realcmd[80] = "%5d  %05x %04x %-9s %-10s %-6s %-10s %s\n";
static const char* xtraFmt = "             %s\n";

static int InProg;       /* Flag that we're in main program, so that it won't
                            munge the label name */
static char ClsHd[100];  /* header string for label equates */
static char FmtBuf[200]; /* Buffer to store formatted string */
static int HadWrote;     /* flag that header has been written */
static char* SrcHd;      /* ptr for header for source file */
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

    int lang = opt->modHeader ? opt->modHeader->lang : opt->ROFHd->lang;
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
        psectParams.push_back(opt->ROFHd->rname);
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

    int stack = opt->modHeader ? opt->modHeader->stackSize : opt->ROFHd->stksz;
    psectParams.push_back(FormattedNumber(stack).str());

    int execOffset = opt->modHeader ? opt->modHeader->execOffset : opt->ROFHd->code_begin;
    auto execOffsetLabel = labelManager->getCategory(&CODE_SPACE)->get(execOffset);
    if (execOffsetLabel)
    {
        psectParams.push_back(execOffsetLabel->name());
    }
    else
    {
        psectParams.push_back(FormattedNumber(execOffset).str());
    }

    uint32_t exceptOffset = opt->modHeader ? opt->modHeader->exceptionOffset : opt->ROFHd->utrap;
    if (exceptOffset != (uint32_t)-1)
    {
        auto exceptOffsetLabel = labelManager->getCategory(&CODE_SPACE)->get(exceptOffset);
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

static void OutputLine(const char* pfmt, struct cmd_items* ci, struct options* opt, uint32_t CmdEnt, AddrSpaceHandle space)
{
    Label* nl;

    if (InProg && ci->lblname.empty() && space)
    {
        nl = findlbl(space, CmdEnt);
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

    PrintFormatted(pfmt, ci, opt, CmdEnt);

    if (opt->asmFile)
    {
        std::ostringstream line;
        line << ci->lblname << ' ' << ci->mnem << ' ' << ci->renderNewParams();

        // writer_printf(opt->asmFile, "%s %s %s", ci->lblname.c_str(), ci->mnem, ci->params);

        if (ci->comment && strlen(ci->comment))
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
    if (opt->IsUnformatted)
    {
        return;
    }

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

void PrintLine(const char* pfmt, struct cmd_items* ci, AddrSpaceHandle space, uint32_t CmdEnt, uint32_t PCPos,
               options* opt)
{
    auto prevInProg = InProg;
    if (space && !(*space == CODE_SPACE))
    {
        InProg = 0;
    }
    OutputLine(pfmt, ci, opt, CmdEnt, space);
    PrintCleanup(CmdEnt);
    NonBoundsLbl(space, opt, CmdEnt, PCPos); /*Check for non-boundary labels */
    InProg = prevInProg;
}

void PrintDirective(const std::string& label, const char* directive, FormattedNumber value, uint32_t CmdEnt, uint32_t PCPos,
                    struct options* opt, AddrSpaceHandle space)
{
    // This is a hacky way to do this.

    struct cmd_items instr;
    if (value.size == OperandSize::Long)
    {
        uint16_t high = (value.number >> 16) & 0xFFFF;
        uint16_t low = value.number & 0xFFFF;
        instr.cmd_wrd = high;
        instr.code[0] = high;
        instr.code[1] = low;
        instr.wcount = 2;
    }
    else
    {
        instr.cmd_wrd = truncateUnsignedToOperandSize(value.size, value.number);
        instr.code[0] = instr.cmd_wrd;
        instr.wcount = 1;
    }

    instr.lblname = label;
    strcpy(instr.mnem, directive);
    instr.setSource(LiteralParam(value, false));
    PrintLine(pseudcmd, &instr, space, CmdEnt, PCPos, opt);
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

    // This is a hacky way to do this.
    auto paramString = paramBuffer.str();
    struct cmd_items instr;
    instr.lblname = label;
    strcpy(instr.mnem, directive);
    instr.setSource(LiteralParam(paramString, false));
    PrintLine(pseudcmd, &instr, space, CmdEnt, PCPos, opt);
}

void PrintDirective(const std::string& label, const char* directive, const std::string& param, uint32_t CmdEnt,
                    uint32_t PCPos,
                    struct options* opt, AddrSpaceHandle space)
{
    // This is a hacky way to do this.

    struct cmd_items instr;
    instr.lblname = label;
    strcpy(instr.mnem, directive);
    instr.setSource(LiteralParam(param, false));
    PrintLine(pseudcmd, &instr, space, CmdEnt, PCPos, opt);
}

void PrintDirective(const std::string& label, const char* directive, const std::string& param, uint32_t CmdEnt,
                    uint32_t PCPos,
                    struct options* opt, const std::vector<uint16_t>& rawData, AddrSpaceHandle space)
{
    // This is a hacky way to do this.

    struct cmd_items instr;
    instr.lblname = label;
    strcpy(instr.mnem, directive);
    instr.setSource(LiteralParam(param, false));

    if (rawData.size() >= CODE_LEN) throw std::runtime_error("Too much data for directive!");
    for (size_t i = 0; i < rawData.size(); i++)
    {
        instr.code[i] = rawData[i];
    }
    instr.wcount = rawData.size();

    if (!rawData.empty())
    {
        instr.cmd_wrd = rawData[0];
    }

    PrintLine(pseudcmd, &instr, space, CmdEnt, PCPos, opt);
}

static void PrintFormatted(const char* pfmt, struct cmd_items* ci, struct options* opt, int CmdEnt)
{
    int _linlen;

    /* make sure any non-initialized fields don't create Segfault */

    /*if ( ! ci->mnem)        strcpy(ci->mnem, "");
    if ( ! ci->params)     strcpy(ci->params, "");*/
    if (!ci->comment) ci->comment = "";

    auto params = ci->renderNewParams();
    if (pfmt == pseudcmd)
    {
        if (opt->IsUnformatted)
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, &(pfmt[3]), CmdEnt, ci->cmd_wrd, ci->lblname.c_str(),
                               ci->mnem, params.c_str(), ci->comment);
        }
        else
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, pfmt, LinNum, CmdEnt, ci->cmd_wrd, ci->lblname.c_str(),
                               ci->mnem, params.c_str(), ci->comment);
        }
    }
    else
    {
        if (opt->IsUnformatted)
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, &(pfmt[3]), CmdEnt, ci->cmd_wrd, ci->lblname.c_str(),
                               ci->mnem, params.c_str(), ci->comment);
        }
        else
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, pfmt, LinNum, CmdEnt, ci->cmd_wrd, ci->lblname.c_str(),
                               ci->mnem, params.c_str(), ci->comment);
        }
    }

    if ((_linlen >= opt->PgWidth - 2) || (_linlen < 0))
    {
        FmtBuf[opt->PgWidth - 3] = '\n';
        FmtBuf[opt->PgWidth - 2] = '\0';
    }

    writer_printf(stdout_writer, "%s", FmtBuf);
    writer_flush(stdout_writer);
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

void NonBoundsLbl(AddrSpaceHandle space, struct options* opt, uint32_t startPC, uint32_t endPC)
{
    if (space)
    {
        for (auto x = startPC + 1; x < endPC; x++)
        {
            auto label = findlbl(space, x);
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

static void dataprintHeader(const char* hdr, AddrSpaceHandle space, int isRemote, struct options* opt)
{
    struct cmd_items Ci;

    BlankLine(opt);

    if (opt->IsUnformatted)
    {
        writer_printf(stdout_writer, hdr, space->shortcode.c_str());
        ++LinNum;
    }
    else
    {
        char f_fmt[100];

        sprintf(f_fmt, "%%5d %s", hdr);
        writer_printf(stdout_writer, f_fmt, LinNum++, space->shortcode.c_str());
    }

    if (opt->asmFile)
    {
        writer_printf(opt->asmFile, "* %s", space->shortcode.c_str());
    }

    BlankLine(opt);

    strcpy(Ci.mnem, "vsect");
    if (isRemote)
    {
        Ci.setSource(LiteralParam("remote"));
    }
    Ci.cmd_wrd = 0;
    Ci.comment = "";
    PrintLine(pseudcmd, &Ci, &INIT_DATA_SPACE, 0, 0, opt);
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
    char group[MAX_ASCII_LINE_LEN + 5];
    std::string paramBuffer;
    while (state->PCPos + consumedThisLine < bufEnd)
    {
        // The way this is written is kinda odd for C, but it translates well
        // into C++
        group[0] = '\0';
        if (*buf == '\"')
        {
            strcpy(group, "'\"'");
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

            strcpy(group, "\"");
            consumedByGroup = 0;
            while (isprint((unsigned char)*buf) && *buf != '\"' && consumedByGroup < maxGroupLen)
            {
                group[consumedByGroup + 1] = *buf;
                buf++;
                consumedByGroup++;

                // Note: we have already checked that the string is null-terminated,
                // so the block cannot end in the middle of a group of printable
                // characters. Therefore we don't need to check `PCPos + consumedThisLine < bufEnd`
                // during this loop.
            }
            group[consumedByGroup + 1] = '\"';
            group[consumedByGroup + 2] = '\0';
        }
        else
        {
            snprintf(group, 10, "$%d", (unsigned char)*buf);
            group[11] = '\0';
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
        else if (paramBuffer.size() + 1 + strlen(group) <= MAX_ASCII_LINE_LEN)
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
            // paramBuffer.clear();
            paramBuffer = group;
            consumedThisLine = consumedByGroup;
        }
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
    if (state->opt->IsUnformatted)
    {
        writer_printf(stdout_writer, " %s\n", what);
        ++LinNum;
    }
    else
    {
        writer_printf(stdout_writer, "%5d %s\n", LinNum++, what);
    }
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

    auto category = labelManager->getCategory(space);
    uint32_t endAddress = (uint32_t)(state->PCPos + state->Module->size());

    std::vector<uint32_t> blockEnds;
    auto totalSize = category->size() + (refsList ? refsList->size() : 0);
    blockEnds.reserve(totalSize);
    if (refsList)
    {
        for (const auto& entry : *refsList)
        {
            blockEnds.push_back(entry.first);
        }
    }
    for (auto it = category->begin(); it != category->end(); it++)
    {
        blockEnds.push_back((*it)->address());
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
    /*char dattmp[5];*/
    const char* udat = "* Uninitialized Data (Class \"%s\")\n";
    // TODO: Change this to add a space. The reference exe will also have to be
    // patched.
    const char* idat = "* Initialized Data (Class\"%s\")\n";

    InProg = 0;
    if (opt->ROFHd->statstorage)
    {
        parse_state state;
        state.Module = opt->Module.get();
        state.opt = opt;
        state.Pass = 2;

        dataprintHeader(udat, &UNINIT_DATA_SPACE, FALSE, opt);

        /*first, if first entry is not D000, rmb bytes up to first */

        ListUninitData(opt->ROFHd->statstorage, &UNINIT_DATA_SPACE, opt);
        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
    }

    if (opt->ROFHd->idatsz)
    {
        dataprintHeader(idat, &INIT_DATA_SPACE, FALSE, opt);

        parse_state state;
        state.Module = opt->ROFHd->initDataStream.get();
        state.opt = opt;
        state.Pass = 2;
        state.Module->reset();
        ListInit(&refs_idata, &INIT_DATA_SPACE, &state);

        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
        /*ListInitWithHeader (srch, ROFHd.idatsz, '_');*/
        /*ListInit (dta, ROFHd.idatsz, '_');*/
    }

    if (opt->ROFHd->remotestatsiz)
    {
        parse_state state;
        state.Module = opt->Module.get();
        state.opt = opt;
        state.Pass = 2;

        dataprintHeader(udat, &UNINIT_REMOTE_SPACE, TRUE, opt);

        /*first, if first entry is not D000, rmb bytes up to first */

        ListUninitData(opt->ROFHd->remotestatsiz, &UNINIT_REMOTE_SPACE, opt);
        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
    }

    if (opt->ROFHd->remoteidatsiz)
    {

        int size = opt->ROFHd->remoteidatsiz;
        dataprintHeader(idat, &INIT_REMOTE_SPACE, TRUE, opt);

        parse_state state;
        state.Module = opt->ROFHd->initRemoteDataStream.get();
        state.opt = opt;
        state.Pass = 2;
        state.Module->reset();
        ListInit(&refs_iremote, &INIT_REMOTE_SPACE, &state);
        BlankLine(opt);
        /*ListInitWithHeader (srch, ROFHd.idatsz, 'H');*/
        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
        /*ListInit (dta, ROFHd.idatsz, 'H');*/
    }

    InProg = 1;
    return;
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

    InProg = 0; /* Stop looking for Inline program labels to substitute */

    if (opt->modHeader->memorySize == 0)
    {
        return;
    }

    // Print the vsect header
    {
        BlankLine(opt);
        if (opt->IsUnformatted)
        {
            writer_printf(stdout_writer, " %22s%s\n", "", what);
            ++LinNum;
        }
        else
        {
            writer_printf(stdout_writer, "%5d %22s%s\n", LinNum++, "", what);
        }
        if (opt->asmFile)
        {
            writer_printf(opt->asmFile, "%s\n", what);
        }
        BlankLine(opt);

        strcpy(Ci.mnem, "vsect");
        Ci.cmd_wrd = 0;
        Ci.comment = "";
        PrintLine(pseudcmd, &Ci, &UNINIT_DATA_SPACE, 0, 0, opt);
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
    {
        strcpy(Ci.mnem, "ends");
        Ci.source = nullptr;
        Ci.cmd_wrd = 0;
        Ci.comment = "";
        PrintLine(pseudcmd, &Ci, &INIT_DATA_SPACE, state.CmdEnt, state.CmdEnt, opt);
        BlankLine(opt);
    }

    InProg = 1;
    // Restore the stream to its original location
    // fseek(opt->ModFP, filePos, SEEK_SET);
    opt->Module->seekAbsolute(filePos);
}

// Lists the uninit data as a series of labels with ds.b directives. The algorithm
// is greedy, and assumes all space between labels is used by a label (no wasted
// bytes).
void ListUninitData(uint32_t maxAddress, AddrSpaceHandle space, struct options* opt)
{
    // Nothing to print.
    if (maxAddress == 0) return;

    auto category = labelManager->getCategory(space);

    // If there are no labels, just print the whole thing as one directive.
    if (category->size() == 0)
    {
        PrintDirective("", "ds.b", FormattedNumber(maxAddress), 0, 0, opt, space);
        return;
    }

    // If the first entry is not 0, print an initial ds.b directive without a
    // corresponding label.
    if (category->getFirst()->value != 0)
    {
        auto first = category->getFirst();
        PrintDirective("", "ds.b", FormattedNumber(first->value), 0, first->value, opt, space);
    }

    // Iterate through all the other labels.
    for (auto it = category->begin(); it != category->end(); it++)
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
        if (next != category->end() && (*next)->address() < maxAddress)
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

void WrtEquates(int stdflg, struct options* opt)
{
    char *claspt = "_!^ABCDEFGHIJKMNOPQRSTUVWXYZ;", *curnt = claspt, *syshd = "* OS-9 system function equates\n",
         *aschd = "* ASCII control character equates\n";
    static char* genhd[2] = {"* Class %s external label equates\n", "* Class %s standard named label equates\n"};
    register int flg; /* local working flg - clone of stdflg */
    Label* me;

    InProg = 0;
    curnt = claspt;

    if (!stdflg) /* print ! and ^ only on std cClass pass */
    {
        curnt += 2;
    }

    int minval;

    flg = stdflg;
    strcpy(ClsHd, "%5d %21s");
    auto category = labelManager->getCategory(&EQUATE_SPACE);
    me = category ? category->getFirst() : NULL;

    if (me)
    {
        /* For OS9, we only want external labels this pass */

        /* Don't write vsect data for ROF's */

        /*
        if ((opt->IsROF) && stdflg && strchr("BDGH", NowClass))
        {
            continue;
        }

        switch (NowClass)
        {
        case '!':
            strcat(ClsHd, syshd);
            SrcHd = syshd;
            flg = -1;
            break;
        case '^':
            strcat(ClsHd, aschd);
            SrcHd = aschd;
            flg = -1;
            break;
        default:
        */
        strcat(ClsHd, genhd[flg]);
        SrcHd = genhd[flg];
        //}

        HadWrote = 0; /* flag header not written */

        /* Determine minimum value for printing *
         * minval will be the first value to    *
         * print                                */

        minval = 0; /* Default to "print all" */

        // Added OR to satisfy VS null checker.
        if (opt->IsROF || !opt->modHeader)
        {
            /*minval = rof_datasize (NowClass);*/

            /* If this cClass has any data, we want to exclude
             * printing the last entry.
             * Otherwise, if no real entries, we want to print
             * element "0"
             */

            /*if (minval)
            {
                ++minval;
            }*/
        }
        else
        {
            /*
            if (NowClass == 'D')
            {
                minval = opt->modHeader->memorySize + 1;
            }
            else
            {
                if (NowClass == 'L')
                {
                    minval = opt->modHeader->size + 1;
                }
            }
            */
        }

        TellLabels(me, flg, &EQUATE_SPACE, minval, opt);
    }

    InProg = 1;
}

/* TellLabels(me) - Print out the labels for cClass in "me" array */

static void TellLabels(Label* me, int flg, AddrSpaceHandle space, int minval, struct options* opt)
{

    while (me)
    {
        if ((flg < 0) || flg == (int)me->stdName())
        {
            /* Don't print real OS9 Data variables here */

            if (me->value >= minval)
            {
                if (!HadWrote)
                {
                    BlankLine(opt);

                    if (opt->IsUnformatted)
                    {
                        writer_printf(stdout_writer, &(ClsHd[3]), "", space->name.c_str());
                        ++LinNum;
                    }
                    else
                    {
                        writer_printf(stdout_writer, ClsHd, LinNum++, "", space->name.c_str());
                    }

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

        me = label_getNext(me);
    }
}
