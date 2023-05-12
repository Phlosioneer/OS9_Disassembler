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

#include "dprint.h"

#include <algorithm>
#include <ctype.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <vector>

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

#define CNULL '\0'
struct ireflist* IRefs = NULL;
static void BlankLine(struct options* opt);
static void PrintFormatted(const char* pfmt, struct cmd_items* ci, struct options* opt, int CmdEnt);
static void NonBoundsLbl(AddrSpaceHandle space, struct options* opt, int CmdEnt);
static void TellLabels(Label* me, int flg, AddrSpaceHandle space, int minval, struct options* opt);

const char pseudcmd[80] = "%5d  %05x %04x %-10s %-6s %-10s %s\n";
const char realcmd[80] = "%5d  %05x %04x %-9s %-10s %-6s %-10s %s\n";
static const char* xtraFmt = "             %s\n";

int PrevEnt = 0;         /* Previous CmdEnt - to print non-boundary labels */
static int InProg;       /* Flag that we're in main program, so that it won't
                            munge the label name */
static char ClsHd[100];  /* header string for label equates */
static char FmtBuf[200]; /* Buffer to store formatted string */
static int HadWrote;     /* flag that header has been written */
static char* SrcHd;      /* ptr for header for source file */
static char* IBuf;       /* Pointer to buffer containing the Init Data values */
int LinNum;

struct modnam ModTyps[] = {{"Prgrm", 1},  {"Sbrtn", 2},  {"Multi", 3},  {"Data", 4},   {"CSDData", 5}, {"TrapLib", 11},
                           {"Systm", 12}, {"FlMgr", 13}, {"Drivr", 14}, {"Devic", 15}, {"", 0}};

struct modnam ModLangs[] = {{"Objct", 1},   {"ICode", 2},    {"PCode", 3}, {"CCode", 4},
                            {"CblCode", 5}, {"FrtnCode", 6}, {"", 0}};

struct modnam ModAtts[] = {{"SupStat", 0x20}, {"Ghost", 0x40}, {"ReEnt", 0x80}, {"", 0}};

/* **********
 * PrintPsect() - Set up the Psect for printout
 *
 */

void PrintPsect(struct options* opt)
{
    char* ProgType = NULL;
    char* ProgLang = NULL;
    char ProgAtts[50];
    /*char *StackAddL;*/
    int c;
    struct cmd_items Ci;
    int pgWdthSave;
    std::ostringstream psectParamBuffer;

    Ci.comment = "";
    strcpy(Ci.mnem, "set");
    BlankLine(opt);

    /* Module name */
    if (!opt->psectName.empty())
    {
        psectParamBuffer << opt->psectName;
    }
    else if (strrchr(opt->ModFile.c_str(), PATHSEP))
    {
        psectParamBuffer << strrchr(opt->ModFile.c_str(), PATHSEP) + 1;
    }
    else
    {
        psectParamBuffer << opt->ModFile;
    }

    psectParamBuffer << "_a";

    /* Type/Language */
    InProg = 0; /* Inhibit Label Lookup */
    int type = opt->modHeader ? opt->modHeader->type : 0;
    ProgType = modnam_find(ModTyps, (unsigned char)type)->name;
    Ci.cmd_wrd = type;
    Ci.lblname = ProgType;
    std::ostringstream paramBuffer;
    paramBuffer << '$' << PrettyNumber<uint32_t>(type).hex();
    auto params = paramBuffer.str();
    strcpy(Ci.params, params.c_str());
    PrintLine(pseudcmd, &Ci, CNULL, 0, opt);
    /*hdrvals[0] = M_Type;*/

    int lang = opt->modHeader ? opt->modHeader->lang : 0;
    ProgLang = modnam_find(ModLangs, (unsigned char)lang)->name;
    Ci.lblname = ProgLang;
    Ci.cmd_wrd = lang;
    paramBuffer = {};
    paramBuffer << '$' << PrettyNumber<uint32_t>(lang).hex();
    params = paramBuffer.str();
    strcpy(Ci.params, params.c_str());
    PrintLine(pseudcmd, &Ci, CNULL, 0, opt);
    /*hdrvals[1] = M_Lang;*/

    psectParamBuffer << ",(" << ProgType << "<<8)|" << ProgLang;

    /* Att/Rev */
    ProgAtts[0] = '\0';

    for (c = 0; ModAtts[c].val; c++)
    {
        if (opt->modHeader && (opt->modHeader->attributes & 0xff) & ModAtts[c].val)
        {
            if (strlen(ProgAtts))
            {
                strcat(ProgAtts, "+");
                strcat(ProgAtts, ModAtts[c].name);
            }
            else
            {
                strcpy(ProgAtts, ModAtts[c].name);
            }

            Ci.lblname = ModAtts[c].name;
            Ci.cmd_wrd = ModAtts[c].val;
            sprintf(Ci.params, "$%02x", ModAtts[c].val);
            PrintLine(pseudcmd, &Ci, CNULL, 0, opt);
        }
    }

    int revision = opt->modHeader ? opt->modHeader->revision : 0;
    int edition = opt->modHeader ? opt->modHeader->edition : 0;
    int execOffset = opt->modHeader ? opt->modHeader->execOffset : 0;
    psectParamBuffer << ",(" << ProgAtts << "<<8)|" << revision;
    psectParamBuffer << ',' << edition;
    psectParamBuffer << ",0"; /* For the time being, don't add any stack */
    // DELETEME: code_space confirmed correct here.
    psectParamBuffer << ',' << findlbl(&CODE_SPACE, execOffset)->name();

    if (opt->modHeader && opt->modHeader->exceptionOffset)
    {
        // DELETEME: code_space confirmed correct here.
        Label* excep = findlbl(&CODE_SPACE, opt->modHeader->exceptionOffset);
        psectParamBuffer << ',' << excep->name();
    }

    params = psectParamBuffer.str();
    strcpy(Ci.params, params.c_str());
    strcpy(Ci.mnem, "psect");
    Ci.lblname.clear();
    /* Be sure to have enough space to write psect */
    pgWdthSave = opt->PgWidth;
    opt->PgWidth = 200;
    BlankLine(opt);
    PrintLine(pseudcmd, &Ci, CNULL, 0, opt);
    BlankLine(opt);
    opt->PgWidth = pgWdthSave;
    InProg = 1;
}

/* ************************************** *
 * OutputLine () - does the actual output *
 * to the listing and/or source file      *
 * ************************************** */

static void OutputLine(const char* pfmt, struct cmd_items* ci, struct options* opt, int CmdEnt)
{
    Label* nl;

    if (InProg)
    {
        // DELETEME: code_space confirmed correct here. As long as InProg is true, we
        // are in code space.
        nl = findlbl(&CODE_SPACE, CmdEnt);
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
        line << ci->lblname << ' ' << ci->mnem << ' ' << ci->params;

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
    PrevEnt = CmdEnt;

    /*CmdLen = 0;*/
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

void PrintLine(const char* pfmt, struct cmd_items* ci, AddrSpaceHandle space, int CmdEnt, options* opt)
{
    NonBoundsLbl(space, opt, CmdEnt); /*Check for non-boundary labels */

    OutputLine(pfmt, ci, opt, CmdEnt);

    PrintCleanup(CmdEnt);
}

static void PrintFormatted(const char* pfmt, struct cmd_items* ci, struct options* opt, int CmdEnt)
{
    int _linlen;

    /* make sure any non-initialized fields don't create Segfault */

    /*if ( ! ci->mnem)        strcpy(ci->mnem, "");
    if ( ! ci->params)     strcpy(ci->params, "");*/
    if (!ci->comment) ci->comment = "";

    if (pfmt == pseudcmd)
    {
        if (opt->IsUnformatted)
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, &(pfmt[3]), CmdEnt, ci->cmd_wrd, ci->lblname.c_str(),
                               ci->mnem, ci->params, ci->comment);
        }
        else
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, pfmt, LinNum, CmdEnt, ci->cmd_wrd, ci->lblname.c_str(),
                               ci->mnem, ci->params, ci->comment);
        }
    }
    else
    {
        if (opt->IsUnformatted)
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, &(pfmt[3]), CmdEnt, ci->cmd_wrd, ci->lblname.c_str(),
                               ci->mnem, ci->params, ci->comment);
        }
        else
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, pfmt, LinNum, CmdEnt, ci->cmd_wrd, ci->lblname.c_str(),
                               ci->mnem, ci->params, ci->comment);
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

static void NonBoundsLbl(AddrSpaceHandle space, struct options* opt, int CmdEnt)
{
    if (space)
    {
        register int x;
        struct cmd_items Ci;
        Label* nl;

        strcpy(Ci.mnem, "equ");
        Ci.comment = "";

        for (x = PrevEnt + 1; x < CmdEnt; x++)
        {
            nl = findlbl(space, x);
            if (nl)
            {

                if (opt->IsROF && nl->global())
                {
                    Ci.lblname = nl->nameWithColon();
                }
                else
                {
                    Ci.lblname = nl->name();
                }

                if (x > CmdEnt)
                {
                    sprintf(Ci.params, "*+%d", x - CmdEnt);
                }
                else
                {
                    sprintf(Ci.params, "*-%d", CmdEnt - x);
                }

                /*PrintLine (pseudcmd, &Ci, cClass, CmdEnt, PCPos);*/
                if (opt->IsUnformatted)
                {
                    writer_printf(stdout_writer, &(pseudcmd[3]), nl->myAddr, Ci.cmd_wrd, Ci.lblname.c_str(), Ci.mnem,
                                  Ci.params, "");
                }
                else
                {
                    writer_printf(stdout_writer, pseudcmd, LinNum++, nl->myAddr, Ci.cmd_wrd, Ci.lblname.c_str(),
                                  Ci.mnem, Ci.params, "");
                }

                if (opt->asmFile)
                {
                    writer_printf(opt->asmFile, "%s %s %s\n", Ci.lblname.c_str(), Ci.mnem, Ci.params);
                }
            }
        }
    }
}

/* ********************************************* *
 * ROFPsect() - writes out psect                 *
 * Passed: rof_header *rptr                         *
 * ********************************************* */
void ROFPsect(struct options* opt)
{
    Label* nl;
    struct cmd_items Ci;

    /*strcpy(Ci.instr, "");*/
    strcpy(Ci.params, "");
    strcpy(Ci.mnem, "psect");
    /*sprintf(Ci.params, "%s,$%x,$%x,%d,%d,", rptr->rname,
                                                rptr->ty_lan >> 8,
                                                rptr->ty_lan & 0xff,
                                                rptr->edition,
                                                rptr->stksz
            );
    */
    char* params = rof_header_getPsectParams(opt->ROFHd.get());
    strcpy(Ci.params, params);
    delete[] params;

    // DELETEME: code_space confirmed correct here.
    nl = findlbl(&CODE_SPACE, opt->ROFHd->code_begin);
    if (nl)
    {
        strcat(Ci.params, nl->name().c_str());
        /*OPSCAT(nl->sname);*/
    }
    else
    {
        char oc[10];

        sprintf(oc, "$%04x", opt->ROFHd->code_begin);
        strcat(Ci.params, oc);
        /*OPHCAT ((int)(rptr->modent));*/
    }

    PrevEnt = 1; /* To prevent NonBoundsLbl() output */
    InProg = 0;  /* Inhibit Label Lookup */
    PrintLine(pseudcmd, &Ci, CNULL, 0, opt);
    InProg = 1;
}

/* *************************************************** *
 * WrtEnds() - writes the "ends" command line          *
 * *************************************************** */

void WrtEnds(struct options* opt, int PCPos)
{
    struct cmd_items Ci;

    strcpy(Ci.mnem, "ends");

    BlankLine(opt);
    // CmdEnt = PCPos; /* This should always work */
    PrintFormatted(pseudcmd, &Ci, opt, PCPos);

    if (opt->asmFile)
    {
        writer_printf(opt->asmFile, "%s %s %s\n", "", "ends", "");
    }

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

        // DELETEME: code_space confirmed correct here.
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
    strcpy(Ci.params, isRemote ? "remote" : "");
    Ci.cmd_wrd = 0;
    Ci.comment = "";
    PrintLine(pseudcmd, &Ci, &INIT_DATA_SPACE, 0, opt);
}

// Attempt to match an ascii string within a data block.
int DoAsciiBlock(struct cmd_items* ci, uint32_t blockSize, AddrSpaceHandle space, struct parse_state* state)
{
    std::vector<char> buffer(blockSize);
    auto mark = state->Module->position();
    state->Module->readVec(buffer, blockSize);

    auto actualBytesUsed = DoAsciiBlock(ci, buffer.data(), buffer.size(), space, state);
    state->Module->seekAbsolute(mark + actualBytesUsed);
    return actualBytesUsed;
}

int DoAsciiBlock(struct cmd_items* ci, const char* buf, unsigned int bufEnd, AddrSpaceHandle space,
                 struct parse_state* state)
{
    register unsigned int count = bufEnd;
    register const char* ch = buf;
    int hasAscii = 0;

    // It seems improbable that a string would begin with NULL
    if (!(isprint(*buf)) && !(isspace(*buf)))
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
    unsigned int consumedThisLine = 0;
    unsigned int consumedByGroup = 0;
    char group[MAX_ASCII_LINE_LEN + 5];
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
            unsigned int maxGroupLen;
            if (consumedThisLine == 0)
            {
                // We can use the entire line, minus the two quotes.
                maxGroupLen = MAX_ASCII_LINE_LEN - 2;
            }
            else if (strlen(ci->params) > MAX_ASCII_LINE_LEN - 4)
            {
                // Need at least 4 characters to do anything meaningful
                // (comma, quote, print character, quote) so we must force
                // a new line.
                maxGroupLen = MAX_ASCII_LINE_LEN - 2;
            }
            else
            {
                maxGroupLen = MAX_ASCII_LINE_LEN - 3 - strlen(ci->params);
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
            strcpy(ci->params, group);
            consumedThisLine = consumedByGroup;
        }
        // Check if the group fits, accounting for a comma with +1.
        else if (strlen(ci->params) + 1 + strlen(group) <= MAX_ASCII_LINE_LEN)
        {
            strcat(ci->params, ",");
            strcat(ci->params, group);
            consumedThisLine += consumedByGroup;
        }
        else
        {
            // Output the line first.
            count += consumedThisLine;
            state->PCPos += consumedThisLine;
            strncpy(ci->mnem, "dc.b", MNEM_LEN);
            PrintLine(pseudcmd, ci, space, state->CmdEnt, state->opt);
            state->CmdEnt = state->PCPos;
            PrevEnt = state->PCPos;
            ci->lblname.clear();
            ci->params[0] = '\0';

            // Then copy the whole group to the start of the next line.
            strcpy(ci->params, group);
            consumedThisLine = consumedByGroup;
        }
    }

    // Output whatever is leftover.
    if (strlen(ci->params))
    {
        count += consumedThisLine;
        state->PCPos += consumedThisLine;
        strncpy(ci->mnem, "dc.b", MNEM_LEN);
        PrintLine(pseudcmd, ci, space, state->CmdEnt, state->opt);
        state->CmdEnt = state->PCPos;
        PrevEnt = state->PCPos;
        ci->lblname.clear();
        ci->params[0] = '\0';
    }

    return count;
}

// TODO: Merge with DoDataBlock
static void DataDoBlock2(unsigned int blkEnd, AddrSpaceHandle space, struct parse_state* state)
{
    /*struct rof_extrn *srch;*/
    struct cmd_items Ci;

    /* Insert Label if applicable */

    auto category = labelManager->getCategory(space);
    auto label = category->get(state->CmdEnt);
    if (label)
    {
        if (label->global())
        {
            Ci.lblname = label->nameWithColon();
        }
        else
        {
            Ci.lblname = label->name();
        }
    }

    while (state->PCPos < blkEnd)
    {
        state->CmdEnt = state->PCPos;

        // Check if this is the start of a reference.
        // auto ref = find_extrn(refsList, state->CmdEnt);
        if (false)
        {
            /*
            strcpy(Ci.mnem, "dc.");

            switch (REFSIZ(ref->Type))
            {
            case 1:
                strcat(Ci.mnem, "b");
                state->PCPos++;
                break;
            case 2:
                strcat(Ci.mnem, "w");
                state->PCPos += 2;
                break;
            default:
                strcat(Ci.mnem, "l");
                state->PCPos += 4;
            }

            if (ref->Extrn)
            {
                strcpy(Ci.params, ref->nam.c_str());
            }
            else
            {
                strcpy(Ci.params, ref->lbl->name().c_str());
            }

            PrintLine(pseudcmd, &Ci, space, state->CmdEnt, state->opt);
            state->CmdEnt = state->PCPos;
            Ci.lblname.clear();
            Ci.params[0] = '\0';
            Ci.mnem[0] = '\0';
            */
        }
        else /* No reference entry for this area */
        {
            int bytCount = 0;
            int bytSize;
            if (DoAsciiBlock(&Ci, blkEnd - state->CmdEnt, space, state) != 0)
            {
                continue;
            }
            else
            {
                register char* fmt;

                switch ((blkEnd - state->PCPos) % 4)
                {
                case 0:
                    bytSize = 4;
                    bytCount = (blkEnd - state->PCPos) >> 2;
                    strcpy(Ci.mnem, "dc.l");
                    fmt = "$%08x";
                    break;
                case 2:
                    bytSize = 2;
                    strcpy(Ci.mnem, "dc.w");
                    bytCount = (blkEnd - state->PCPos) >> 1;
                    fmt = "$%04x";
                    break;
                default:
                    bytSize = 1;
                    strcpy(Ci.mnem, "dc.b");
                    bytCount = blkEnd - state->PCPos;
                    fmt = "$%02x";
                }

                while (bytCount--)
                {
                    int val = 0;

                    switch (bytSize)
                    {
                    case 1:
                        // val = *(iBuf++) & 0xff;
                        val = state->Module->read<uint8_t>();
                        break;
                    case 2:
                        // val = bufReadL(&iBuf);
                        val = state->Module->read<uint16_t>();
                        break;
                    case 4:
                        // val = bufReadW(&iBuf);
                        val = state->Module->read<uint32_t>();
                        break;
                    default:
                        throw std::runtime_error("Unexpected byte size");
                    }

                    state->PCPos += bytSize;
                    sprintf(Ci.params, fmt, val);
                    PrintLine(pseudcmd, &Ci, space, state->CmdEnt, state->opt);
                    state->CmdEnt = state->PCPos;
                    Ci.lblname.clear();
                    Ci.params[0] = '\0';
                }

                Ci.mnem[0] = '\0';
            }
        }
    }
}

/* *************
 * ListInitData ()
 *
 */
// TODO: Merge with ListInitRof
static void ListInitData(AddrSpaceHandle space, struct parse_state* state)
{
    struct cmd_items Ci;
    const char* what = "* Initialized Data Definitions";

    if (state->Module->size() == 0) return;

    NowClass = space;
    uint32_t endAddress = state->PCPos + state->Module->size();

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

    // Split the init data into a series of blocks, separated by labels.
    auto category = labelManager->getCategory(space);

    std::vector<unsigned int> blockEnds;
    blockEnds.reserve(category->size());
    for (auto it = category->begin(); it != category->end(); it++)
    {
        blockEnds.push_back((*it)->myAddr);
    }

    std::sort(blockEnds.begin(), blockEnds.end());

    while (state->Module->size() != 0)
    {
        unsigned int blkEnd;

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

        DataDoBlock2(blkEnd, space, state);
    }
}

/* *************************************************** *
 * ROFDataPrint() - Mainline routine to list data defs *
 *          for ROF's                                  *
 * *************************************************** */

void ROFDataPrint(struct options* opt)
{
    Label* srch;

    /*char dattmp[5];*/
    const char* udat = "* Uninitialized Data (Class \"%s\")\n";
    // TODO: Change this to add a space. The reference exe will also have to be
    // patched.
    const char* idat = "* Initialized Data (Class\"%s\")\n";

    InProg = 0;
    auto category = labelManager->getCategory(&UNINIT_DATA_SPACE);
    srch = category ? category->getFirst() : NULL;
    if (srch)
    {
        parse_state state{0};
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
        parse_state state{0};
        state.Module = opt->Module.get();
        state.opt = opt;
        state.Pass = 2;

        dataprintHeader(idat, &INIT_DATA_SPACE, FALSE, opt);

        IBuf = new char[(size_t)opt->ROFHd->idatsz + 1];

        opt->Module->seekAbsolute(IDataBegin);

        opt->Module->readRaw(IBuf, opt->ROFHd->idatsz);

        auto category2 = labelManager->getCategory(&INIT_DATA_SPACE);
        srch = category2 ? category2->getFirst() : NULL;

        if (opt->ROFHd->idatsz)
        {
            ListInitROF("", refs_idata, IBuf, opt->ROFHd->idatsz, &INIT_DATA_SPACE, &state);
        }

        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
        /*ListInitData (srch, ROFHd.idatsz, '_');*/
        delete[] IBuf;
        /*ListInitROF (dta, ROFHd.idatsz, '_');*/
    }

    auto category3 = labelManager->getCategory(&UNINIT_REMOTE_SPACE);
    srch = category3 ? category3->getFirst() : NULL;
    if (srch)
    {
        parse_state state{0};
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
        parse_state state{0};
        state.Module = opt->Module.get();
        state.opt = opt;
        state.Pass = 2;

        int size = opt->ROFHd->remoteidatsiz;
        dataprintHeader(idat, &INIT_REMOTE_SPACE, TRUE, opt);

        IBuf = new char[(size_t)size + 1];
        opt->Module->readRaw(IBuf, size);

        auto category4 = labelManager->getCategory(&INIT_REMOTE_SPACE);
        srch = category4 ? category4->getFirst() : NULL;
        ListInitROF("", refs_iremote, IBuf, size, &INIT_REMOTE_SPACE, &state);
        BlankLine(opt);
        /*ListInitData (srch, ROFHd.idatsz, 'H');*/
        delete[] IBuf;
        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
        /*ListInitROF (dta, ROFHd.idatsz, 'H');*/
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

    if (!opt->modHeader->initDataHeaderOffset)
    {
        IDataBegin = opt->modHeader->memorySize;
        IDataCount = 0;
    }

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
        strcpy(Ci.params, "");
        Ci.cmd_wrd = 0;
        Ci.comment = "";
        PrintLine(pseudcmd, &Ci, &UNINIT_DATA_SPACE, 0, opt);
    }

    // Print uninit data.
    ListUninitData(opt->modHeader->uninitDataSize, &UNINIT_DATA_SPACE, opt);

    // Print init data.
    parse_state state;
    state.opt = opt;
    state.Pass = 2;
    opt->Module->seekAbsolute(opt->modHeader->initDataHeaderOffset + 8);
    auto initDataStream = std::make_unique<BigEndianStream>(opt->Module->fork(opt->modHeader->initDataSize));
    state.Module = initDataStream.get();
    state.PCPos = opt->modHeader->uninitDataSize;
    state.CmdEnt = state.PCPos;
    ListInitData(&INIT_DATA_SPACE, &state);

    // Print the vsect footer.
    {
        strcpy(Ci.mnem, "ends");
        strcpy(Ci.params, "");
        Ci.cmd_wrd = 0;
        Ci.comment = "";
        PrintLine(pseudcmd, &Ci, &INIT_DATA_SPACE, state.CmdEnt, opt);
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
    struct cmd_items Ci;
    register int datasize;

    // Nothing to print.
    if (maxAddress == 0) return;

    auto category = labelManager->getCategory(space);

    // If there are no labels, just print the whole thing as one directive.
    if (category->size() == 0)
    {
        strcpy(Ci.mnem, "ds.b");
        sprintf(Ci.params, "%ld", maxAddress);
        Ci.lblname.clear();
        PrintLine(pseudcmd, &Ci, space, 0, opt);
        return;
    }

    // If the first entry is not 0, print an initial ds.b directive without a
    // corresponding label.
    if (category->getFirst()->myAddr != 0)
    {
        auto first = category->getFirst();
        strcpy(Ci.mnem, "ds.b");
        sprintf(Ci.params, "%ld", first->myAddr);
        Ci.lblname.clear();
        PrintLine(pseudcmd, &Ci, &UNINIT_DATA_SPACE, 0, opt);
    }

    // Iterate through all the other labels.
    for (auto it = category->begin(); it != category->end(); it++)
    {
        // Don't print labels that are outside the maximum range of the address space.
        // These should have already been printed as equates.
        if ((*it)->myAddr >= maxAddress)
        {
            // Use "continue" instead of "break" because the labels might not be sorted.
            continue;
        }

        auto next = it + 1;

        if (next != category->end() && (*next)->myAddr < maxAddress)
        {
            datasize = (*next)->myAddr - (*it)->myAddr;
        }
        else
        {
            datasize = maxAddress - (*it)->myAddr;
        }

        strcpy(Ci.mnem, "ds.b");
        sprintf(Ci.params, "%d", datasize);

        if (opt->IsROF && (*it)->global())
        {
            Ci.lblname = (*it)->nameWithColon();
        }
        else
        {
            Ci.lblname = (*it)->name();
        }

        PrevEnt = (*it)->myAddr;
        PrintLine(pseudcmd, &Ci, space, (*it)->myAddr, opt);
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

    NowClass = &EQUATE_SPACE;
    // auto equates = labelManager->getCategory(&EQUATE_SPACE);
    // while ((NowClass = *(curnt++)) != ';')
    // for (auto it = equates->begin(); it != equates->end(); it++)
    //{
    int minval;

    flg = stdflg;
    strcpy(ClsHd, "%5d %21s");
    auto category = labelManager->getCategory(NowClass);
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

        TellLabels(me, flg, NowClass, minval, opt);
    }
    //}

    InProg = 1;
}

/* TellLabels(me) - Print out the labels for cClass in "me" array */

static void TellLabels(Label* me, int flg, AddrSpaceHandle space, int minval, struct options* opt)
{
    struct cmd_items Ci;

    strcpy(Ci.mnem, "equ");

    while (me)
    {
        if ((flg < 0) || flg == (int)me->stdName())
        {
            /* Don't print real OS9 Data variables here */

            if (me->myAddr >= minval)
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

                Ci.cmd_wrd = me->myAddr;

                if (opt->IsROF && me->global())
                {
                    Ci.lblname = me->nameWithColon();
                }
                else
                {
                    Ci.lblname = me->name();
                }

                // if (strchr("!^", space))
                //{
                sprintf(Ci.params, "$%02lx", me->myAddr);
                //}
                // else
                //{
                //    sprintf(Ci.params, "$%05lx", me->myAddr);
                //}

                PrintLine(pseudcmd, &Ci, space, me->myAddr, opt);
            }
        }

        me = label_getNext(me);
    }
}
