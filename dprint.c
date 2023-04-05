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
#include "proto.h"

#ifdef _WIN32
#   define snprintf _snprintf
#endif


#define CNULL '\0'

static void BlankLine();

#ifdef __STDC__
static void PrintFormatted (char *pfmt, CMD_ITMS *ci);
static void NonBoundsLbl (char cClass);
static void TellLabels (LBLDEF *me, int flg, char cClass, int minval);
#else
static void PrintFormatted ();
static void NonBoundsLbl ();
static void PrintComment();
static void TellLabels ();
#endif

extern char *CmdBuf;
/*extern struct printbuf *pbuf;*/
extern struct rof_hdr ROFHd;

char pseudcmd[80] = "%5d  %05x %04x %-10s %-6s %-10s %s\n";
char realcmd[80] =  "%5d  %05x %04x %-9s %-10s %-6s %-10s %s\n";
char allcodcmd[80] = "%5d        %04x %04x\n";
char *xtraFmt = "             %s\n";
char allcodcmd1[80] ="%5d        %04x\n";
char *blankcmd = "%5d";

int PrevEnt = 0;                /* Previous CmdEnt - to print non-boundary labels */
int InProg;                     /* Flag that we're in main program, so that it won't
                                   munge the label name */
static char ClsHd[100];         /* header string for label equates */
static char FmtBuf[200];        /* Buffer to store formatted string */
int HadWrote;                   /* flag that header has been written */
char *SrcHd;                    /* ptr for header for source file */
char *IBuf;                     /* Pointer to buffer containing the Init Data values */


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

/* *************************************************************** *
 * adjpscmd () - Adjusts pseudcmd/realcmd label length to          *
 *              NamLen + 2                                         *
 * *************************************************************** */

/*void
adjpscmd (void)
{
    sprintf (pseudcmd, "%s%d%s\n", "%5d  %04X %-14s %-",
                                   NamLen + 2,
                                   "s %-6s %-10s %s");
    sprintf (realcmd, "%s%d%s\n", "%5d  %04X %-04s %-9s %-",
                                  NamLen + 2,
                                  "s %-6s %-10s %s");
}*/

void
tabinit ()
{
    strcpy (realcmd, "%5d\t%04X\t%s\t%s\t%s\t%s\t%s\n");
    strcpy (pseudcmd, "%5d\t%04X\t%s\t\t%s\t%s\t%s\n");
}

void
#ifdef __STDC__
PrintAllCodLine (int w1, int w2)
#else
PrintAllCodLine (w1, w2)
    int w1, w2;
#endif
{
    if (IsUnformatted)
    {
        printf (&(allcodcmd[3]), w1 & 0xffff, w2 & 0xffff);
        ++LinNum;
    }
    else
    {
        printf (allcodcmd, LinNum++, w1 & 0xffff, w2 & 0xffff);
    }
}

void
#ifdef __STDC__
PrintAllCodL1 (int w1)
#else
PrintAllCodL1 (w1)
    int w1;
#endif
{
    if (IsUnformatted)
    {
        printf (&(allcodcmd1[3]), w1 & 0xffff);
        ++LinNum;
    }
    else
    {
        printf (allcodcmd1, LinNum++, w1 & 0xffff);
    }
}

/* **********
 * PrintPsect() - Set up the Psect for printout
 *
 */

void
PrintPsect()
{
    char *ProgType = NULL;
    char *ProgLang = NULL;
    char ProgAtts[50];
    /*char *StackAddL;*/
    int c;
    CMD_ITMS Ci;
    int pgWdthSave;

    Ci.comment = "";
    strcpy (Ci.mnem, "set");
    BlankLine();

    /* Module name */
    if (strrchr(ModFile, PATHSEP))
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
    sprintf (Ci.opcode, "$%x", M_Type);
    PrintLine(pseudcmd, &Ci, CNULL, 0, 0);
    /*hdrvals[0] = M_Type;*/
    ProgLang = modnam_find (ModLangs, (unsigned char)M_Lang)->name;
    Ci.lblname = ProgLang;
    Ci.cmd_wrd = M_Lang;
    sprintf (Ci.opcode, "$%02x", M_Lang);
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
            sprintf (Ci.opcode, "$%02x",ModAtts[c].val);
            PrintLine (pseudcmd, &Ci, CNULL, 0, 0); 
        }
    }

    /*prgsets[0] = ProgType; prgsets[1] = ProgLang;
    prgsets[2] = ProgAtts; prgsets[3] = NULL;*/
    /*ProgAtts = modnam_find (ModAtts, (unsigned char)M_Attr)->name;*/
    /*hdrvals[2] = M_Attr;

    for (c = 0; prgsets[c]; c++)
    {
        if (prgsets[c])
        {
            Ci.cmd_wrd = hdrvals[c];
            sprintf (Ci.opcode, "$%02x", hdrvals[c]);
            Ci.lblname = prgsets[c];
            PrintLine (pseudcmd, &Ci, CNULL, 0, 0); 
        }
        else {
            sprintf (Ci.mnem, "$%02x", hdrvals[c]);
        }

        sprintf (Ci.opcode, psecfld[c % 2], prgsets[c]);
        strcat (EaString, Ci.opcode);
    }

    sprintf (&EaString[strlen(EaString)], "|%d)", M_Revs);*/
    sprintf (&EaString[strlen(EaString)], ",(%s<<8)|%d", ProgAtts, M_Revs);
    sprintf (&EaString[strlen(EaString)], ",%d", M_Edit);
    strcat (EaString, ",0");    /* For the time being, don't add any stack */
    sprintf (&EaString[strlen(EaString)], ",%s", findlbl ('L', M_Exec)->sname);

    if (M_Except)
    {
        LBLDEF *excep = findlbl('L', M_Except);
        strcat(EaString, ",");
        strcat(EaString, excep->sname);
    }

    strcpy (Ci.opcode, EaString);
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

static void
#ifdef __STDC__
OutputLine (char *pfmt, CMD_ITMS *ci)
#else
OutputLine (pfmt, ci)
char *pfmt; CMD_ITMS *ci;
#endif
{
    LBLDEF *nl;
    char lbl[100];

    if (  InProg &&
        (nl = findlbl ('L', CmdEnt)))
    {
        strcpy (lbl, nl->sname);
        ci->lblname = lbl;

        if (IsROF && nl->global)
        {
            strcat (lbl, ":");
        }
    }

    PrintFormatted (pfmt, ci);

    if (WrtSrc)
    {
        fprintf (AsmPath, "%s %s %s", ci->lblname, ci->mnem, ci->opcode);

        if (ci->comment && strlen (ci->comment))
        {
            fprintf (AsmPath, " %s", ci->comment);
        }

        fprintf (AsmPath, "\n");
    }
}

    /* Straighten/clean up - prepare for next line  */

static void
PrintCleanup ()
{
    PrevEnt = CmdEnt;

    /*CmdLen = 0;*/
    ++LinNum;
}

static void
BlankLine ()                    /* Prints a blank line */
{
    if (IsUnformatted)
    {
        return;
    }

    printf ("%5d\n", LinNum++);

    if (WrtSrc)
    {
        fprintf (AsmPath, "\n");
    }
}

/* ************************************************************ *
 * PrintNonCmd() - A utility function to print any non-command  *
 *          line (except stored comments).                      *
 *          Prints the line with line number, and updates       *
 *          PgLin & LinNum                                      *
 * Passed: str - the string to print                            *
 *         preblank - true if blankline before str              *
 *         postblank - true if blankline after str              *
 * ************************************************************ */

/*static void
#ifdef __STDC__
PrintNonCmd (char *str, int preblank, int postblank)
#else
PrintNonCmd (str, preblank, postblank)
    char *str; int preblank; int postblank;
#endif
{
    if (IsROF)
    {
        if (preblank)
        {
            BlankLine();
        }

        if (IsUnformatted)
        {
            printf (" %s\n", str);
            ++LinNum;
        }
        else
        {
            printf ("%5d %s\n", LinNum, str);
        }

        if (WrtSrc)
        {
            fprintf (AsmPath, "%s", str);
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

char *
#ifdef __STDC__
get_apcomment(char clas, int addr)
#else
get_apcomment (clas, addr)
    char clas;
    int addr;
#endif
{
    struct apndcmnt *mytree = CmntApnd[strpos (lblorder, clas)];

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

void
#ifdef __STDC__
PrintLine (char *pfmt, CMD_ITMS *ci, char cClass, int cmdlow, int cmdhi)
#else
PrintLine (pfmt, ci, cClass, cmdlow, cmdhi)
    char *pfmt;
    CMD_ITMS *ci;
    char cClass;
    int cmdlow,
        cmdhi;
#endif
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

/*static void
#ifdef __STDC__
UpString (char *s)              // Translate a string to uppercase
#else
UpString (s)
    char *s;
#endif
{
    register int x = strlen (s);

    while (x--)
    {
        if (isalpha (*s))
            *s = toupper (*s);
        ++s;
    }
} */

/* *********************************************** *
 * UpPbuf() - Translates a whole print buffer's    *
 *            contents to upper case, if UpCase    *
 * Passed: Pointer to the print buffer to UpCase   *
 * *********************************************** */

/*static void
UpPbuf (struct printbuf *pb)
{
    if (UpCase)
    {
        UpString (pb->instr);
        UpString (pb->opcod);
        UpString(pb->lbnm);
        UpString (pb->mnem);
        UpString(pb->operand);
    }
}*/

static void
#ifdef __STDC__
PrintFormatted (char *pfmt, CMD_ITMS *ci)
#else
PrintFormatted (pfmt, ci)
    char *pfmt; CMD_ITMS *ci;
#endif
{
    int _linlen;

    /*if (UpCase)
    {
        UpPbuf (pb);
    }*/

    /* make sure any non-initialized fields don't create Segfault */

    if ( ! ci->lblname)    ci->lblname = "";
    /*if ( ! ci->mnem)        strcpy(ci->mnem, "");
    if ( ! ci->opcode)     strcpy(ci->opcode, "");*/
    if ( ! ci->comment)     ci->comment = "";

    if (pfmt == pseudcmd)
    {
#ifdef _OSK
        if (IsUnformatted)
        {
            _linlen = sprintf (FmtBuf, &(pfmt[3]),
                                    CmdEnt, ci->cmd_wrd, ci->lblname,
                                        ci->mnem, ci->opcode, ci->comment);
        }
        else
        {
            _linlen = sprintf (FmtBuf, pfmt,
                                    LinNum, CmdEnt, ci->cmd_wrd, ci->lblname,
                                        ci->mnem, ci->opcode, ci->comment);
        }

        if (_linlen > PgWidth - 2)
        {
            FmtBuf[PgWidth - 2] = '\0';
         }
#else
        if (IsUnformatted)
        {
            _linlen = snprintf (FmtBuf, PgWidth - 2, &(pfmt[3]),
                                    CmdEnt, ci->cmd_wrd, ci->lblname,
                                    ci->mnem, ci->opcode, ci->comment);
        }
        else
        {
            _linlen = snprintf (FmtBuf, PgWidth - 2, pfmt,
                                    LinNum, CmdEnt, ci->cmd_wrd, ci->lblname,
                                    ci->mnem, ci->opcode, ci->comment);
        }
#endif
    }
    else
    {
#ifdef _OSK
        if (IsUnformatted)
        {
            _linlen = sprintf (FmtBuf, &(pfmt[3]),
                                CmdEnt, ci->cmd_wrd, ci->lblname,
                                ci->mnem, ci->opcode, "");
        }
        else
        {
            _linlen = sprintf (FmtBuf, pfmt,
                                LinNum, CmdEnt, ci->cmd_wrd, ci->lblname,
                                ci->mnem, ci->opcode, "");
        }

        if (_linlen > PgWidth - 2)
        {
            FmtBuf[PgWidth - 2] = '\0';
        }
#else
        if (IsUnformatted)
        {
            _linlen = snprintf (FmtBuf, PgWidth - 2, &(pfmt[3]),
                                CmdEnt, ci->cmd_wrd, ci->lblname,
                                ci->mnem, ci->opcode, ci->comment);
        }
        else
        {
            _linlen = snprintf (FmtBuf, PgWidth - 2, pfmt,
                                LinNum, CmdEnt, ci->cmd_wrd, ci->lblname,
                                ci->mnem, ci->opcode, ci->comment);
        }
#endif
    }

    if ((_linlen >= PgWidth - 2) || (_linlen < 0))
    {
        FmtBuf[PgWidth - 3] = '\n';
        FmtBuf[PgWidth - 2] = '\0';
    }

    printf ("%s", FmtBuf);
    fflush (stdout);
}

/* **************************************************************** *
 * Print additional data bytes in line following main line          *
 * **************************************************************** */

void
#ifdef __STDC__
printXtraBytes (char *data)
#else
printXtraBytes (data)
char *data;
#endif
{
    if (strlen (data))
    {
        printf (xtraFmt, data);
        data[0] = '\0';     /* Reset data to empty string */
    }
}

/*
 * PrintComment() -Print any comments appropriate
 *
 */

void
#ifdef __STDC__
PrintComment(char lblcClass, int cmdlow, int cmdhi)
#else
PrintComment(lblcClass, cmdlow, cmdhi)
    char lblcClass; int cmdlow, cmdhi;
#endif
{
    register struct commenttree *me;
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
                    struct cmntline *line;

                    line = me->commts;

                    do {
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
                            fprintf (AsmPath, "* %s\n", line->ctxt);
                        }

                    } while ((line = line->nextline));

                    break;  /* This address done, proceed with next x */
                }
            }
        }
    }
}

static void
#ifdef __STDC__
NonBoundsLbl (char cClass)
#else
    NonBoundsLbl(cClass)
    char cClass;
#endif
{
    if (cClass)
    {
        register int x;
        CMD_ITMS Ci;
        register LBLDEF *nl;

        strcpy (Ci.mnem, "equ");
        Ci.comment = "";

        for (x = PrevEnt + 1; x < CmdEnt; x++)
        {

            if ((nl = findlbl (cClass, x)))
            {
                char lbl[100];
                strcpy (lbl, nl->sname);
                Ci.lblname = lbl;

                if (IsROF && nl->global)
                {
                    strcat (Ci.lblname, ":");
                }

                if (x > CmdEnt)
                {
                    sprintf (Ci.opcode, "*+%d", x - CmdEnt);
                }
                else
                {
                    sprintf (Ci.opcode, "*-%d", CmdEnt - x);
                }

                /*PrintLine (pseudcmd, &Ci, cClass, CmdEnt, PCPos);*/
                if (IsUnformatted)
                {
                    printf (&(pseudcmd[3]), nl->myaddr, Ci.cmd_wrd,
                            Ci.lblname, Ci.mnem, Ci.opcode, "");
                }
                else
                {
                    printf (pseudcmd, LinNum++, nl->myaddr, Ci.cmd_wrd,
                            Ci.lblname, Ci.mnem, Ci.opcode, "");
                }

                if (WrtSrc)
                {
                    fprintf (AsmPath, "%s %s %s\n", Ci.lblname, Ci.mnem,
                             Ci.opcode);
                }
            }
        }
    }
}

/* ****************************** *
 * RsOrg() - print RSDos org line *
 * ****************************** */

/* ********************************************* *
 * ROFPsect() - writes out psect                 *
 * Passed: rof_hdr *rptr                         *
 * ********************************************* */

/*#define OPSCAT(str) sprintf (ci->opcode, "%s,%s", pbuf->operand, str)
#define OPDCAT(nu) sprintf (ci->opcode, "%s,%d", pbuf->operand, nu)
#define OPHCAT(nu) sprintf (pbuf->operand, "%s,%04x", pbuf->operand, nu)*/

void
#ifdef __STDC__
ROFPsect (struct rof_hdr *rptr)
#else
ROFPsect (rptr)
    struct rof_hdr *rptr;
#endif
{
    LBLDEF *nl;
    CMD_ITMS Ci;

    memset (&Ci, 0, sizeof(CMD_ITMS));
    /*strcpy (Ci.instr, "");*/
    strcpy (Ci.opcode, "");
    Ci.lblname = "";
    strcpy (Ci.mnem, "psect");
    sprintf (Ci.opcode, "%s,$%x,$%x,%d,%d,", rptr->rname,
                                                rptr->ty_lan >> 8,
                                                rptr->ty_lan & 0xff,
                                                rptr->edition,
                                                rptr->stksz
            );
/*#define OPSCAT(str) sprintf (ci->opcode, "%s,%s", pbuf->operand, str)
#define OPDCAT(nu) sprintf (ci->opcode, "%s,%d", pbuf->operand, nu)
#define OPHCAT(nu) sprintf (pbuf->operand, "%s,%04x", pbuf->operand, nu)*/

    if ((nl = findlbl('L', rptr->code_begin)))
    {
        strcat(Ci.opcode, nl->sname);
        /*OPSCAT(nl->sname);*/
    }
    else
    {
        char oc[10];

        sprintf(oc, "$%04x", rptr->code_begin);
        strcat(Ci.opcode, oc);
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
    CMD_ITMS Ci;

    memset (&Ci, 0, sizeof (Ci));
    strcpy (Ci.mnem, "ends");

    BlankLine();
    CmdEnt = PCPos;     /* This should always work */
    PrintFormatted (pseudcmd, &Ci);

    if (WrtSrc)
    {
        fprintf (AsmPath, "%s %s %s\n", "", "ends", "");
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
} *IRefs;

/* *******
 * ParseIRefs() - Parse through the Initialized Refs list for either
 *    class 'D' or 'L'.
 *    Insert appropriate labels into Label Trees and the
 *    IRef table.
 */

void
#ifdef __STDC__
ParseIRefs(char rClass)
#else
ParseIRefs(rClass)
    char rClass;
#endif
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

static void
#ifdef __STDC__
dataprintHeader(char *hdr, char klas)
#else
dataprintHeader(hdr, klas)
    char *hdr; char klas;
#endif
{
    CMD_ITMS Ci;

    BlankLine();
    memset (&Ci, 0, sizeof (Ci));

    if (IsUnformatted)
    {
        printf (hdr, klas);
        ++LinNum;
    }
    else
    {
        char f_fmt[100];

        sprintf (f_fmt, "%%5d %s", hdr);
        printf (f_fmt, LinNum++, klas);
    }

    if (WrtSrc)
    {
        fprintf (AsmPath, "%c", klas);
    }

    BlankLine ();

    strcpy (Ci.mnem, "vsect");
    strcpy (Ci.opcode, "");
    Ci.cmd_wrd = 0;
    Ci.comment = "";
    CmdEnt = PrevEnt = 0;
    PrintLine (pseudcmd, &Ci, 'D', 0, 0);
}

int
#ifdef __STDC__
DoAsciiBlock(CMD_ITMS *ci, char *buf, int bufEnd, char iClass)
#else
DoAsciiBlock(ci, buf, bufEnd, iClass)
    CMD_ITMS *ci; char *buf; int bufEnd; char iClass;
#endif
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
                strcpy (ci->opcode, "'\"");
            }
            else
            {
                strncpy (tmpbuf, buf, 24);

                if (strlen(tmpbuf) >= 24)
                    tmpbuf[24] = '\0';

                sprintf (ci->opcode, "\"%s\"", tmpbuf);
            }


            buf += strlen(tmpbuf);
            /*siz -= strlen(tmpbuf);*/
            count += strlen(tmpbuf);
            PCPos += strlen(tmpbuf);
            PrintLine (pseudcmd, ci, iClass, CmdEnt, CmdEnt);
            CmdEnt = PCPos;
            PrevEnt = PCPos;
            ci->lblname = "";
            ci->opcode[0] = '\0';
        }

        while (((*buf >= 9) && (*buf <= 0x0d)) || (*buf == '\0'))
        {
            if (strlen (ci->opcode) >= 24)
            {
                break;
            }

            sprintf (tmpbuf, "$%d", *(buf++) & 0xff);
            
            if (strlen(ci->opcode))
            {
                strcat (ci->opcode, ",");
            }

            strcat (ci->opcode, tmpbuf);
            ++count;
            ++PCPos;

            if (PCPos >= bufEnd)
            {
                break;
            }
        }

        if (strlen(ci->opcode))
        {
            strcpy (ci->mnem, "dc.b");
            PrintLine (pseudcmd, ci, iClass, CmdEnt, CmdEnt);
            CmdEnt = PCPos;
            PrevEnt = PCPos;
            ci->lblname = "";
            ci->opcode[0] = '\0';
        }
    }

    return count;
}

/* *************
 * ListInitData ()
 *
 */

static void
#ifdef __STDC__
ListInitData (LBLDEF *ldf, int nBytes, char lclass)
#else
ListInitData (ldf, nBytes, lclass)
    LBLDEF *ldf; int nBytes; char lclass;
#endif
{
    CMD_ITMS Ci;
    /*char *hexFmt;*/
    char *what = "* Initialized Data Definitions";
    LBLDEF *curlbl;

    Ci.cmd_wrd = Ci.wcount = 0;
    Ci.comment = Ci.lblname = "";
    Ci.mnem[0] =  Ci.opcode[0] = '\0';
    NowClass = 'D';
    PCPos = IDataBegin;        /* MovBytes/MovASC use PCPos */
    CmdEnt = PCPos;

    if (!(curlbl = findlbl('D', PCPos)))
    {
        curlbl = addlbl('D', PCPos, "");
    }

    if (fseek(ModFP, 0x40l, SEEK_SET) != -1)
    {
        int     idatbegin,
                idatcount;
        LBLDEF *curlbl;

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
            printf (" %s\n", what);
            ++LinNum;
        }
        else
        {
            printf ("%5d %s\n", LinNum++, what);
        }

        if (WrtSrc)
        {
            fprintf (AsmPath, "%s\n", what);
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
            curlbl = curlbl->Next;

            if (curlbl)
                lblCount = curlbl->myaddr - curlbl->Prev->myaddr;
            else
                lblCount = idatcount;

            if (lblCount > idatcount)
            {
                lblCount = idatcount;  /* Don't go past the end of data */
            }

            CmdEnt = PCPos;     /* Save Entry Point */
            ppos = lblCount;
            strcpy (lbl, ldf->sname);
            Ci.lblname = lbl;

            if (IsROF && ldf->global)
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
            Ci.opcode[0] = '\0';*/
            ppos = lblCount;

            while (lblCount > 0)
            {
                char tmp[20];
                int val;

                if ((IRefs) && (PCPos == IRefs->dAddr))
                {
                    LBLDEF *mylbl;
                    struct ireflist *tmpref;
                    char xtrabytes[10];
                    val = 0;
                    tmp[0] = '\0';

                    xtrabytes[0] = '\0';

                    if (strlen(Ci.opcode))
                    {
                        OutputLine(pseudcmd, &Ci);
                        Ci.lblname = "";
                        PrintCleanup ();
                        CmdEnt = PCPos;
                        Ci.opcode[0] = '\0';
                    }

                    val = fget_l(ModFP);
                    PCPos += 4;
                    lblCount -= 4;
                    idatcount -= 4;

                    if (!findlbl('L', val))
                    {
                        addlbl('L', val, NULL);
                    }

                    if (strlen(Ci.opcode))
                    {
                        strcat(Ci.opcode, ",");
                    }

                    if ((mylbl = findlbl('L', val)))
                    {
                        strcat (Ci.opcode, mylbl->sname);
                    }
                    else
                    {
                        sprintf (&Ci.opcode[strlen(Ci.opcode)], "$%04x", val);
                    }

                    strcpy (Ci.mnem, "dc.l");
                    OutputLine (pseudcmd, &Ci);
                    printXtraBytes (xtrabytes);
                    CmdEnt = PCPos;
                    tmpref = IRefs;
                    IRefs = IRefs->Next;
                    free(tmpref);
                    Ci.lblname = "";
                    Ci.opcode[0] = '\0';
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

                    if (strlen(Ci.opcode))
                    {
                        strcat (Ci.opcode, ",");
                    }

                    strcat (Ci.opcode, tmp);
                    ppos -= PBytSiz;
                    PCPos += PBytSiz;
                    idatcount -= PBytSiz;
                    lblCount -= PBytSiz;

                    if (strlen(Ci.opcode) > 24)
                    {
                        OutputLine (pseudcmd, &Ci);
                        PrintCleanup ();
                        CmdEnt = PCPos;
                        Ci.lblname = "";
                        Ci.opcode[0] = '\0';
                        Ci.wcount = 0;
                    }
                }
            }

            if (strlen(Ci.opcode))   /* Any final cleanup */
            {
                PrevEnt = PCPos;
                OutputLine (pseudcmd, &Ci);
                CmdEnt = PCPos;
                Ci.wcount = 0;
                Ci.opcode[0] = '\0';
            }

            CmdEnt = PCPos;
            idatcount -= lblCount;
            ldf = ldf->Next;
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
    LBLDEF *srch;

    /*char dattmp[5];*/
    register char *udat = "* Uninitialized data (Class %c)";
    char *idat = "* Initialized data (Class %c)";

    InProg = 0;

    if ((srch = labelclass ('D') ? labelclass('D')->cEnt : NULL))
    {
        dataprintHeader ("* Uninitialized Data (Class \"%c\")", 'D');

        /*first, if first entry is not D000, rmb bytes up to first */

        ListData (srch, ROFHd.statstorage, 'D');
        BlankLine();
        WrtEnds();
    }

    if (ROFHd.idatsz)
    {
        dataprintHeader("* Initialized Data (Class\"%c\")", '_');

        IBuf = (char *)mem_alloc(ROFHd.idatsz + 1);

        if (fseek (ModFP, IDataBegin, SEEK_SET))
        {
            errexit ("Cannot Seek to begin of Initialized data");
        }

        if (fread(IBuf, ROFHd.idatsz, 1, ModFP) < 1)
        {
            errexit ("Cannot read Initialized data from file!");
        }

        PCPos = 0;
        srch = labelclass ('_') ? labelclass('_')->cEnt : NULL;

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

    if ((srch = labelclass ('G') ? labelclass('G')->cEnt : NULL))
    {
        dataprintHeader (udat, 'G');

        /*first, if first entry is not D000, rmb bytes up to first */

        PCPos = 0;
        ListData (srch, ROFHd.remotestatsiz, 'G');
        BlankLine();
        WrtEnds();
    }

    if ((ROFHd.remoteidatsiz))
    {
        dataprintHeader(idat, 'H');

        IBuf = (char *)mem_alloc(ROFHd.remoteidatsiz + 1);

        if (fread(IBuf, ROFHd.idatsz, 1, ModFP) < 1)
        {
            errexit ("Cannot read Initialized data from file!");
        }

        PCPos = 0;
        srch = labelclass ('H') ? labelclass('H')->cEnt : NULL;
        ListInitROF ("", refs_iremote,IBuf, ROFHd.idatsz, 'H');
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
    //                    sprintf (Ci.opcode, "%d", srch->myaddr);
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
    //                    sprintf (Ci.opcode, "%d", thissz[isinit]);
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
        IBuf = (char *)mem_alloc(IDataCount + 2);

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
    LBLDEF *dta, *srch;
    char *what = "* OS9 data area definitions";
    CMD_ITMS Ci;
    long filePos = ftell (ModFP);
    
    if (!M_IData)
    {
        IDataBegin = M_Mem;
        IDataCount = 0;
    }

    InProg = 0;    /* Stop looking for Inline program labels to substitute */
    memset (&Ci, 0, sizeof (Ci));
    dta = labelclass ('D') ? labelclass('D')->cEnt : NULL;

    if (dta)
    {                           /* special tree for OS9 data defs */
        BlankLine ();
        
        if (IsUnformatted)
        {
            printf (" %22s%s\n", "", what);
            ++LinNum;
        }
        else
        {
            printf ("%5d %22s%s\n", LinNum++, "", what);
        }

        if (WrtSrc)
        {
            fprintf (AsmPath, "%s\n", what);
        }

        BlankLine ();

        strcpy (Ci.mnem, "vsect");
        strcpy (Ci.opcode, "");
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

        if (srch->myaddr)              /* i.e., if not D000 */
        {
            strcpy (Ci.mnem, "ds.b");
            sprintf (Ci.opcode, "%ld", srch->myaddr);
            Ci.lblname = "";
            PrintLine (pseudcmd, &Ci, 'D', 0, srch->myaddr);
        }

        ListData (dta, IDataBegin, 'D');

        if (IDataBegin < M_Mem)
        {
            if ((dta = findlbl('D', IDataBegin)))
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
    strcpy (Ci.opcode, "");
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

void
#ifdef __STDC__
ListData (LBLDEF *me, int upadr, char cClass)
#else
ListData (me, upadr, cClass)
    LBLDEF *me; int upadr; char cClass;
#endif
{
    CMD_ITMS Ci;
    register int datasize;

    memset (&Ci, 0, sizeof (Ci));

    /* Process lower entries first */

    /*if (me->LNext)
    {
        ListData (me->LNext, me->myaddr, cClass);
    }*/

    /* Don't print non-data elements here */

    if (me->myaddr >= upadr)
    {
        return;
    }

    /* Now we've come back, print this entry */

    /*strcpy (pbf->lbnm, me->sname);*/

    if (IsROF && me->global)
    {
        strcat (me->sname, ":");
    }

    /*if (me->RNext)
    {
        srch = me->RNext;*/       /* Find smallest entry in that list */

        /*while (srch->LNext)
        {
            srch = srch->LNext;
        }

        datasize = (srch->myaddr) - (me->myaddr);
    }
    else
    {
        datasize = (upadr) - (me->myaddr);
    }*/

    /* Don't print any Class 'D' variables which are not in Data area */
    /* Note, Don't think we'll get this far, we have a return up above,
     * but keep this one till we know it works

    if ((OSType == OS_9) && (me->myaddr > M_Mem))
    {
        return;
    }*/

    while (me)
    {
        char lbl[100];

        if (me->myaddr >= upadr)
        {
            break;
        }

        if ((me->Next) && (me->Next->myaddr < upadr))
        {
            datasize = me->Next->myaddr - me->myaddr;
        }
        else
        {
            datasize = upadr - me->myaddr;
        }

        strcpy (Ci.mnem, "ds.b");
        sprintf (Ci.opcode, "%d", datasize);
        strcpy (lbl, me->sname);
        Ci.lblname = lbl;

        if (IsROF && me->global)
        {
            strcat(Ci.lblname, ":");
        }
        /*if (me->myaddr != upadr)
        {
            strcpy (Ci.mnem, "ds.b");
            sprintf (Ci.opcode, "%d", datasize);
            Ci.lblname = me->sname;
        }
        else
        {
            if (IsROF)
            {
                strcpy (Ci.mnem, "ds.b");
                sprintf (Ci.opcode, "%d", datasize);
            }
            else
            {
                strcpy (Ci.mnem, "ds.b");
                strcpy (Ci.opcode, "ds.b");
            }
        }*/

        CmdEnt = me->myaddr;
        PrevEnt = CmdEnt;
        PrintLine (pseudcmd, &Ci, cClass, me->myaddr, (me->myaddr + datasize));
        me = me->Next;

        /*if (me->RNext && (me->myaddr < M_Mem))
        {
            ListData (me->RNext, upadr, cClass);
        }*/
    }
}

/* ************************************************** *
 * WrtEquates() - Print out label defs                *
 * Passed: stdflg - 1 for std labels, 0 for externals *
 * ************************************************** */

void
#ifdef __STDC__
WrtEquates (int stdflg)
#else
WrtEquates (stdflg)
    int stdflg;
#endif
{
    char *claspt = "_!^ABCDEFGHIJKMNOPQRSTUVWXYZ;",
        *curnt = claspt,
        *syshd = "* OS-9 system function equates\n",
        *aschd = "* ASCII control character equates\n";
    static char *genhd[2] = { "* Class %c external label equates\n",
                      "* Class %c standard named label equates\n"
                    };
    register int flg;           /* local working flg - clone of stdflg */
    LBLDEF *me;

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
        me = labelclass (NowClass) ? labelclass (NowClass)->cEnt : NULL;

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
                if (! (me = findlbl (NowClass, M_Mem)))
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

static void
#ifdef __STDC__
TellLabels (LBLDEF *me, int flg, char cClass, int minval)
#else
TellLabels (me, flg, cClass, minval)
    LBLDEF *me;
    int flg;
    char cClass;
    int minval;
#endif
{
    CMD_ITMS Ci;

    memset (&Ci, 0, sizeof (Ci));
    strcpy (Ci.mnem, "equ");
   /* if (me->LNext)
    {
        TellLabels (me->LNext, flg, cClass, minval);
    }*/
    
    while (me)
    {
        char lbl[100];

        if ((flg < 0) || (flg == me->stdname))
        {
            /* Don't print real OS9 Data variables here */

            if (me->myaddr >= minval)
            {
                if ( ! HadWrote)
                {
                    BlankLine ();

                    if (IsUnformatted)
                    {
                        printf (&(ClsHd[3]), "", cClass);
                        ++LinNum;
                    }
                    else
                    {
                        printf (ClsHd, LinNum++, "", cClass);
                    }

                    if (AsmPath)
                    {
                        fprintf (AsmPath, SrcHd, cClass);
                    }

                    HadWrote = 1;
                    BlankLine ();
                }

                strcpy (lbl, me->sname);
                Ci.lblname = lbl;
                Ci.cmd_wrd = me->myaddr;

                if (IsROF && me->global)
                {
                    strcat (Ci.lblname, ":");
                }

                if (strchr ("!^", cClass))
                {
                    sprintf (Ci.opcode, "$%02lx", me->myaddr);
                }
                else
                {
                    sprintf (Ci.opcode, "$%05lx", me->myaddr);
                }

                CmdEnt = PrevEnt = me->myaddr;
                PrintLine (pseudcmd, &Ci, cClass, me->myaddr, me->myaddr + 1);
            }
        }

        me = me->Next;
       /* if (me->RNext)
        {
            TellLabels (me->RNext, flg, cClass, minval);
        }*/
    }
}
