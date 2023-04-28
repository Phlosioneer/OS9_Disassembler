/* ************************************************************************ *
 *                                                                          *
 * os9disasm - a project to disassemble Os9-coco modules into source code   *
 *             following the example of Dynamite+                           *
 *                                                                          *
 * ************************************************************************ *
 *                                                                          *
 *  Edition History:                                                        *
 *  #  Date       Comments                                              by  *
 *  -- ---------- -------------------------------------------------     --- *
 *  01 2003/01/31 First began project                                   dlb *
 * ************************************************************************ *
 * File:  cmdfile.c                                                         *
 * Purpose: process command file                                            *
 *                                                                          *
 * ************************************************************************ *
 *                                                                          *
 * Copyright (c) 2017 David Breeding                                        *
 *                                                                          *
 * This file is part of osk-disasm.                                         *
 *                                                                          *
 * osk-disasm is free software: you can redistribute it and/or modify       *
 * it under the terms of the GNU General Public License as published by     *
 * the Free Software Foundation, either version 3 of the License, or        *
 * (at your option) any later version.                                      *
 *                                                                          *
 * osk-disasm is distributed in the hope that it will be useful,            *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
 * GNU General Public License for more details.                             *
 *                                                                          *
 * You should have received a copy of the GNU General Public License        *
 * (see the file "COPYING") along with osk-disasm.  If not,                 *
 * see <http://www.gnu.org/licenses/>.                                      *
 *                                                                          *
 * ************************************************************************ */

//#define _GNU_SOURCE     /* Needed to get isblank() defined */
#include "cmdfile.h"
#include "commonsubs.h"
#include "disglobs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "label.h"
#include "main_support.h"
#include "structs.h"
#include "userdef.h"
#include <ctype.h>
#include <stdio.h>
#include <string.h>
/*#include "amodes.h"*/

struct data_bounds* LAdds[33]; /* Temporary */
struct data_bounds* dbounds;
static const char BoundsNames[] = "ABCDLSW";

static int NxtBnd;
static int NoEnd; /* Flag that no end on last bound                 */
static struct data_bounds* prevbnd;

static char* cpyhexnum(char* dst, char* src);
static char* cpy_digit_str(char* dst, char* src);
static int do_mode(char* lpos, int GettingAmode, char* defaultLabelClasses);
static char* setoffset(char* p, struct offset_tree* oft);
static int optincmd(char* lpos, struct options* opt);
static int cmdamode(char* pt, char* defaultLabelClasses, int defaultMode);
static struct comment_tree* newcomment(int addrs, struct comment_tree* parent);

static void errexitFromCmdfile(char* msg)
{
    char errtxt[100];
    sprintf(errtxt, "Line %d: %s", LinNum, msg);
    errexit(errtxt);
}

void do_cmd_file(struct options* opt)
{
    char miscbuf[240];

    /* We will do our check for a specification for the CmdFile here */
    if (!opt->CmdFP)
    {
        return;
    }

    NxtBnd = 0; /* init Next boundary pointer */

    while (fgets(miscbuf, sizeof(miscbuf), opt->CmdFP))
    {
        char *th, *mbf;
        ++LinNum;

        mbf = skipblank(miscbuf);

        /* Convert newlines and carriage returns to null */
        th = (char*)strchr(mbf, '\n');
        if (th)
        {
            *th = '\0';
        }

        th = strchr(mbf, '\r');
        if (th)
        {
            *th = '\0';
        }

        if (!strlen(mbf)) /* blank line? */
        {
            continue;
        }

        switch (*mbf)
        {
        case '*':     /* Comment */
            continue; /*yes, ignore   */
        case '+':     /* Options */
            if (optincmd(++mbf, opt) == -1)
            { /* an error in an option would probably be fatal, anyway */
                fprintf(stderr, "Error processing cmd line #%d\n", LinNum);
                exit(1);
            }
            continue;
        case '>':
            AMode = cmdamode(skipblank(++mbf), defaultLabelClasses, AMode);
            continue;

            /* rof ascii data definition */
            /*case '=':
                rof_ascii (skipblank (++mbf));
                continue;*/
        }

        if (strchr(BoundsNames, toupper(*mbf)) || isdigit(*mbf))
        {
            boundsline(mbf);
        }
        else /* All possible options are exhausted */
        {
            fprintf(stderr, "Illegal cmd or switch in line %d\n", LinNum);
            exit(1);
        }
    }
}

/*
 * Process options found in command file line *
 */
static int optincmd(char* lpos, struct options* opt)
{
    char st[500], *spt = st;

    while (*(lpos = skipblank(lpos)))
    {
        if (sscanf(lpos, "%500s", spt) != 1)
        {
            return (-1);
        }

        lpos += strlen(spt);

        if (*spt == '-')
        {
            ++spt;
        }

        do_opt(spt, opt);
    }
    return (0);
}

/*
 * split cmdline..  i.e. transfer characters up to
 * ';' or end of line - returns ptr to next char in cmdline buffer
 * Pure function
 */
char* cmdsplit(char* dest, char* src)
{
    char c;

    src = skipblank(src);

    c = *src;
    if (!c || (c == '\n')) return 0;

    if (strchr(src, ';'))
    {
        while ((c = *(src++)) != ';')
        {
            *(dest++) = c;
        }

        *dest = '\0';
    }
    else
    {
        strcpy(dest, src);
        src += strlen(src);
    }
    return src;
}

/*
 * Process addressing modes found in command file line
 * Pure function
 */
static int cmdamode(char* pt, char* defaultLabelClasses, int defaultAMode)
{
    char buf[80];
    int ret = defaultAMode;

    pt = cmdsplit(buf, pt);
    while (pt)
    {
        ret = do_mode(buf, TRUE, defaultLabelClasses);
        pt = cmdsplit(buf, pt);
    }
    return ret;
}

/*
 * This function interprets the range specified in the
 * command line and stores the low and high values in "lo"
 * and "hi" (the addresses are passed by the caller
 * Pure function
 */
void getrange(char* pt, int* lo, int* hi, int usize, int allowopen, int GettingAmode)
{
    char tmpdat[50], c;

    /* see if it's just a single byte/word */

    pt = skipblank(pt);
    if (!isxdigit(*pt))
    {
        if ((*pt == '-') || ((*pt == '/')))
        {
            if (GettingAmode)
            {
                errexitFromCmdfile("Open-ended ranges not permitted with Amodes");
            }

            if (NoEnd)
            {
                errexitFromCmdfile("No start address/no end address in prev line");
            }

            *lo = NxtBnd;
        }
        else
        {                             /* no range specified */
            if (*pt && (*pt != '\n')) /* non-digit gargabe */
            {
                errexitFromCmdfile("Illegal Address specified");
            }
            else
            {
                /*sprintf (pt, "%x", NxtBnd);*/
                *lo = NxtBnd;
                NxtBnd = *lo + usize;
                *hi = NxtBnd - 1;
                return; /* We're done with this line */
            }
        }
    }
    else /* We have a (first) number) */
    {
        pt = cpyhexnum(tmpdat, pt);
        sscanf(tmpdat, "%x", lo);
    }

    /* Scan for second number/range/etc */

    switch (c = *(pt = skipblank(pt)))
    {
    case '/':
        if (GettingAmode)
        {
            errexitFromCmdfile("Cannot specify \"/\" in this mode!");
        }

        pt = skipblank(++pt);

        switch (*pt)
        {
        case ';':
        case '\0':
            if (NoEnd) /* if a NoEnd from prev cmd, */
            {          /* second bump won't be done */
                ++NoEnd;
            }

            ++NoEnd;
            *hi = *lo;
            break;
        default:
            pt = cpy_digit_str(tmpdat, pt);
            NxtBnd = *lo + atoi(tmpdat);
            *hi = NxtBnd - 1;
            break;
        }

        break;
    case '-':
        switch (*(pt = skipblank(++pt)))
        {
        case ';':
        case '\0':
            if (NoEnd)
            { /* if a NoEnd from prev cmd, second bump won't be done */
                ++NoEnd;
            }

            ++NoEnd;   /* Flag need end address */
            *hi = *lo; /* tmp value */
            break;
        default:
            if (isxdigit(*pt))
            {
                pt = cpyhexnum(tmpdat, pt);
                sscanf(tmpdat, "%x", hi);
                NxtBnd = *hi + 1;
            }
        }
        break;
    default:
        if (!(*pt))
        {
            NxtBnd = *lo + usize;
            *hi = NxtBnd - 1;
        }
    }

    pt = skipblank(pt);

    if (*pt)
    {
        errexitFromCmdfile("Extra data...");
    }
}

/*
 * do_mode() - Process a single Addressing Mode command.  called by
 *      cmdamode(), which splits the command line up into single commands.
 * Passed : lpos - Pointer to current character in command line.
 * Outputs to AMode_cmdfile global
 *
 * Pure function
 */
static int do_mode(char* lpos, int GettingAmode, char* defaultLabelClasses)
{
    struct data_bounds* mptr;
    register int mclass; /* addressing mode */
    char c;
    int lo, hi;
    register struct data_bounds* lp;
    struct offset_tree* otreept = 0;

    int ret;

    if (*(lpos = skipblank(lpos)) == '#')
    {
        lpos = skipblank(++lpos);
    }

    switch (c = toupper(*(lpos++)))
    {
    case 'I':
        ret = AM_IMM;
        break;
    case 'A':
        ret = AM_A0; /* Initial */
        c = *(lpos++);

        /* Must be a0, a1, ..., a7 */
        if ((c >= '0') && c < ('8'))
        {
            ret += (c - '0');
        }
        else
        {
            char ar[4];

            strncpy(ar, lpos - 1, 2);
            ar[2] = '\0';
            fprintf(stderr, "Illegal Address Register: %s\n", ar);
        }

        break;
    case 'R':
        ret = AM_REL;
        break;
    case 'S':
        ret = AM_SHORT;
        break;
    case 'L':
        ret = AM_LONG;
        break;
    default:
        errexitFromCmdfile("Illegal addressing mode");
        exit(1); /* not needed but just to be safe */
    }

    lpos = skipblank(lpos);
    mclass = *(lpos++);
    mclass = toupper(mclass);

    if (!strchr(lblorder, mclass)) /* Legal class ? */
    {
        errexitFromCmdfile("Illegal class definition");
    }

    /* Offset spec (if any) */

    /* check for default reset (no address) */

    lpos = skipblank(lpos);
    if (!lpos || !(*lpos) || (*lpos == ';'))
    {
        AMODE_BOUNDS_CHECK(ret);
        defaultLabelClasses[ret - 1] = mclass;

        return ret;
    }

    if (*(lpos) == '(')
    {
        otreept = (struct offset_tree*)mem_alloc(sizeof(struct offset_tree));
        memset(otreept, 0, sizeof(struct offset_tree));
        lpos = setoffset(++lpos, otreept);
    }

    lpos = skipblank(lpos);

    /*  Hopefully, passing a hard-coded 1 will work always.
     */

    getrange(lpos, &lo, &hi, 1, 0, GettingAmode);

    /* Now insert new range into tree */

    mptr = (struct data_bounds*)mem_alloc(sizeof(struct data_bounds));
    memset(mptr, 0, sizeof(struct data_bounds));

    mptr->b_lo = lo;
    mptr->b_hi = hi;
    mptr->DLess = mptr->DMore = 0;
    mptr->b_typ = mclass; /*a_mode; */
    mptr->dofst = otreept;

    if (!LAdds[ret])
    {
        LAdds[ret] = mptr;
        mptr->DPrev = 0;
    }
    else
    {
        lp = LAdds[ret];

        while (1)
        {
            if (hi < lp->b_lo)
            {
                if (lp->DLess)
                {
                    lp = lp->DLess;
                    continue;
                }
                else
                {
                    lp->DLess = mptr;
                    mptr->DPrev = lp;
                    break;
                }
            }
            else
            {
                if (lo > lp->b_hi)
                {
                    if (lp->DMore)
                    {
                        lp = lp->DMore;
                        continue;
                    }
                    else
                    {
                        lp->DMore = mptr;
                        mptr->DPrev = lp;
                        break;
                    }
                }
                else
                {
                    errexitFromCmdfile("Addressing mode segments overlap");
                }
            }
        }
    }

    return ret;
}

#define ILLBDRYNAM "Illegal boundary name in line %d\n"

/*
 * Process boundaries found in command file line *
 * This processes the entire line, including all multiple
 * commands separated by a semicolon  on the same line
 * (Called from mainline cmdfile processing routine.
 */
void boundsline(char* mypos)
{
    char tmpbuf[80];
    register char* hold;
    register int count = 1;

    if (isdigit(*mypos)) /*   Repeat count for line   */
    {
        mypos = cpy_digit_str(tmpbuf, mypos);
        count = atoi(tmpbuf);
        mypos = skipblank(mypos);
    }

    hold = mypos; /* Save begin of count repeated commands */

    /* Repeatedly process the repeated commands for count times */

    while (count--)
    {
        char* nextpos;
        mypos = hold;

        /* Process each command (within the repeat) individually */

        for (nextpos = cmdsplit(tmpbuf, mypos); nextpos; mypos = nextpos, nextpos = cmdsplit(tmpbuf, mypos))
        {
            setupbounds(tmpbuf);
        }
    }
}

/*
 * set up offset (if there) for offset specification
 */
static char* setoffset(char* p, struct offset_tree* oft)
{
    char c, bufr[80];

    /* Insure that the offset_tree struct is all NULL */

    oft->oclas_maj = oft->of_maj = oft->add_to = 0;

    p = skipblank(p);

    if (!strchr(p, ')'))
    {
        errexitFromCmdfile("\"(\" in command with no \")\"");
    }

    /* If it's "*", handle it */

    if ((c = toupper(*(p++))) == '*')
    {
        /* Hope this works - flag * addressing like this  */
        oft->incl_pc++;
        p = skipblank(p); /* used this char, position for next */
        c = toupper(*(p++));
    }
    switch (c)
    {
    case '+': /* Allowable for "*" ??? */
        ++oft->add_to;
        break;
    case '-':
        break;
    case ')':
        if (!oft->incl_pc) errexitFromCmdfile("Blank offset spec!!!");

        oft->oclas_maj = 'L';

        return p;
    default:
        errexitFromCmdfile("No '+', '-', or '*' in offset specification");
    }

    /* At this point, we have a "+" or "-" and are sitting on it */

    p = skipblank(p);
    c = toupper(*(p++));

    if (!strchr(lblorder, oft->oclas_maj = c)) errexitFromCmdfile("No offset specified !!");

    p = skipblank(p);

    if (!isxdigit(*p))
    {
        errexitFromCmdfile("Non-Hex number in offset value spec");
    }

    /* NOTE: need to be sure string is lowercase and following
     * value needs to go into the structure */

    p = cpyhexnum(bufr, p);
    sscanf(bufr, "%x", &(oft->of_maj));
    /*if(add_to)
       oft->of_maj = -(oft->of_maj); */

    /* Here oft->of_maj contains the offset specified in (+/-xxxx) */

    if (*(p = skipblank(p)) == ')')
    {
        addlbl(c, oft->of_maj, NULL);
        /*addlbl (oft->of_maj, c, NULL);*/
    }
    else
    {
        errexitFromCmdfile("Illegal character.. offset must end with \")\"");
    }

    return ++p;
}

static void bndoverlap()
{
    fprintf(stderr, "Data segment overlap in line %d\n", LinNum);
    exit(1);
}

/*
 * bdinsert() - inserts an entry into the boundary table
 */
static void bdinsert(struct data_bounds* bb)
{
    register struct data_bounds* npt;
    register int mylo = bb->b_lo, myhi = bb->b_hi;

    npt = dbounds; /*  Start at base       */

    while (1)
    {
        if (myhi < npt->b_lo)
        {
            if (npt->DLess)
            {
                npt = npt->DLess;
                continue;
            }
            else
            {
                bb->DPrev = npt;
                npt->DLess = bb;
                return;
            }
        }
        else
        {
            if (mylo > npt->b_hi)
            {
                if (npt->DMore)
                {
                    npt = npt->DMore;
                    continue;
                }
                else
                {
                    bb->DPrev = npt;
                    npt->DMore = bb;
                    return;
                }
            }
            else
            {
                bndoverlap();
            }
        }
    }
}

/*
 * The base entry point for setting up a single boundary.
 * Passed : lpos = current position in cmd line
 */
void setupbounds(char* lpos)
{
    struct data_bounds* bdry;
    register int bdtyp, lclass = 0;
    int rglo, rghi;
    char c, loc[20];
    struct offset_tree* otreept = 0;

    PBytSiz = 1; /* Default to single byte */

    /* First character should be boundary type */

    switch (c = toupper(*(lpos = skipblank(lpos))))
    {
    case 'C': /* 'C'ode cmd.  simply sets the Boundary Pointer */
              /* for the next command */
        lpos = skipblank(++lpos);
        lpos = cpyhexnum(loc, lpos);
        sscanf(loc, "%x", &NxtBnd);
        ++NxtBnd; /* Position to start of NEXT boundary */
        return;   /* Nothing else to do for this option */

        /* Label types */

    case 'L':
        /*PBytSiz = 2;*/
        lpos = skipblank(++lpos);

        switch (toupper(*(lpos++)))
        {
        case 'W':
            PBytSiz = 2;
            break;
        case 'L':
            PBytSiz = 4;
        }

        lpos = skipblank(lpos);
        lclass = toupper(*lpos);

        if (!strchr(lblorder, lclass))
        {
            errexitFromCmdfile("Illegal Label Class");
        }

        break;

    case 'D': /* Non-label "D"igit values) */
        lclass = '$';
        lpos = skipblank(++lpos);

        switch (toupper(*lpos))
        {
        case 'B':
            PBytSiz = 1;
            break;
        case 'W':
            PBytSiz = 2;
            break;
        case 'L':
            PBytSiz = 4;
            break;
        }

        lpos = skipblank(++lpos);

        switch (*lpos)
        {
        case '&':
        case '^':
        case '$':
            lclass = *lpos;
            break;
        default:
            --lpos;
            break;
        }

        break;

    case 'A': /* ASCII string  data */
        lclass = '^';
        break;
    case '>':
        AMode = cmdamode(skipblank(++lpos), defaultLabelClasses, AMode);
        break;
    default:
        fprintf(stderr, "%s\n", lpos);
        errexitFromCmdfile("Illegal boundary name");
    }

    bdtyp = (int)strpos(BoundsNames, c) + 1;

    /* Offset spec (if any) */

    lpos = skipblank(++lpos);

    if (*(lpos) == '(')
    {
        otreept = (struct offset_tree*)mem_alloc(sizeof(struct offset_tree));
        memset(otreept, 0, sizeof(struct offset_tree));
        lpos = setoffset(++lpos, otreept);
    }

    getrange(lpos, &rglo, &rghi, PBytSiz, 1, FALSE);

    /* Now create the addition to the list */

    bdry = (struct data_bounds*)mem_alloc(sizeof(struct data_bounds));
    memset(bdry, 0, sizeof(struct data_bounds));
    bdry->b_lo = rglo;
    bdry->b_hi = rghi;
    bdry->b_siz = PBytSiz;
    bdry->b_class = lclass;
    bdry->b_typ = bdtyp;
    bdry->DLess = bdry->DMore = 0;
    bdry->dofst = otreept;

    /* We had to put it down here where bdry had already been malloc'ed
     * The way it works:  if a range is open-ended, getrange()
     * flags it 1, This flag passed through here.. We don't want
     * to substitute till the next pass, so we bump it up one
     * again here, so that, actually, "2" causes the substitution
     *
     * Note that we can have two open-ended commands in succession,
     * therefore, the actual logic is substute if NoEnd >= 2
     */

    if (NoEnd)
    {
        switch (NoEnd)
        {
        case 1:      /* NoEnd from this pass */
            ++NoEnd; /* flag for next pass */
            break;
        default:
            /*fprintf (stderr, "NoEnd in prev cmd.. ");
            fprintf (stderr, "inserting \\x%x for prev hi\n", bdry->b_lo);
            fprintf(stderr,"...\n");*/
            prevbnd->b_hi = bdry->b_lo - 1;
            NoEnd -= 2; /* undo one flagging */
        }
    }

    prevbnd = bdry; /* save this for open-ended bound */

    if (!dbounds)
    { /* First entry  */
        bdry->DPrev = 0;
        dbounds = bdry;
    }
    else
    {
        bdinsert(bdry);
    }
}

/*
 * Copies all valid hexadecimal string from "src" to
 * "dst" until a non-hex char is encountered and NULL-terminates
 * string in "dst".
 * Passed : (1) - Destination for string .  It is the responsibility of
 *                the caller to insure that "dst" is of adequate size.
 *          (2) - Source from which to copy
 * Returns: Pointer to first non-hexadecimal character in src string.
 *          This may be a space, "/", etc.
 * Pure function
 */
static char* cpyhexnum(char* dst, char* src)
{
    while (isxdigit(*(src)))
        *(dst++) = tolower(*(src++));
    *dst = '\0';
    return src;
}

/*
 * Copies string of digits from "src" to "dst" until
 * a non-digit is encountered.  See cpyhexnum() for details
 * Pure function.
 */
static char* cpy_digit_str(char* dst, char* src)
{
    while (isdigit(*(src)))
        *(dst++) = *(src++);
    *dst = '\0';
    return src;
}
