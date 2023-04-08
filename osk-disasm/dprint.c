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

#include <time.h>
#include <errno.h>
#include <stdlib.h>
#include "disglobs.h"
#include <string.h>
#include <ctype.h>
#include "modtypes.h"
#include "userdef.h"
#include "rof.h"

#include "commonsubs.h"
#include "exit.h"
#include "dismain.h"
#include "dprint.h"
#include "label.h"
#include "command_items.h"
#include "writer.h"
#include "main_support.h"
#include "rof.h"

#ifdef _WIN32
#   define snprintf _snprintf
#endif


#define CNULL '\0'

static void BlankLine();
static void PrintFormatted (const char *pfmt, struct cmd_items *ci);
static void NonBoundsLbl (char cClass);
static void TellLabels (struct symbol_def *me, int flg, char cClass, int minval);

/*extern struct printbuf *pbuf;*/
extern struct rof_header ROFHd;

const char pseudcmd[80] = "%5d  %05x %04x %-10s %-6s %-10s %s\n";
const char realcmd[80] =  "%5d  %05x %04x %-9s %-10s %-6s %-10s %s\n";
static const char *xtraFmt = "             %s\n";

int PrevEnt = 0;                /* Previous CmdEnt - to print non-boundary labels */
static int InProg;              /* Flag that we're in main program, so that it won't
                                   munge the label name */
static char ClsHd[100];         /* header string for label equates */
static char FmtBuf[200];        /* Buffer to store formatted string */
static int HadWrote;            /* flag that header has been written */
static char *SrcHd;             /* ptr for header for source file */
static char *IBuf;              /* Pointer to buffer containing the Init Data values */
int LinNum;
int PgWidth = 80;
char EaString[200];

/* Comments tree */

struct comment_tree* Comments[33];
struct append_comment* CmntApnd[33];

struct modnam ModTyps[] = {
    {"Prgrm", 1},
    {"Sbrtn", 2},
    {"Multi", 3},
    {"Data", 4},
    {"CSDData", 5},
    {"TrapLib", 11},
    {"Systm", 12},
    {"FlMgr", 13},
    {"Drivr", 14},
    {"Devic", 15},
    {"",0}
};

struct modnam ModLangs[] = {
    {"Objct",    1},
    {"ICode",    2},
    {"PCode",    3},
    {"CCode",    4},
    {"CblCode",  5},
    {"FrtnCode", 6},
    {"", 0}
};

struct modnam ModAtts[] = {
    {"SupStat", 0x20},
    {"Ghost", 0x40},
    {"ReEnt", 0x80},
    {"",0}
};

/* **********
 * PrintPsect() - Set up the Psect for printout
 *
 */

void PrintPsect()
{
    char *ProgType = NULL;
    char *ProgLang = NULL;
    char ProgAtts[50];
    /*char *StackAddL;*/
    int c;
    struct cmd_items Ci;
    int pgWdthSave;

    Ci.comment = "";
    strcpy (Ci.mnem, "set");
    BlankLine();

    /* Module name */
    if (PsectName)
    {
        strcpy(EaString, PsectName);
    }
    else if (strrchr(ModFile, PATHSEP))
    {
        strcpy (EaString, strrchr(ModFile, PATHSEP) + 1);
    }
    else
    {
        strcpy (EaString, ModFile);
    }

    strcat (EaString, "_a");

    /* Type/Language */
    InProg = 0;    /* Inhibit Label Lookup */
    ProgType = modnam_find (ModTyps, (unsigned char)M_Type)->name;
    Ci.cmd_wrd = M_Type;
    Ci.lblname = ProgType;
    sprintf (Ci.params, "$%x", M_Type);
    PrintLine(pseudcmd, &Ci, CNULL, 0, 0);
    /*hdrvals[0] = M_Type;*/
    ProgLang = modnam_find (ModLangs, (unsigned char)M_Lang)->name;
    Ci.lblname = ProgLang;
    Ci.cmd_wrd = M_Lang;
    sprintf (Ci.params, "$%02x", M_Lang);
    PrintLine(pseudcmd, &Ci, CNULL, 0, 0);
    /*hdrvals[1] = M_Lang;*/
    sprintf (&EaString[strlen(EaString)], ",(%s<<8)|%s", ProgType, ProgLang);

    /* Att/Rev */
    ProgAtts[0] = '\0';

    for (c = 0; ModAtts[c].val; c++)
    {
        if ((M_Attr & 0xff) & ModAtts[c].val)
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
            sprintf (Ci.params, "$%02x",ModAtts[c].val);
            PrintLine (pseudcmd, &Ci, CNULL, 0, 0); 
        }
    }

    sprintf (&EaString[strlen(EaString)], ",(%s<<8)|%d", ProgAtts, M_Revs);
    sprintf (&EaString[strlen(EaString)], ",%d", M_Edit);
    strcat (EaString, ",0");    /* For the time being, don't add any stack */
    sprintf (&EaString[strlen(EaString)], ",%s", label_getName(findlbl('L', M_Exec)));

    if (M_Except)
    {
        struct symbol_def *excep = findlbl('L', M_Except);
        strcat(EaString, ",");
        strcat(EaString, label_getName(excep));
    }

    strcpy (Ci.params, EaString);
    strcpy (Ci.mnem, "psect");
    Ci.lblname = "";
    /* Be sure to have enough space to write psect */
    pgWdthSave = PgWidth;
    PgWidth = 200;
    BlankLine();
    PrintLine (pseudcmd, &Ci, CNULL, 0, 0);
    BlankLine();
    PgWidth = pgWdthSave;
    InProg = 1;
}

/* ************************************** *
 * OutputLine () - does the actual output *
 * to the listing and/or source file      *
 * ************************************** */

static void OutputLine (const char *pfmt, struct cmd_items *ci)
{
    struct symbol_def *nl;
    char lbl[100];

    if (InProg)
    {
        nl = findlbl('L', CmdEnt);
        if (nl)
        {
            strcpy(lbl, label_getName(nl));
            ci->lblname = lbl;

            if (IsROF && label_getGlobal(nl))
            {
                strcat(lbl, ":");
            }
        }
    }

    PrintFormatted (pfmt, ci);

    if (WrtSrc)
    {
        writer_printf(module_writer, "%s %s %s", ci->lblname, ci->mnem, ci->params);

        if (ci->comment && strlen (ci->comment))
        {
            writer_printf(module_writer, " %s", ci->comment);
        }

        writer_printf(module_writer, "\n");
    }
}

    /* Straighten/clean up - prepare for next line  */

static void PrintCleanup ()
{
    PrevEnt = CmdEnt;

    /*CmdLen = 0;*/
    ++LinNum;
}

static void BlankLine ()                    /* Prints a blank line */
{
    if (IsUnformatted)
    {
        return;
    }

    writer_printf(stdout_writer, "%5d\n", LinNum++);

    if (WrtSrc)
    {
        writer_printf(module_writer, "\n");
    }
}

/* ************************************************************ *
 * PrintNonCmd() - A utility function to print any non-command  *
 *          line (except stored comments).                      *
 *          Prints the line with line number, and updates       *
 *          LinNum                                              *
 * Passed: str - the string to print                            *
 *         preblank - true if blankline before str              *
 *         postblank - true if blankline after str              *
 * ************************************************************ */

/*static void PrintNonCmd (char *str, int preblank, int postblank)
{
    if (IsROF)
    {
        if (preblank)
        {
            BlankLine();
        }

        if (IsUnformatted)
        {
            writer_printf(stdout_writer, " %s\n", str);
            ++LinNum;
        }
        else
        {
            writer_printf(stdout_writer, "%5d %s\n", LinNum, str);
        }

        if (WrtSrc)
        {
            writer_printf(module_writer, "%s", str);
        }

        if (postblank)
        {
            BlankLine();
        }
    }

    PrintCleanup ();
}*/

/* ******************************************************** *
 * get_comment() - Checks for append comment for current    *
 *              command line.                               *
 * Passed: (1) cClass,                                       *
 *         (2) entry address for command                    *
 * Returns: ptr to comment string if present                *
 *          ptr to empty string if none                     *
 * ******************************************************** */

char * get_apcomment(char clas, int addr)
{
    struct append_comment *mytree = CmntApnd[strpos (lblorder, clas)];

    if ( ! clas)
    {
        return NULL;
    }

    if (mytree)
    {
        while (1)
        {
            if (addr < mytree->adrs)
            {
                if (mytree->apLeft)
                {
                    mytree = mytree->apLeft;
                }
                else
                {
                    break;
                }
            }
            else
            {
                if (addr > mytree->adrs)
                {
                    if (mytree->apRight)
                    {
                        mytree = mytree->apRight;
                    }
                    else
                    {
                        break;
                    }
                }
                else
                {
                    return mytree->CmPtr;
                }
            }
        }
    }

    return NULL;
}


/* ******************************************************** *
 * PrintLine () - The generic, global printline function    *
 *                It checks for unlisted boundaries, prints *
 *                the line, and then does cleanup           *
 * ******************************************************** */

void PrintLine(const char *pfmt, struct cmd_items *ci, char cClass, int cmdlow, int cmdhi)
{
    NonBoundsLbl (cClass);            /*Check for non-boundary labels */

    if (cClass)
    {
        PrintComment (cClass, cmdlow, cmdhi);
        ci->comment = get_apcomment(cClass, cmdlow);
    }

    OutputLine (pfmt, ci);

    PrintCleanup ();
}

static void PrintFormatted(const char *pfmt, struct cmd_items *ci)
{
    int _linlen;

    /* make sure any non-initialized fields don't create Segfault */

    if ( ! ci->lblname)    ci->lblname = "";
    /*if ( ! ci->mnem)        strcpy(ci->mnem, "");
    if ( ! ci->params)     strcpy(ci->params, "");*/
    if ( ! ci->comment)     ci->comment = "";

    if (pfmt == pseudcmd)
    {
        if (IsUnformatted)
        {
            _linlen = snprintf (FmtBuf, (size_t)PgWidth - 2, &(pfmt[3]),
                                    CmdEnt, ci->cmd_wrd, ci->lblname,
                                    ci->mnem, ci->params, ci->comment);
        }
        else
        {
            _linlen = snprintf (FmtBuf, (size_t)PgWidth - 2, pfmt,
                                    LinNum, CmdEnt, ci->cmd_wrd, ci->lblname,
                                    ci->mnem, ci->params, ci->comment);
        }
    }
    else
    {
        if (IsUnformatted)
        {
            _linlen = snprintf (FmtBuf, (size_t)PgWidth - 2, &(pfmt[3]),
                                CmdEnt, ci->cmd_wrd, ci->lblname,
                                ci->mnem, ci->params, ci->comment);
        }
        else
        {
            _linlen = snprintf (FmtBuf, (size_t)PgWidth - 2, pfmt,
                                LinNum, CmdEnt, ci->cmd_wrd, ci->lblname,
                                ci->mnem, ci->params, ci->comment);
        }
    }

    if ((_linlen >= PgWidth - 2) || (_linlen < 0))
    {
        FmtBuf[PgWidth - 3] = '\n';
        FmtBuf[PgWidth - 2] = '\0';
    }

    writer_printf(stdout_writer, "%s", FmtBuf);
    writer_flush(stdout_writer);
}

/* **************************************************************** *
 * Print additional data bytes in line following main line          *
 * **************************************************************** */

void printXtraBytes (char *data)
{
    if (strlen (data))
    {
        writer_printf(stdout_writer, xtraFmt, data);
        data[0] = '\0';     /* Reset data to empty string */
    }
}

/*
 * PrintComment() -Print any comments appropriate
 *
 */

void PrintComment(char lblcClass, int cmdlow, int cmdhi)
{
    register struct comment_tree *me;
    register int x;

    for (x = cmdlow; x < cmdhi; x++)
    {
        me = Comments[strpos (lblorder, lblcClass)];

        while (me)
        {
            if (x < me->adrs)
            {
                me = me->cmtLeft;
            }
            else
            {
                if (x > me->adrs)
                {
                    me = me->cmtRight;
                }
                else        /* Assume for now it's equal */
                {
                    struct comment_line *line;

                    line = me->commts;

                    for (line = me->commts; line; line = line->nextline)
                    {
                        if (IsUnformatted)
                        {
                            printf(" * %s\n", line->ctxt);
                        }
                        else
                        {
                            printf("%5d * %s\n", LinNum++, line->ctxt);
                        }

                        if (WrtSrc)
                        {
                            writer_printf(module_writer, "* %s\n", line->ctxt);
                        }

                    }

                    break;  /* This address done, proceed with next x */
                }
            }
        }
    }
}

static void NonBoundsLbl (char cClass)
{
    if (cClass)
    {
        register int x;
        struct cmd_items Ci;
        register struct symbol_def *nl;

        strcpy (Ci.mnem, "equ");
        Ci.comment = "";

        for (x = PrevEnt + 1; x < CmdEnt; x++)
        {
            nl = findlbl(cClass, x);
            if (nl)
            {
                char lbl[100];
                strcpy (lbl, label_getName(nl));
                Ci.lblname = lbl;

                if (IsROF && label_getGlobal(nl))
                {
                    strcat (Ci.lblname, ":");
                }

                if (x > CmdEnt)
                {
                    sprintf (Ci.params, "*+%d", x - CmdEnt);
                }
                else
                {
                    sprintf (Ci.params, "*-%d", CmdEnt - x);
                }

                /*PrintLine (pseudcmd, &Ci, cClass, CmdEnt, PCPos);*/
                if (IsUnformatted)
                {
                    writer_printf(stdout_writer, &(pseudcmd[3]), label_getMyAddr(nl), Ci.cmd_wrd,
                            Ci.lblname, Ci.mnem, Ci.params, "");
                }
                else
                {
                    writer_printf(stdout_writer, pseudcmd, LinNum++, label_getMyAddr(nl), Ci.cmd_wrd,
                            Ci.lblname, Ci.mnem, Ci.params, "");
                }

                if (WrtSrc)
                {
                    writer_printf(module_writer, "%s %s %s\n", Ci.lblname, Ci.mnem,
                             Ci.params);
                }
            }
        }
    }
}

/* ********************************************* *
 * ROFPsect() - writes out psect                 *
 * Passed: rof_header *rptr                         *
 * ********************************************* */

/*#define OPSCAT(str) sprintf (ci->params, "%s,%s", pbuf->operand, str)
#define OPDCAT(nu) sprintf (ci->params, "%s,%d", pbuf->operand, nu)
#define OPHCAT(nu) sprintf (pbuf->operand, "%s,%04x", pbuf->operand, nu)*/

void ROFPsect (struct rof_header *rptr)
{
    struct symbol_def *nl;
    struct cmd_items Ci;

    memset (&Ci, 0, sizeof(struct cmd_items));
    /*strcpy (Ci.instr, "");*/
    strcpy (Ci.params, "");
    Ci.lblname = "";
    strcpy (Ci.mnem, "psect");
    sprintf (Ci.params, "%s,$%x,$%x,%d,%d,", rptr->rname,
                                                rptr->ty_lan >> 8,
                                                rptr->ty_lan & 0xff,
                                                rptr->edition,
                                                rptr->stksz
            );
/*#define OPSCAT(str) sprintf (ci->params, "%s,%s", pbuf->operand, str)
#define OPDCAT(nu) sprintf (ci->params, "%s,%d", pbuf->operand, nu)
#define OPHCAT(nu) sprintf (pbuf->operand, "%s,%04x", pbuf->operand, nu)*/

    nl = findlbl('L', rptr->code_begin);
    if (nl)
    {
        strcat(Ci.params, label_getName(nl));
        /*OPSCAT(nl->sname);*/
    }
    else
    {
        char oc[10];

        sprintf(oc, "$%04x", rptr->code_begin);
        strcat(Ci.params, oc);
        /*OPHCAT ((int)(rptr->modent));*/
    }

    CmdEnt = 0;
    PrevEnt = 1;    /* To prevent NonBoundsLbl() output */
    InProg = 0;    /* Inhibit Label Lookup */
    PrintLine (pseudcmd, &Ci, CNULL, 0, 0); 
    InProg = 1;
}



/* *************************************************** *
 * WrtEnds() - writes the "ends" command line          *
 * *************************************************** */

void
WrtEnds()
{
    struct cmd_items Ci;

    memset (&Ci, 0, sizeof (Ci));
    strcpy (Ci.mnem, "ends");

    BlankLine();
    CmdEnt = PCPos;     /* This should always work */
    PrintFormatted (pseudcmd, &Ci);

    if (WrtSrc)
    {
        writer_printf(module_writer, "%s %s %s\n", "", "ends", "");
    }

    BlankLine();
}

/* ******************
 * ireflist structure: Represents an entry in the Initialized Refs
 *       list.
 */

struct ireflist {
    struct ireflist *Prev;
    struct ireflist *Next;
    int dAddr;
} *IRefs = NULL;

/* *******
 * ParseIRefs() - Parse through the Initialized Refs list for either
 *    class 'D' or 'L'.
 *    Insert appropriate labels into Label Trees and the
 *    IRef table.
 */

void ParseIRefs(char rClass)
{
    register int rCount;  /* The count for this block */
    register int MSB;

    /* Get an initial reading */

    if (fseek (ModFP, M_IRefs, SEEK_SET))
    {
        errexit ("Fatal: Failed to seek to Initialized Refs location");
    }

    MSB = fread_w(ModFP) << 16;
    rCount = fread_w(ModFP);

    while (MSB || rCount)   /* This will get All blocks for the Location */
    {
        while (rCount--)
        {
            struct ireflist *il, *ilpt;

            il = (struct ireflist *)mem_alloc (sizeof(struct ireflist));
            memset (il, 0, sizeof(struct ireflist));
            il->dAddr = MSB | fread_w(ModFP);

            if (IRefs)   /* First entry? */
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
                        if ((il->dAddr == ilpt->dAddr) ||
                                (il->dAddr == ilpt->Next->dAddr))
                        {
                            free(il);   /* We don't need this one */
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

        MSB = fread_w(ModFP);
        rCount = fread_w(ModFP);
    }
}

/*
 * GetIRefs() - The mainline routine for getting the Initialized Refs.
 *    Seeks to the proper location and then calls ParseIRefs for each
 *    of 'D' and 'L'
 */

void
GetIRefs()
{
    if (IsROF)
    {
        if ((fseek (ModFP, IDataBegin, SEEK_SET) == -1))
        {
            errexit ("Failed to seek to begin of Initialized Data Section");
        }
           /* Get Init Data*/
        /* Positioned at begin of Initialized Remote Section */
        /* ..... Get Init Remote ......... */
        /* .... Until above is implemented */
        if (fseek (ModFP, ROFHd.idatsz + ROFHd.remotestatsiz + ROFHd.debugsiz - 2, SEEK_CUR) == -1)
        {
            fprintf (stderr, "rofhdr(): Seek error on module\n");
            exit (errno);
        }

    }
    else
    {
        if (M_IRefs == 0)
            return;

        ParseIRefs('L');
    }
}

static void dataprintHeader(const char *hdr, char klas, int isRemote)
{
    struct cmd_items Ci;

    BlankLine();
    memset (&Ci, 0, sizeof (Ci));

    if (IsUnformatted)
    {
        writer_printf(stdout_writer, hdr, klas);
        ++LinNum;
    }
    else
    {
        char f_fmt[100];

        sprintf (f_fmt, "%%5d %s", hdr);
        writer_printf(stdout_writer, f_fmt, LinNum++, klas);
    }

    if (WrtSrc)
    {
        writer_printf(module_writer, "%c", klas);
    }

    BlankLine ();

    strcpy (Ci.mnem, "vsect");
    strcpy (Ci.params, isRemote ? "remote" : "");
    Ci.cmd_wrd = 0;
    Ci.comment = "";
    CmdEnt = PrevEnt = 0;
    PrintLine (pseudcmd, &Ci, 'D', 0, 0);
}

int DoAsciiBlock(struct cmd_items *ci, char *buf, int bufEnd, char iClass)
{
    register int count = bufEnd;
    register char *ch = buf;
    int hasAscii = 0;

    /* It seems improbable that a string would begin with
     * NULL
     */
    if (!(isprint(*buf)) && !(isspace(*buf)))
    {
        return 0;
    }

    /* At least for the time being, skip any blocks < sizeof(int)
     * this may overlook some short strings, but it will avoid erroneous
     * identifying non-ascii numbers.
     */

    if (bufEnd <= 4)
    {
        return 0;
    }

    while (count-- > CmdEnt)
    {
        register unsigned char c;

        c = *(ch++);

        if ( !(isprint (c)) || !(isspace(c)) || (c != '\0'))
        {
            return 0;
        }

        if (isprint(c))
        {
            hasAscii = 1;
        }
    }

    if (! hasAscii)
    {
        return 0;
    }

    /* Assume that a string _MUST_ be NULL-terminated */

    if (*(--ch) != '\0')
    {
        return 0;
    }

    count = 0;

    while (PCPos < bufEnd)
    {
        char tmpbuf[30];       

        while (isprint(*buf))
        {
            if (*buf == '"')
            {
                strcpy (tmpbuf, "\""); /* To make the resets work */
                strcpy (ci->params, "'\"");
            }
            else
            {
                strncpy (tmpbuf, buf, 24);

                if (strlen(tmpbuf) >= 24)
                    tmpbuf[24] = '\0';

                sprintf (ci->params, "\"%s\"", tmpbuf);
            }


            buf += strlen(tmpbuf);
            /*siz -= strlen(tmpbuf);*/
            count += strlen(tmpbuf);
            PCPos += strlen(tmpbuf);
            PrintLine (pseudcmd, ci, iClass, CmdEnt, CmdEnt);
            CmdEnt = PCPos;
            PrevEnt = PCPos;
            ci->lblname = "";
            ci->params[0] = '\0';
        }

        while (((*buf >= 9) && (*buf <= 0x0d)) || (*buf == '\0'))
        {
            if (strlen (ci->params) >= 24)
            {
                break;
            }

            sprintf (tmpbuf, "$%d", *(buf++) & 0xff);
            
            if (strlen(ci->params))
            {
                strcat (ci->params, ",");
            }

            strcat (ci->params, tmpbuf);
            ++count;
            ++PCPos;

            if (PCPos >= bufEnd)
            {
                break;
            }
        }

        if (strlen(ci->params))
        {
            strcpy (ci->mnem, "dc.b");
            PrintLine (pseudcmd, ci, iClass, CmdEnt, CmdEnt);
            CmdEnt = PCPos;
            PrevEnt = PCPos;
            ci->lblname = "";
            ci->params[0] = '\0';
        }
    }

    return count;
}

/* *************
 * ListInitData ()
 *
 */

static void ListInitData (struct symbol_def *ldf, int nBytes, char lclass)
{
    struct cmd_items Ci;
    /*char *hexFmt;*/
    char *what = "* Initialized Data Definitions";
    struct symbol_def *curlbl, *prevlbl;

    Ci.cmd_wrd = Ci.wcount = 0;
    Ci.comment = Ci.lblname = "";
    Ci.mnem[0] =  Ci.params[0] = '\0';
    NowClass = 'D';
    PCPos = IDataBegin;        /* MovBytes/MovASC use PCPos */
    CmdEnt = PCPos;

    curlbl = findlbl('D', PCPos);
    if (!curlbl)
    {
        curlbl = addlbl('D', PCPos, "");
    }

    if (fseek(ModFP, 0x40l, SEEK_SET) != -1)
    {
        int     idatbegin,
                idatcount;

        if (fseek(ModFP, (long)fget_l(ModFP), SEEK_SET) == -1)
        {
            fprintf(stderr, "Cannot seek to Init Data Buffer\n");
            return;
        }

        idatbegin = fget_l(ModFP);
        idatcount = fget_l(ModFP);

        if (idatcount == 0)
        {
            return;
        }

        BlankLine ();

        if (IsUnformatted)
        {
            writer_printf(stdout_writer, " %s\n", what);
            ++LinNum;
        }
        else
        {
            writer_printf(stdout_writer, "%5d %s\n", LinNum++, what);
        }

        if (WrtSrc)
        {
            writer_printf(module_writer, "%s\n", what);
        }

        BlankLine ();

        AMode = 0;             /* Mode for Data             */

        curlbl = findlbl('D', idatbegin);

        while (idatcount > 0)
        {
            register int lblCount,
                         ppos;
            char         lbl[100];

            /* Get byte count for this label */
            if (!curlbl)
            {
                errexit("Null pointer dereference: curlbl in dprint.c");
            }
            prevlbl = curlbl;
            curlbl = label_getNext(curlbl);

            if (curlbl)
                lblCount = label_getMyAddr(curlbl) - label_getMyAddr(prevlbl);
            else
                lblCount = idatcount;

            if (lblCount > idatcount)
            {
                lblCount = idatcount;  /* Don't go past the end of data */
            }

            CmdEnt = PCPos;     /* Save Entry Point */
            ppos = lblCount;
            strcpy (lbl, label_getName(ldf));
            Ci.lblname = lbl;

            if (IsROF && label_getGlobal(ldf))
            {
                strcat (Ci.lblname, ":");
            }

            /* We might ought to provide for longs, but it might
            * be more confusing */
            if (lblCount & 1)
            {
                PBytSiz = 1;
                strcpy (Ci.mnem, "dc.b");
                /*hexFmt = "$%02x";*/
            }
            else
            {
                PBytSiz = 2;
                strcpy (Ci.mnem, "dc.w");
                /*hexFmt = "$%04x";*/
            }

            /*Ci.lblname = findlbl ('D', CmdEnt)->sname;
            Ci.params[0] = '\0';*/
            ppos = lblCount;

            while (lblCount > 0)
            {
                char tmp[20];
                int val;

                if ((IRefs) && (PCPos == IRefs->dAddr))
                {
                    struct symbol_def *mylbl;
                    struct ireflist *tmpref;
                    char xtrabytes[10];
                    val = 0;
                    tmp[0] = '\0';

                    xtrabytes[0] = '\0';

                    if (strlen(Ci.params))
                    {
                        OutputLine(pseudcmd, &Ci);
                        Ci.lblname = "";
                        PrintCleanup ();
                        CmdEnt = PCPos;
                        Ci.params[0] = '\0';
                    }

                    val = fget_l(ModFP);
                    PCPos += 4;
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
                        strcat (Ci.params, label_getName(mylbl));
                    }
                    else
                    {
                        sprintf (&Ci.params[strlen(Ci.params)], "$%04x", val);
                    }

                    strcpy (Ci.mnem, "dc.l");
                    OutputLine (pseudcmd, &Ci);
                    printXtraBytes (xtrabytes);
                    CmdEnt = PCPos;
                    tmpref = IRefs;
                    IRefs = IRefs->Next;
                    free(tmpref);
                    Ci.lblname = "";
                    Ci.params[0] = '\0';
                    /* Reset mnem to original status */
                    strcpy (Ci.mnem, PBytSiz == 1 ? "dc.b" : "dc.w");
                    PrintCleanup ();
                    ppos -= 4;
                    continue;
                }
                else
                {
                    switch (PBytSiz)
                    {
                    case 1:
                        sprintf (tmp, "$%02x", (fgetc(ModFP) & 0xff));
                        break;
                    case 2:
                        val = fget_w(ModFP);
                        sprintf (tmp, "$%04x", val & 0xffff);
                        break;
                    }

                    if (strlen(Ci.params))
                    {
                        strcat (Ci.params, ",");
                    }

                    strcat (Ci.params, tmp);
                    ppos -= PBytSiz;
                    PCPos += PBytSiz;
                    idatcount -= PBytSiz;
                    lblCount -= PBytSiz;

                    if (strlen(Ci.params) > 24)
                    {
                        OutputLine (pseudcmd, &Ci);
                        PrintCleanup ();
                        CmdEnt = PCPos;
                        Ci.lblname = "";
                        Ci.params[0] = '\0';
                        Ci.wcount = 0;
                    }
                }
            }

            if (strlen(Ci.params))   /* Any final cleanup */
            {
                PrevEnt = PCPos;
                OutputLine (pseudcmd, &Ci);
                CmdEnt = PCPos;
                Ci.wcount = 0;
                Ci.params[0] = '\0';
            }

            CmdEnt = PCPos;
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

void
ROFDataPrint ()
{
    struct symbol_def *srch;

    /*char dattmp[5];*/
    const char *udat = "* Uninitialized Data (Class \"%c\")";
    // TODO: Change this to add a space. The reference exe will also have to be
    // patched.
    const char *idat = "* Initialized Data (Class\"%c\")";

    InProg = 0;
    srch = labelclass('D') ? labelclass_getFirst(labelclass('D')) : NULL;
    if (srch)
    {
        dataprintHeader (udat, 'D', FALSE);

        /*first, if first entry is not D000, rmb bytes up to first */

        ListData (srch, ROFHd.statstorage, 'D');
        BlankLine();
        WrtEnds();
    }

    if (ROFHd.idatsz)
    {
        dataprintHeader(idat, '_', FALSE);

        IBuf = (char *)mem_alloc((size_t)ROFHd.idatsz + 1);

        if (fseek (ModFP, IDataBegin, SEEK_SET))
        {
            errexit ("Cannot Seek to begin of Initialized data");
        }

        if (fread(IBuf, ROFHd.idatsz, 1, ModFP) < 1)
        {
            errexit ("Cannot read Initialized data from file!");
        }

        PCPos = 0;
        srch = labelclass ('_') ? labelclass_getFirst(labelclass('_')) : NULL;

        if (ROFHd.idatsz)
        {
            ListInitROF ("", refs_idata, IBuf, ROFHd.idatsz, '_');
        }

        BlankLine();
        WrtEnds();
        /*ListInitData (srch, ROFHd.idatsz, '_');*/
        free(IBuf);
        /*ListInitROF (dta, ROFHd.idatsz, '_');*/
    }

    srch = labelclass('G') ? labelclass_getFirst(labelclass('G')) : NULL;
    if (srch)
    {
        dataprintHeader (udat, 'G', TRUE);

        /*first, if first entry is not D000, rmb bytes up to first */

        PCPos = 0;
        ListData (srch, ROFHd.remotestatsiz, 'G');
        BlankLine();
        WrtEnds();
    }

    if ((ROFHd.remoteidatsiz))
    {
        dataprintHeader(idat, 'H', TRUE);

        IBuf = (char *)mem_alloc((size_t)ROFHd.remoteidatsiz + 1);

        if (fread(IBuf, ROFHd.remoteidatsiz, 1, ModFP) < 1)
        {
            errexit ("Cannot read Remote Initialized data from file!");
        }

        PCPos = 0;
        srch = labelclass ('H') ? labelclass_getFirst(labelclass('H')) : NULL;
        ListInitROF ("", refs_iremote,IBuf, ROFHd.remoteidatsiz, 'H');
        BlankLine();
        /*ListInitData (srch, ROFHd.idatsz, 'H');*/
        free(IBuf);
        BlankLine();
        WrtEnds();
        /*ListInitROF (dta, ROFHd.idatsz, 'H');*/
    }

    InProg = 1;
    return;

    /* We compute dattyp for flexibility.  If we change the label type
     * specification all we have to do is change it in rof_class() and it
     * should work here automatically rather than hard-coding the classes
     */

    /*dattyp[2] = '\0';

    //for (vs = 0; vs < 2; vs++)
    //{
    //    dattyp[vs] = rof_class (reftyp[vs], 1);
    //}

    //if ((sizes[0]) || sizes[1])
    //{
    //    strcpy (Ci.mnem, "vsect");
    //    BlankLine();
    //    PrintLine (realcmd, &Ci, dattyp[vs], 0, 0);
    //    BlankLine();

    ////     Process each of un-init, init

    //    for (isinit = 0; isinit <= 1; isinit++)
    //    {
    //        dta = labelclass (dattyp[isinit]);

    //        sprintf (mytmp, dptell[isinit], dattyp[isinit]);

    //        if (isinit)
    //        {
    //            if (thissz[isinit])
    //            {
    //                PrintNonCmd (mytmp, 0, 1);
    //            }

    //            ListInitROF (" * Initialized data (Class %c)" ROFHd.idatsz, '_');
    //        }
    //        else
    //        {
    //            if (dta)
    //            {
    ////                 for PrintNonCmd(), send isinit so that a pre-blank
    ////                    * line is not printed, since it is provided by
    ////                    * PrinLine above

    //                if (thissz[isinit])
    //                {
    //                    PrintNonCmd (mytmp, isinit, 1);
    //                }

    //                srch = dta->cEnt;

    //                //while (srch->Next)
    //                {
    //                    srch = srch->Next;
    //                }

    //                if (srch->myaddr)
    //                {                       // i.e., if not D000
    //                    strcpy (Ci.mnem, isinit ? "dc" : "ds");
    //                    sprintf (Ci.params, "%d", srch->myaddr);
    //                    CmdEnt = PrevEnt = 0;
    //                    PrintLine (realcmd, &Ci, dattyp[isinit], 0,
    //                                                srch->myaddr);
    //                }

    //                M_Mem = sizes[isinit];
    //                ListData (dta->cEnt, sizes[isinit], dattyp[isinit]);
    //            }          // end "if (dta)"
    //            else        // else no labels.. check to see
    //            {           // if any "hidden" variables
    //                if (sizes[isinit])
    //                {
    //                    PrintNonCmd (mytmp, isinit, 1);
    //                    strcpy (Ci.mnem, "rmb");
    //                    sprintf (Ci.params, "%d", thissz[isinit]);
    //                    PrintLine (realcmd, &Ci, dattyp[isinit], 0,
    //                                                0);
    //                }
    //            }
    //        }
    //    }

    //

    //    WrtEnds();
    //}

    //dattyp += 2;
    ////thissz += 2;

    //BlankLine ();
    //InProg = 1;*/
}


/* *************
 * LoadIData() - Allocate a buffer for the Init Data list
 *       and load the data
 */

char *
LoadIData()
{
    if (!IBuf)
    {
        /* Allocate space for buffer */ 
        IBuf = (char *)mem_alloc((size_t)IDataCount + 2);

        if (fseek (ModFP, M_IData + 8, SEEK_SET))
        {
            char en[100];

            sprintf (en, "Error.. Cannot fseek() to Init Data list (%x)", M_IData + 8);
            errexit (en);
        }

        /* Read data into buffer*/
        if (fread (IBuf, 1, IDataCount, ModFP) < (unsigned)IDataCount)
        {
            errexit( "Cannot read Initialized Data bytes");
        }
    }

    return IBuf;
}

/* ************
 * OS9DataPrint()	Mainline routine to list data defs
 *
 */

void
OS9DataPrint ()
{
    struct symbol_def *dta, *srch;
    char *what = "* OS9 data area definitions";
    struct cmd_items Ci;
    long filePos = ftell (ModFP);
    
    if (!M_IData)
    {
        IDataBegin = M_Mem;
        IDataCount = 0;
    }

    InProg = 0;    /* Stop looking for Inline program labels to substitute */
    memset (&Ci, 0, sizeof (Ci));
    dta = labelclass ('D') ? labelclass_getFirst(labelclass('D')) : NULL;

    if (dta)
    {                           /* special tree for OS9 data defs */
        BlankLine ();
        
        if (IsUnformatted)
        {
            writer_printf(stdout_writer, " %22s%s\n", "", what);
            ++LinNum;
        }
        else
        {
            writer_printf(stdout_writer, "%5d %22s%s\n", LinNum++, "", what);
        }

        if (WrtSrc)
        {
            writer_printf(module_writer, "%s\n", what);
        }

        BlankLine ();

        strcpy (Ci.mnem, "vsect");
        strcpy (Ci.params, "");
        Ci.cmd_wrd = 0;
        Ci.comment = "";
        CmdEnt = PrevEnt = 0;
        PrintLine (pseudcmd, &Ci, 'D', 0, 0);

        /*first, if first entry is not D000, rmb bytes up to first */
        srch = dta;

        /*while (srch->LNext)
        {
            srch = srch->LNext;
        }*/

        if (label_getMyAddr(srch))              /* i.e., if not D000 */
        {
            strcpy (Ci.mnem, "ds.b");
            sprintf (Ci.params, "%ld", label_getMyAddr(srch));
            Ci.lblname = "";
            PrintLine (pseudcmd, &Ci, 'D', 0, label_getMyAddr(srch));
        }

        ListData (dta, IDataBegin, 'D');

        if (IDataBegin < M_Mem)
        {
            dta = findlbl('D', IDataBegin);
            if (dta)
            {
                ListInitData (dta, IDataCount, 'D');
            }
        }
    }
    else
    {
        return;
    }

    strcpy(Ci.mnem, "ends");
    strcpy (Ci.params, "");
    Ci.cmd_wrd = 0;
    Ci.comment = "";
    PrintLine (pseudcmd, &Ci, 'D', CmdEnt, CmdEnt);
    BlankLine ();
    CmdEnt = PrevEnt = 0;
    InProg = 1;
    fseek (ModFP, filePos, SEEK_SET);
}

/* ******************************************************** *
 * ListData() - recursive routine to print rmb's for Data   *
 *              definitions                                 *
 * Passed: pointer to current nlist element                 *
 *         address of upper (or calling) ListData() routine *
 *         Label cClass                                      *
 * ******************************************************** */

void ListData (struct symbol_def *me, int upadr, char cClass)
{
    struct cmd_items Ci;
    register int datasize;

    memset (&Ci, 0, sizeof (Ci));

    /* Process lower entries first */

    /*if (me->LNext)
    {
        ListData (me->LNext, label_getMyAddr(me), cClass);
    }*/

    /* Don't print non-data elements here */

    if (label_getMyAddr(me) >= upadr)
    {
        return;
    }

    /* Now we've come back, print this entry */

    /*strcpy (pbf->lbnm, me->sname);*/

    if (IsROF && label_getGlobal(me))
    {
        char* newName = strdup(label_getName(me));
        strcat (newName, ":");
        label_setName(me, newName);
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

        if (label_getMyAddr(me) >= upadr)
        {
            break;
        }

        if ((label_getNext(me)) && (label_getMyAddr(label_getNext(me)) < upadr))
        {
            datasize = label_getMyAddr(label_getNext(me)) - label_getMyAddr(me);
        }
        else
        {
            datasize = upadr - label_getMyAddr(me);
        }

        strcpy (Ci.mnem, "ds.b");
        sprintf (Ci.params, "%d", datasize);
        strcpy (lbl, label_getName(me));
        Ci.lblname = lbl;

        if (IsROF && label_getGlobal(me))
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
            if (IsROF)
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

        CmdEnt = label_getMyAddr(me);
        PrevEnt = CmdEnt;
        PrintLine (pseudcmd, &Ci, cClass, label_getMyAddr(me), (label_getMyAddr(me) + datasize));
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

void WrtEquates (int stdflg)
{
    char *claspt = "_!^ABCDEFGHIJKMNOPQRSTUVWXYZ;",
        *curnt = claspt,
        *syshd = "* OS-9 system function equates\n",
        *aschd = "* ASCII control character equates\n";
    static char *genhd[2] = { "* Class %c external label equates\n",
                      "* Class %c standard named label equates\n"
                    };
    register int flg;           /* local working flg - clone of stdflg */
    struct symbol_def *me;

    InProg = 0;
    curnt = claspt;

    if ( ! stdflg)                /* print ! and ^ only on std cClass pass */
    {
        curnt += 2;
    }

    while ((NowClass = *(curnt++)) != ';')
    {
        int minval;

        flg = stdflg;
        strcpy (ClsHd, "%5d %21s");
        me = labelclass (NowClass) ? labelclass_getFirst(labelclass(NowClass)) : NULL;

        if (me)
        {
            /* For OS9, we only want external labels this pass */

            if (NowClass == 'D')
            {
                if (stdflg)     /* Don't print data defs */
                {
                    continue;
                }

                /* Probably an error if this happens
                 * What we're doing is positioning me to
                 * last real data element*/

               /* if (!(me = FindLbl (me, M_Mem)))*/
                me = findlbl(NowClass, M_Mem);
                if (! me)
                {
                    continue;
                }
            }

            /* Don't write vsect data for ROF's */

            if ((IsROF) && stdflg && strchr ("BDGH", NowClass))
            {
                continue;
            }

            switch (NowClass)
            {
                case '!':
                    strcat (ClsHd, syshd);
                    SrcHd = syshd;
                    flg = -1;
                    break;
                case '^':
                    strcat (ClsHd, aschd);
                    SrcHd = aschd;
                    flg = -1;
                    break;
                default:
                    strcat (ClsHd, genhd[flg]);
                    SrcHd = genhd[flg];
            }

            HadWrote = 0;       /* flag header not written */

            /* Determine minimum value for printing *
             * minval will be the first value to    *
             * print                                */

            minval = 0;     /* Default to "print all" */

            if (IsROF)
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
                    minval = M_Mem + 1;
                }
                else {
                    if (NowClass == 'L')
                    {
                        minval = M_Size + 1;
                    }
                }
            }

            TellLabels (me, flg, NowClass, minval);
        }
    }

    InProg = 1;
}

/* TellLabels(me) - Print out the labels for cClass in "me" tree */

static void TellLabels (struct symbol_def *me, int flg, char cClass, int minval)
{
    struct cmd_items Ci;

    memset (&Ci, 0, sizeof (Ci));
    strcpy (Ci.mnem, "equ");
   /* if (me->LNext)
    {
        TellLabels (me->LNext, flg, cClass, minval);
    }*/
    
    while (me)
    {
        char lbl[100];

        if ((flg < 0) || (flg == label_getStdName(me)))
        {
            /* Don't print real OS9 Data variables here */

            if (label_getMyAddr(me) >= minval)
            {
                if ( ! HadWrote)
                {
                    BlankLine ();

                    if (IsUnformatted)
                    {
                        writer_printf(stdout_writer, &(ClsHd[3]), "", cClass);
                        ++LinNum;
                    }
                    else
                    {
                        writer_printf(stdout_writer, ClsHd, LinNum++, "", cClass);
                    }

                    if (module_writer)
                    {
                        writer_printf(module_writer, SrcHd, cClass);
                    }

                    HadWrote = 1;
                    BlankLine ();
                }

                strcpy (lbl, label_getName(me));
                Ci.lblname = lbl;
                Ci.cmd_wrd = label_getMyAddr(me);

                if (IsROF && label_getGlobal(me))
                {
                    strcat (Ci.lblname, ":");
                }

                if (strchr ("!^", cClass))
                {
                    sprintf (Ci.params, "$%02lx", label_getMyAddr(me));
                }
                else
                {
                    sprintf (Ci.params, "$%05lx", label_getMyAddr(me));
                }

                CmdEnt = PrevEnt = label_getMyAddr(me);
                PrintLine (pseudcmd, &Ci, cClass, label_getMyAddr(me), label_getMyAddr(me) + 1);
            }
        }

        me = label_getNext(me);
       /* if (me->RNext)
        {
            TellLabels (me->RNext, flg, cClass, minval);
        }*/
    }
}
