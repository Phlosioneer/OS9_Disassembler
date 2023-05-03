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

#include "disglobs.h"
#include "modtypes.h"
#include "rof.h"
#include "userdef.h"
#include <ctype.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "command_items.h"
#include "commonsubs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "label.h"
#include "main_support.h"
#include "rof.h"
#include "writer.h"

#ifdef _WIN32
#define snprintf _snprintf
#endif

#define MAX_ASCII_LINE_LEN 26

#define CNULL '\0'
struct ireflist* IRefs = NULL;
static void BlankLine(struct options* opt);
static void PrintFormatted(const char* pfmt, struct cmd_items* ci, struct options* opt, int CmdEnt);
static void NonBoundsLbl(char cClass, struct options* opt, int CmdEnt);
static void TellLabels(Label* me, int flg, char cClass, int minval, struct options* opt);

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
char EaString[200];

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
    if (PsectName)
    {
        psectParamBuffer << PsectName;
    }
    else if (strrchr(opt->ModFile, PATHSEP))
    {
        psectParamBuffer << strrchr(opt->ModFile, PATHSEP) + 1;
    }
    else
    {
        psectParamBuffer << opt->ModFile;
    }

    psectParamBuffer << "_a";

    /* Type/Language */
    InProg = 0; /* Inhibit Label Lookup */
    int type = modHeader ? modHeader->type : 0;
    ProgType = modnam_find(ModTyps, (unsigned char)type)->name;
    Ci.cmd_wrd = type;
    Ci.lblname = ProgType;
    std::ostringstream paramBuffer;
    paramBuffer << '$' << PrettyNumber<uint32_t>(type).hex();
    auto params = paramBuffer.str();
    strcpy(Ci.params, params.c_str());
    PrintLine(pseudcmd, &Ci, CNULL, 0, opt);
    /*hdrvals[0] = M_Type;*/

    int lang = modHeader ? modHeader->lang : 0;
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
        if (modHeader && (modHeader->attributes & 0xff) & ModAtts[c].val)
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

    int revision = modHeader ? modHeader->revision : 0;
    int edition = modHeader ? modHeader->edition : 0;
    int execOffset = modHeader ? modHeader->execOffset : 0;
    psectParamBuffer << ",(" << ProgAtts << "<<8)|" << revision;
    psectParamBuffer << ',' << edition;
    psectParamBuffer << ",0"; /* For the time being, don't add any stack */
    psectParamBuffer << ',' << findlbl('L', execOffset)->name();

    if (modHeader && modHeader->exceptionOffset)
    {
        Label* excep = findlbl('L', modHeader->exceptionOffset);
        psectParamBuffer << ',' << excep->name();
    }

    params = psectParamBuffer.str();
    strcpy(Ci.params, params.c_str());
    strcpy(Ci.mnem, "psect");
    Ci.lblname = "";
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
    char lbl[100];

    if (InProg)
    {
        nl = findlbl('L', CmdEnt);
        if (nl)
        {
            strcpy(lbl, nl->name());
            ci->lblname = lbl;

            if (opt->IsROF && nl->global())
            {
                strcat(lbl, ":");
            }
        }
    }

    PrintFormatted(pfmt, ci, opt, CmdEnt);

    if (opt->asmFile)
    {
        writer_printf(opt->asmFile, "%s %s %s", ci->lblname, ci->mnem, ci->params);

        if (ci->comment && strlen(ci->comment))
        {
            writer_printf(opt->asmFile, " %s", ci->comment);
        }

        writer_printf(opt->asmFile, "\n");
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

void PrintLine(const char* pfmt, struct cmd_items* ci, char cClass, int CmdEnt, options* opt)
{
    NonBoundsLbl(cClass, opt, CmdEnt); /*Check for non-boundary labels */

    OutputLine(pfmt, ci, opt, CmdEnt);

    PrintCleanup(CmdEnt);
}

static void PrintFormatted(const char* pfmt, struct cmd_items* ci, struct options* opt, int CmdEnt)
{
    int _linlen;

    /* make sure any non-initialized fields don't create Segfault */

    if (!ci->lblname) ci->lblname = "";
    /*if ( ! ci->mnem)        strcpy(ci->mnem, "");
    if ( ! ci->params)     strcpy(ci->params, "");*/
    if (!ci->comment) ci->comment = "";

    if (pfmt == pseudcmd)
    {
        if (opt->IsUnformatted)
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, &(pfmt[3]), CmdEnt, ci->cmd_wrd, ci->lblname, ci->mnem,
                               ci->params, ci->comment);
        }
        else
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, pfmt, LinNum, CmdEnt, ci->cmd_wrd, ci->lblname,
                               ci->mnem, ci->params, ci->comment);
        }
    }
    else
    {
        if (opt->IsUnformatted)
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, &(pfmt[3]), CmdEnt, ci->cmd_wrd, ci->lblname, ci->mnem,
                               ci->params, ci->comment);
        }
        else
        {
            _linlen = snprintf(FmtBuf, (size_t)opt->PgWidth - 2, pfmt, LinNum, CmdEnt, ci->cmd_wrd, ci->lblname,
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

static void NonBoundsLbl(char cClass, struct options* opt, int CmdEnt)
{
    if (cClass)
    {
        register int x;
        struct cmd_items Ci;
        Label* nl;

        strcpy(Ci.mnem, "equ");
        Ci.comment = "";

        for (x = PrevEnt + 1; x < CmdEnt; x++)
        {
            nl = findlbl(cClass, x);
            if (nl)
            {
                char lbl[100];
                strcpy(lbl, nl->name());
                Ci.lblname = lbl;

                if (opt->IsROF && nl->global())
                {
                    strcat(Ci.lblname, ":");
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
                    writer_printf(stdout_writer, &(pseudcmd[3]), nl->myAddr, Ci.cmd_wrd, Ci.lblname, Ci.mnem, Ci.params,
                                  "");
                }
                else
                {
                    writer_printf(stdout_writer, pseudcmd, LinNum++, nl->myAddr, Ci.cmd_wrd, Ci.lblname, Ci.mnem,
                                  Ci.params, "");
                }

                if (opt->asmFile)
                {
                    writer_printf(opt->asmFile, "%s %s %s\n", Ci.lblname, Ci.mnem, Ci.params);
                }
            }
        }
    }
}

/* ********************************************* *
 * ROFPsect() - writes out psect                 *
 * Passed: rof_header *rptr                         *
 * ********************************************* */
void ROFPsect(struct rof_header* rptr, struct options* opt)
{
    Label* nl;
    struct cmd_items Ci;

    memset(&Ci, 0, sizeof(struct cmd_items));
    /*strcpy(Ci.instr, "");*/
    strcpy(Ci.params, "");
    Ci.lblname = "";
    strcpy(Ci.mnem, "psect");
    /*sprintf(Ci.params, "%s,$%x,$%x,%d,%d,", rptr->rname,
                                                rptr->ty_lan >> 8,
                                                rptr->ty_lan & 0xff,
                                                rptr->edition,
                                                rptr->stksz
            );
    */
    char* params = rof_header_getPsectParams(rptr);
    strcpy(Ci.params, params);
    free(params);

    // nl = findlbl('L', rptr->code_begin);
    nl = findlbl('L', rof_header_getCodeAddress(rptr));
    if (nl)
    {
        strcat(Ci.params, nl->name());
        /*OPSCAT(nl->sname);*/
    }
    else
    {
        char oc[10];

        sprintf(oc, "$%04x", rof_header_getCodeAddress(rptr));
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

    memset(&Ci, 0, sizeof(Ci));
    strcpy(Ci.mnem, "ends");

    BlankLine(opt);
    //CmdEnt = PCPos; /* This should always work */
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

void ParseIRefs(char rClass, struct options* opt)
{
    register int rCount; /* The count for this block */
    register int MSB;

    /* Get an initial reading */

    if (fseek(opt->ModFP, modHeader->refTableOffset, SEEK_SET))
    {
        errexit("Fatal: Failed to seek to Initialized Refs location");
    }

    MSB = fread_w(opt->ModFP) << 16;
    rCount = fread_w(opt->ModFP);

    while (MSB || rCount) /* This will get All blocks for the Location */
    {
        while (rCount--)
        {
            struct ireflist *il, *ilpt;

            il = (struct ireflist*)mem_alloc(sizeof(struct ireflist));
            memset(il, 0, sizeof(struct ireflist));
            il->dAddr = MSB | fread_w(opt->ModFP);

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
                            free(il); /* We don't need this one */
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

        MSB = fread_w(opt->ModFP);
        rCount = fread_w(opt->ModFP);
    }
}

/*
 * GetIRefs() - The mainline routine for getting the Initialized Refs.
 *    Seeks to the proper location and then calls ParseIRefs for each
 *    of 'D' and 'L'
 */

void GetIRefs(struct options* opt)
{
    if (!opt->IsROF)
    {
        if (modHeader->refTableOffset == 0) return;

        ParseIRefs('L', opt);
    }
}

static void dataprintHeader(const char* hdr, char klas, int isRemote, struct options* opt)
{
    struct cmd_items Ci;

    BlankLine(opt);
    memset(&Ci, 0, sizeof(Ci));

    if (opt->IsUnformatted)
    {
        writer_printf(stdout_writer, hdr, klas);
        ++LinNum;
    }
    else
    {
        char f_fmt[100];

        sprintf(f_fmt, "%%5d %s", hdr);
        writer_printf(stdout_writer, f_fmt, LinNum++, klas);
    }

    if (opt->asmFile)
    {
        writer_printf(opt->asmFile, "%c", klas);
    }

    BlankLine(opt);

    strcpy(Ci.mnem, "vsect");
    strcpy(Ci.params, isRemote ? "remote" : "");
    Ci.cmd_wrd = 0;
    Ci.comment = "";
    PrintLine(pseudcmd, &Ci, 'D', 0, opt);
}

// Attempt to match an ascii string within a data block.
//
// This approach is way too greedy. It was completely broken in the oringal and
// fixing it breaks a ton of other stuff.

int DoAsciiBlock(struct cmd_items* ci, const char* buf, int bufEnd, char iClass, struct parse_state* state)
{
    register int count = bufEnd;
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
    int consumedThisLine = 0;
    int consumedByGroup = 0;
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
            int maxGroupLen;
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
            PrintLine(pseudcmd, ci, iClass, state->CmdEnt, state->opt);
            state->CmdEnt = state->PCPos;
            PrevEnt = state->PCPos;
            ci->lblname = "";
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
        PrintLine(pseudcmd, ci, iClass, state->CmdEnt, state->opt);
        state->CmdEnt = state->PCPos;
        PrevEnt = state->PCPos;
        ci->lblname = "";
        ci->params[0] = '\0';
    }

    return count;
}

/* *************
 * ListInitData ()
 *
 */

static void ListInitData(Label* ldf, int nBytes, char lclass, struct parse_state* state)
{
    struct cmd_items Ci;
    /*char *hexFmt;*/
    char* what = "* Initialized Data Definitions";
    Label *curlbl, *prevlbl;

    Ci.cmd_wrd = Ci.wcount = 0;
    Ci.comment = Ci.lblname = "";
    Ci.mnem[0] = Ci.params[0] = '\0';
    NowClass = 'D';
    state->PCPos = IDataBegin; /* MovBytes/MovASC use PCPos */
    state->CmdEnt = state->PCPos;

    curlbl = findlbl('D', state->PCPos);
    if (!curlbl)
    {
        curlbl = addlbl('D', state->PCPos, "");
    }

    if (fseek(state->ModFP, 0x40l, SEEK_SET) != -1)
    {
        int idatbegin, idatcount;

        if (fseek(state->ModFP, (long)fread_l(state->ModFP), SEEK_SET) == -1)
        {
            fprintf(stderr, "Cannot seek to Init Data Buffer\n");
            return;
        }

        idatbegin = fread_l(state->ModFP);
        idatcount = fread_l(state->ModFP);

        if (idatcount == 0)
        {
            return;
        }

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

        AMode = 0; /* Mode for Data             */

        curlbl = findlbl('D', idatbegin);

        while (idatcount > 0)
        {
            register int lblCount, ppos;
            char lbl[100];

            /* Get byte count for this label */
            if (!curlbl)
            {
                errexit("Null pointer dereference: curlbl in dprint.c");
            }
            prevlbl = curlbl;
            curlbl = label_getNext(curlbl);

            if (curlbl)
                lblCount = curlbl->myAddr - prevlbl->myAddr;
            else
                lblCount = idatcount;

            if (lblCount > idatcount)
            {
                lblCount = idatcount; /* Don't go past the end of data */
            }

            state->CmdEnt = state->PCPos; /* Save Entry Point */
            ppos = lblCount;
            strcpy(lbl, ldf->name());
            Ci.lblname = lbl;

            if (state->opt->IsROF && ldf->global())
            {
                strcat(Ci.lblname, ":");
            }

            /* We might ought to provide for longs, but it might
             * be more confusing */
            if (lblCount & 1)
            {
                PBytSiz = 1;
                strcpy(Ci.mnem, "dc.b");
                /*hexFmt = "$%02x";*/
            }
            else
            {
                PBytSiz = 2;
                strcpy(Ci.mnem, "dc.w");
                /*hexFmt = "$%04x";*/
            }

            /*Ci.lblname = findlbl ('D', CmdEnt)->sname;
            Ci.params[0] = '\0';*/
            ppos = lblCount;

            while (lblCount > 0)
            {
                char tmp[20];
                int val;

                if ((IRefs) && (state->PCPos == IRefs->dAddr))
                {
                    Label* mylbl;
                    struct ireflist* tmpref;
                    val = 0;
                    tmp[0] = '\0';


                    if (strlen(Ci.params))
                    {
                        OutputLine(pseudcmd, &Ci, state->opt, state->CmdEnt);
                        Ci.lblname = "";
                        PrintCleanup(state->CmdEnt);
                        state->CmdEnt = state->PCPos;
                        Ci.params[0] = '\0';
                    }

                    val = fread_l(state->ModFP);
                    state->PCPos += 4;
                    lblCount -= 4;
                    idatcount -= 4;

                    if (!findlbl('L', val))
                    {
                        addlbl('L', val, NULL);
                    }

                    if (strlen(Ci.params))
                    {
                        strcat(Ci.params, ",");
                    }

                    mylbl = findlbl('L', val);
                    if (mylbl)
                    {
                        strcat(Ci.params, mylbl->name());
                    }
                    else
                    {
                        sprintf(&Ci.params[strlen(Ci.params)], "$%04x", val);
                    }

                    strcpy(Ci.mnem, "dc.l");
                    OutputLine(pseudcmd, &Ci, state->opt, state->CmdEnt);
                    state->CmdEnt = state->PCPos;
                    tmpref = IRefs;
                    IRefs = IRefs->Next;
                    free(tmpref);
                    Ci.lblname = "";
                    Ci.params[0] = '\0';
                    /* Reset mnem to original status */
                    strcpy(Ci.mnem, PBytSiz == 1 ? "dc.b" : "dc.w");
                    PrintCleanup(state->CmdEnt);
                    ppos -= 4;
                    continue;
                }
                else
                {
                    switch (PBytSiz)
                    {
                    case 1:
                        sprintf(tmp, "$%02x", (fgetc(state->ModFP) & 0xff));
                        break;
                    case 2:
                        val = fread_w(state->ModFP);
                        sprintf(tmp, "$%04x", val & 0xffff);
                        break;
                    }

                    if (strlen(Ci.params))
                    {
                        strcat(Ci.params, ",");
                    }

                    strcat(Ci.params, tmp);
                    ppos -= PBytSiz;
                    state->PCPos += PBytSiz;
                    idatcount -= PBytSiz;
                    lblCount -= PBytSiz;

                    if (strlen(Ci.params) > 24)
                    {
                        OutputLine(pseudcmd, &Ci, state->opt, state->CmdEnt);
                        PrintCleanup(state->CmdEnt);
                        state->CmdEnt = state->PCPos;
                        Ci.lblname = "";
                        Ci.params[0] = '\0';
                        Ci.wcount = 0;
                    }
                }
            }

            if (strlen(Ci.params)) /* Any final cleanup */
            {
                PrevEnt = state->PCPos;
                OutputLine(pseudcmd, &Ci, state->opt, state->CmdEnt);
                state->CmdEnt = state->PCPos;
                Ci.wcount = 0;
                Ci.params[0] = '\0';
            }

            state->CmdEnt = state->PCPos;
            idatcount -= lblCount;
            ldf = label_getNext(ldf);
        }
    }
    else
    {
        fprintf(stderr, "Failed seek to Init Data pointer location\n");
        return;
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
    const char* udat = "* Uninitialized Data (Class \"%c\")";
    // TODO: Change this to add a space. The reference exe will also have to be
    // patched.
    const char* idat = "* Initialized Data (Class\"%c\")";

    InProg = 0;
    auto category = labelManager->getCategory('D');
    srch = category ? category->getFirst() : NULL;
    if (srch)
    {
        parse_state state{0};
        state.ModFP = opt->ModFP;
        state.opt = opt;

        dataprintHeader(udat, 'D', FALSE, opt);

        /*first, if first entry is not D000, rmb bytes up to first */

        ListData(srch, rof_header_getUninitDataSize(ROFHd), 'D', &state);
        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
    }

    if (rof_header_getInitDataSize(ROFHd))
    {
        parse_state state{0};
        state.ModFP = opt->ModFP;
        state.opt = opt;

        dataprintHeader(idat, '_', FALSE, opt);

        IBuf = (char*)mem_alloc((size_t)rof_header_getInitDataSize(ROFHd) + 1);

        if (fseek(opt->ModFP, IDataBegin, SEEK_SET))
        {
            errexit("Cannot Seek to begin of Initialized data");
        }

        if (fread(IBuf, rof_header_getInitDataSize(ROFHd), 1, opt->ModFP) < 1)
        {
            errexit("Cannot read Initialized data from file!");
        }

        auto category2 = labelManager->getCategory('_');
        srch = category2 ? category2->getFirst() : NULL;

        if (rof_header_getInitDataSize(ROFHd))
        {
            ListInitROF("", refs_idata, IBuf, rof_header_getInitDataSize(ROFHd), '_', &state);
        }

        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
        /*ListInitData (srch, ROFHd.idatsz, '_');*/
        free(IBuf);
        /*ListInitROF (dta, ROFHd.idatsz, '_');*/
    }

    auto category3 = labelManager->getCategory('G');
    srch = category3 ? category3->getFirst() : NULL;
    if (srch)
    {
        parse_state state{0};
        state.ModFP = opt->ModFP;
        state.opt = opt;

        dataprintHeader(udat, 'G', TRUE, opt);

        /*first, if first entry is not D000, rmb bytes up to first */

        ListData(srch, rof_header_getRemoteUninitDataSize(ROFHd), 'G', &state);
        BlankLine(opt);
        WrtEnds(opt, state.PCPos);
    }

    if (rof_header_getRemoteInitDataSize(ROFHd))
    {
        parse_state state{0};
        state.ModFP = opt->ModFP;
        state.opt = opt;
        int size = rof_header_getRemoteInitDataSize(ROFHd);
        dataprintHeader(idat, 'H', TRUE, opt);

        IBuf = (char*)mem_alloc((size_t)size + 1);

        if (fread(IBuf, size, 1, opt->ModFP) < 1)
        {
            errexit("Cannot read Remote Initialized data from file!");
        }

        auto category4 = labelManager->getCategory('H');
        srch = category4 ? category4->getFirst() : NULL;
        ListInitROF("", refs_iremote, IBuf, size, 'H', &state);
        BlankLine(opt);
        /*ListInitData (srch, ROFHd.idatsz, 'H');*/
        free(IBuf);
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
    Label *dta, *srch;
    char* what = "* OS9 data area definitions";
    struct cmd_items Ci;
    long filePos = ftell(opt->ModFP);
    parse_state state{0};
    state.ModFP = opt->ModFP;
    state.opt = opt;

    if (!modHeader->initDataHeaderOffset)
    {
        IDataBegin = modHeader->memorySize;
        IDataCount = 0;
    }

    InProg = 0; /* Stop looking for Inline program labels to substitute */
    memset(&Ci, 0, sizeof(Ci));
    auto category = labelManager->getCategory('D');
    dta = category ? category->getFirst() : NULL;

    if (dta)
    { /* special tree for OS9 data defs */
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
        PrintLine(pseudcmd, &Ci, 'D', 0, opt);

        /*first, if first entry is not D000, rmb bytes up to first */
        srch = dta;

        /*while (srch->LNext)
        {
            srch = srch->LNext;
        }*/

        if (srch->myAddr) /* i.e., if not D000 */
        {
            strcpy(Ci.mnem, "ds.b");
            sprintf(Ci.params, "%ld", srch->myAddr);
            Ci.lblname = "";
            PrintLine(pseudcmd, &Ci, 'D', srch->myAddr, opt);
        }

        ListData(dta, IDataBegin, 'D', &state);

        // If this is a roff, treat memorySize as infinite.
        if (modHeader == NULL || IDataBegin < modHeader->memorySize)
        {
            dta = findlbl('D', IDataBegin);
            if (dta)
            {
                ListInitData(dta, IDataCount, 'D', &state);
            }
        }
    }
    else
    {
        return;
    }

    strcpy(Ci.mnem, "ends");
    strcpy(Ci.params, "");
    Ci.cmd_wrd = 0;
    Ci.comment = "";
    PrintLine(pseudcmd, &Ci, 'D', state.CmdEnt, opt);
    BlankLine(opt);
    InProg = 1;
    fseek(opt->ModFP, filePos, SEEK_SET);
}

/* ******************************************************** *
 * ListData() - recursive routine to print rmb's for Data   *
 *              definitions                                 *
 * Passed: pointer to current nlist element                 *
 *         address of upper (or calling) ListData() routine *
 *         Label cClass                                      *
 * ******************************************************** */

void ListData(Label* me, int upadr, char cClass, struct parse_state* state)
{
    struct cmd_items Ci;
    register int datasize;

    memset(&Ci, 0, sizeof(Ci));

    /* Process lower entries first */

    /*if (me->LNext)
    {
        ListData (me->LNext, label_getMyAddr(me), cClass);
    }*/

    /* Don't print non-data elements here */

    if (me->myAddr >= upadr)
    {
        return;
    }

    /* Now we've come back, print this entry */

    /*strcpy (pbf->lbnm, me->sname);*/

    if (state->opt->IsROF && me->global())
    {
        char* newName = strdup(me->name());
        strcat(newName, ":");
        me->setName(newName);
    }

    /*if (me->RNext)
    {
        srch = me->RNext;*/       /* Find smallest entry in that list */

    /*while (srch->LNext)
    {
        srch = srch->LNext;
    }

    datasize = (srch->myaddr) - (label_getMyAddr(me));
}
else
{
    datasize = (upadr) - (label_getMyAddr(me));
}*/

    /* Don't print any Class 'D' variables which are not in Data area */
    /* Note, Don't think we'll get this far, we have a return up above,
     * but keep this one till we know it works

    if ((OSType == OS_9) && (label_getMyAddr(me) > M_Mem))
    {
        return;
    }*/

    while (me)
    {
        char lbl[100];

        if (me->myAddr >= upadr)
        {
            break;
        }

        if ((label_getNext(me)) && (label_getNext(me)->myAddr < upadr))
        {
            datasize = label_getNext(me)->myAddr - me->myAddr;
        }
        else
        {
            datasize = upadr - me->myAddr;
        }

        strcpy(Ci.mnem, "ds.b");
        sprintf(Ci.params, "%d", datasize);
        strcpy(lbl, me->name());
        Ci.lblname = lbl;

        if (state->opt->IsROF && me->global())
        {
            strcat(Ci.lblname, ":");
        }
        /*if (label_getMyAddr(me) != upadr)
        {
            strcpy (Ci.mnem, "ds.b");
            sprintf (Ci.params, "%d", datasize);
            Ci.lblname = me->sname;
        }
        else
        {
            if (opt->IsROF)
            {
                strcpy (Ci.mnem, "ds.b");
                sprintf (Ci.params, "%d", datasize);
            }
            else
            {
                strcpy (Ci.mnem, "ds.b");
                strcpy (Ci.params, "ds.b");
            }
        }*/

        state->CmdEnt = me->myAddr;
        PrevEnt = state->CmdEnt;
        PrintLine(pseudcmd, &Ci, cClass, me->myAddr, state->opt);
        me = label_getNext(me);

        /*if (me->RNext && (label_getMyAddr(me) < M_Mem))
        {
            ListData (me->RNext, upadr, cClass);
        }*/
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
    static char* genhd[2] = {"* Class %c external label equates\n", "* Class %c standard named label equates\n"};
    register int flg; /* local working flg - clone of stdflg */
    Label* me;

    InProg = 0;
    curnt = claspt;

    if (!stdflg) /* print ! and ^ only on std cClass pass */
    {
        curnt += 2;
    }

    while ((NowClass = *(curnt++)) != ';')
    {
        int minval;

        flg = stdflg;
        strcpy(ClsHd, "%5d %21s");
        auto category = labelManager->getCategory(NowClass);
        me = category ? category->getFirst() : NULL;

        if (me)
        {
            /* For OS9, we only want external labels this pass */

            if (NowClass == 'D')
            {
                if (stdflg) /* Don't print data defs */
                {
                    continue;
                }

                /* Probably an error if this happens
                 * What we're doing is positioning me to
                 * last real data element*/

                /* if (!(me = FindLbl (me, M_Mem)))*/
                if (modHeader)
                {
                    me = findlbl(NowClass, modHeader->memorySize);
                    if (!me)
                    {
                        continue;
                    }
                }
                else
                {
                    continue;
                }
            }

            /* Don't write vsect data for ROF's */

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
                strcat(ClsHd, genhd[flg]);
                SrcHd = genhd[flg];
            }

            HadWrote = 0; /* flag header not written */

            /* Determine minimum value for printing *
             * minval will be the first value to    *
             * print                                */

            minval = 0; /* Default to "print all" */

            // Added OR to satisfy VS null checker.
            if (opt->IsROF || !modHeader)
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
                if (NowClass == 'D')
                {
                    minval = modHeader->memorySize + 1;
                }
                else
                {
                    if (NowClass == 'L')
                    {
                        minval = modHeader->size + 1;
                    }
                }
            }

            TellLabels(me, flg, NowClass, minval, opt);
        }
    }

    InProg = 1;
}

/* TellLabels(me) - Print out the labels for cClass in "me" array */

static void TellLabels(Label* me, int flg, char cClass, int minval, struct options* opt)
{
    struct cmd_items Ci;

    memset(&Ci, 0, sizeof(Ci));
    strcpy(Ci.mnem, "equ");

    while (me)
    {
        char lbl[100];

        if ((flg < 0) || flg == me->stdName())
        {
            /* Don't print real OS9 Data variables here */

            if (me->myAddr >= minval)
            {
                if (!HadWrote)
                {
                    BlankLine(opt);

                    if (opt->IsUnformatted)
                    {
                        writer_printf(stdout_writer, &(ClsHd[3]), "", cClass);
                        ++LinNum;
                    }
                    else
                    {
                        writer_printf(stdout_writer, ClsHd, LinNum++, "", cClass);
                    }

                    if (opt->asmFile)
                    {
                        writer_printf(opt->asmFile, SrcHd, cClass);
                    }

                    HadWrote = 1;
                    BlankLine(opt);
                }

                strcpy(lbl, me->name());
                Ci.lblname = lbl;
                Ci.cmd_wrd = me->myAddr;

                if (opt->IsROF && me->global())
                {
                    strcat(Ci.lblname, ":");
                }

                if (strchr("!^", cClass))
                {
                    sprintf(Ci.params, "$%02lx", me->myAddr);
                }
                else
                {
                    sprintf(Ci.params, "$%05lx", me->myAddr);
                }

                PrintLine(pseudcmd, &Ci, cClass, me->myAddr, opt);
            }
        }

        me = label_getNext(me);
    }
}
