/* ******************************************************************** *
 * lblfuncs.c - Functions related to labels and amodes                  *
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
 * ******************************************************************** */

#include "disglobs.h"
#include <string.h>
#include <ctype.h>
#include "userdef.h"

#include "commonsubs.h"
#include "dis68.h"
#include "label.h"

LABEL_CLASS LblList[] = {
    {'_', NULL},
    {'!', NULL}, {'=', NULL}, {'A', NULL}, {'B', NULL},
    {'C', NULL}, {'D', NULL}, {'E', NULL}, {'F', NULL},
    {'G', NULL}, {'H', NULL}, {'I', NULL}, {'J', NULL},
    {'K', NULL}, {'L', NULL}, {'M', NULL}, {'N', NULL},
    {'O', NULL}, {'P', NULL}, {'Q', NULL}, {'R', NULL},
    {'S', NULL}, {'T', NULL}, {'U', NULL}, {'V', NULL},
    {'W', NULL}, {'X', NULL}, {'Y', NULL}, {'Z', NULL},
    {0, NULL}
};

extern struct data_bounds *LAdds[];
extern struct data_bounds *dbounds;

/*
 * labelclass() - Returns the base entry for the desired class
 *
 */

LABEL_CLASS * labelclass (char lblclass)
{
    LABEL_CLASS *c = LblList;

    while (c->lclass != lblclass)
    {
        ++c;

        if (c->lclass == 0)
        {
            c = NULL;
            break;
        }
    }

    return c;
}

/* ------------------------------------------------------------ *
 * lblpos() - Searches the appropriate label list for a value   *
 * Passed:  (1) - The character representing the class          *
 *          (2) - The numeric value of that label               *
 *                                                              *
 * Returns: Pointer to the exact label if it has already been   *
 *          defined, else the label immediately preceding the   *
 *          location where it should be.                        *
 * ------------------------------------------------------------ */

static LABEL_DEF * lblpos (char lblclass, int lblval)
{
    LABEL_DEF *me = labelclass (lblclass)->cEnt;

    if (me)
    {
        while ((me->Next) && (lblval > me->myaddr))
        {
            me = me->Next;
        }
    }

    return me;

}

/* ******************************************************************** *
 * movchr() - Append a char in the desired printable format onto dst    *
 * ******************************************************************** */

static void movchr (char *dst, unsigned char ch)
{
    char mytmp[10];
    register LABEL_DEF *pp;

    if (isprint (ch & 0x7f) && ((ch & 0x7f) != ' '))
    {
        sprintf (mytmp, "'%c'", ch & 0x7f);
        strcat (dst, mytmp);
    }
    else
    {
        pp = findlbl('^', ch);
        if (pp)
        /*if ((pp = FindLbl (ListRoot ('^'), ch & 0x7f)))*/
        {
            strcat (dst, pp->sname);
        }
        else
        {
            sprintf (mytmp, "$%02x", ch & 0x7f);
            strcat (dst, mytmp);
        }
    }

    if (ch & 0x80)
    {
        strcat (dst, "+$80");
    }
}

/*
 * PrintLbl () - Prints out the label to "dest", in the format needed.
 * Passed : (1) dest - The string buffer into which to print the label.
 *          (2) clas - The Class Letter for the label.
 *          (3)  adr - The label's address.
 *          (4)   dl - ptr to the nlist tree for the label
 */

void PrintLbl (char *dest, char clas, int adr, LABEL_DEF *dl, int amod)
{
    char tmp[10];
    /*short decn = adr & 0xffff;*/
    register int mask;

    /* Readjust class definition if necessary */

    if (clas == '@')
    {
         if (abs(adr) < 9)
        /*if ( (adr <= 9) ||
             ((PBytSiz == 1) && adr > 244) ||
             ((PBytSiz == 2) && adr > 65526) )*/
        {
            clas = '&';
        }
        else
        {
            clas = '$';
        }
    }

    switch (clas)
    {
        char *hexfmt;

        case '$':       /* Hexadecimal notation */
            switch (amod)
            {
                default:
                    switch (PBytSiz)
                    {
                    case 1:
                        adr &= 0xff;
                        break;
                    case 2:
                        adr &= 0xffff;
                        break;
                    default:
                        break;
                    }

                    if (abs(adr) <= 0xff)
                    {
                        hexfmt = "%02x";
                    }
                    else if (abs(adr) <= 0xffff)
                    {
                        hexfmt = "%04x";
                    }
                    else
                    {
                        hexfmt = "%x";
                    }

                    break;
                case AM_LONG:
                    hexfmt = "%08x";
                    break;
                case AM_SHORT:
                    hexfmt = "%04x";
                    break;
            }

            sprintf (tmp, hexfmt, adr);
            sprintf (dest, "$%s", tmp);
            break;
        case '&':       /* Decimal */
            sprintf (dest, "%d", adr);
            break;
        case '^':       /* ASCII */
            *dest = '\0';

            if (adr > 0xff)
            {
                movchr (dest, (adr >> 8) & 0xff);
                strcat (dest, "*256+");
            }

            movchr (dest, adr & 0xff);

            break;
        case '%':       /* Binary */
            strcpy (dest, "%");

            if (adr > 0xffff)
            {
                mask = 0x80000000;
            }
            else if (adr > 0xff)
            {
                mask = 0x8000;
            }
            else
            {
                mask = 0x80;
            }

            while (mask)
            {
                strcat (dest, (mask & adr ? "1" : "0"));
                mask >>= 1;
            }

            break;
        default:
            strcpy (dest, dl->sname);
    }
}

/* **************************************************************** *
 * ClasHere()	See if a Data boundary for this address is defined  *
 * Passed : (1) Pointer to Boundary Class list                      *
 *          (2) Address to check for                                *
 * Returns: Ptr to Boundary definition if found,  NULL if no match. *
 * **************************************************************** */

struct data_bounds * ClasHere (struct data_bounds *bp, int adrs)
{
    register struct data_bounds *pt;
    register int h = (int) adrs;

    pt = bp;
    if ( ! pt)
    {
        return 0;
    }

    while (1)
    {
        if (h < pt->b_lo)
        {
            if (pt->DLess)
                pt = pt->DLess;
            else
                return 0;
        }
        else
        {
            if (h > pt->b_hi)
            {
                if (pt->DMore)
                {
                    pt = pt->DMore;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return pt;
            }
        }
    }
}

/*
 * findlbl() - Finds the label with the exact value 'lblval'
 * Passed:  (1) - The character class for the label
 *          (2) - The value for the address
 * Returns: The label def if it exists, NULL if not found
 *
 */

LABEL_DEF * findlbl (char lblclass, int lblval)
{
    LABEL_DEF *found;

    if (strchr ("^@$&", lblclass))
        return NULL;

    found = lblpos (lblclass, lblval);

    if (found)
    {
        return (found->myaddr == lblval) ? found : NULL;
    }

    return NULL;
}

char * lblstr (char lblclass, int lblval)
{
    LABEL_DEF *me = findlbl(lblclass, lblval);

    return (me ? me->sname : "");
}
/* ---------------------------------------------------------------- *
 * create_LABEL_DEF() - Creates a new label definition                 *
 * Passed:  (1) - value (the address or value of the label)         *
 *          (2) - the name of the label                             *
 * Returns: Pointer to the new label def, or NULL on failure to     *
 *          allocate memory for the label.                          *
 *          The name and address is already stored.                 *
 * ---------------------------------------------------------------- */

static LABEL_DEF * create_LABEL_DEF (char lblclass, int val, char *name)
{
    register LABEL_DEF *newlbl;
    
    newlbl = (LABEL_DEF *)mem_alloc(sizeof(LABEL_DEF));
    memset(newlbl, 0, sizeof(LABEL_DEF));
    {
        if (name && strlen(name))
        {
            strcpy (newlbl->sname, name);
        }
        else
        {
            /* Assume that a program label does not exceed 20 bits */
            /*sprintf (newlbl->sname, "%c%05x", toupper(lblclass), val & 0x3ffff);*/
            sprintf (newlbl->sname, "%c%05x", toupper(lblclass), val);
        }

        newlbl->myaddr = val;
    }

    return newlbl;
}

/* ************************
 * addlbl() - Add a label to the list
 *        Does nothing for class '^', '@', '$', or '&'
 *        if the label exists, and a different name is provided, renames the label
 * Passed : (1) char label class
 *          (2) int the address for the label
 *          (3) char * - the name for the label 
 *              If NULL or empty string, the hex address of the label prepended with
 *              the class letter is used.
 */

LABEL_DEF * addlbl (char lblclass, int val, char *newname)
{
    register LABEL_DEF *oldlbl;
    register LABEL_DEF *newlbl;
    register unsigned int maxsize = sizeof (oldlbl->sname);

    if (strchr("^@$&", lblclass))
    {
        return NULL;
    }

    if ((newname) && (strlen(newname) >= maxsize))
    {
        newname[maxsize-1] = '\0';
    }

    if (!labelclass(lblclass)->cEnt)      /* first entry in this tree */
    {
        newlbl = create_LABEL_DEF(lblclass, val, newname);
        if (newlbl)
        {
            LABEL_CLASS *clas = labelclass(lblclass);

            if (clas)
            {
                clas->cEnt = newlbl;
            }
            else
            {
                fprintf (stderr, "*** Label class '%c' not found\n",
                        lblclass);
            }

            return newlbl;
        }
    }

    oldlbl = lblpos (lblclass, val);

    if ((oldlbl) && (oldlbl->myaddr == val))        /* Simply a rename */
    {
        if ((newname) && strlen (newname))
        {
            if (strcmp(newname, oldlbl->sname))
            {
                strcpy(oldlbl->sname, newname);
            }
        }

        return oldlbl;
    }

    newlbl = create_LABEL_DEF(lblclass, val, newname);

        /* New beginning entry ?  */
    if ((newlbl) && (val < labelclass(lblclass)->cEnt->myaddr))
    {
        if (val < labelclass(lblclass)->cEnt->myaddr)
        {
            LABEL_CLASS *clas = labelclass(lblclass);

            if (clas)
            {
                oldlbl = clas->cEnt;
                clas->cEnt = newlbl;
                oldlbl->Prev = newlbl;
                newlbl->Next = oldlbl;
                return newlbl;
            }
            else
            {
                fprintf (stderr, "*** Label class '%c' not found\n",
                        lblclass);
            }
        }
    }
    else        /* Insert into chain */
    {
        if (!newlbl)
        {
            errexit("Null pointer dereference: newlbl in lblfuncs.c");
        }
        if (!oldlbl)
        {
            errexit("Null pointer dereference: oldlbl in lblfuncs.c");
        }
        if (newlbl->myaddr > oldlbl->myaddr)
        {
            newlbl->Prev = oldlbl;

            if (oldlbl->Next)
            {
                newlbl->Next = oldlbl->Next;
                oldlbl->Next->Prev = newlbl;
            }

            oldlbl->Next = newlbl;
        }
        else
        {
            oldlbl->Prev->Next = newlbl;
            newlbl->Prev = oldlbl->Prev;
            oldlbl->Prev = newlbl;
            newlbl->Next = oldlbl;
        }

        return newlbl;
    }

    return 0;
}

/*
 * process_label: Handle label depending upon Pass.  If Pass 1, add
 *      it as needed, if Pass 2, place values into the CMD_ITEMS fields
 *
 */

void process_label (CMD_ITEMS *ci, char lblclass, int addr)
{
    if (Pass == 1)
    {
        addlbl (lblclass, addr, NULL);
    }
    else   /* Pass 2, find it */
    {
        register LABEL_DEF *me;

        me = findlbl(lblclass, addr);
        if (me)
        {
            strcpy (ci->opcode, me->sname);
        }
        else
        {
            fprintf (stderr, "*** phasing error ***\n");
            sprintf (ci->opcode, "L%05x", addr);
        }
    }
}

void parsetree(char c)
{
    LABEL_DEF *l;
    LABEL_CLASS *lc;

    if (Pass == 1)
        return;

    lc = LblList;


    while (lc->lclass)
    {
        c = lc->lclass;

        l = labelclass(c)->cEnt;
        if (l)
        {
            printf ("\nLabel definitions for Class '%c'\n\n", c);

            while (l->Next)
            {
                printf ("%s equ $%d\n", l->sname, (int)(l->myaddr));
                l = l->Next;
            }
        }

        ++lc;
    }
}

/*
 * LblCalc() - Calculate the Label for a location
 * Passed:  (1) dst - pointer to character string into which to APPEND result                                       *
 *          (2) adr -  the address of the label
 *          (3) amod - the AMode desired
 */

int LblCalc (char *dst, int adr, int amod, int curloc)
{
    int raw = adr /*& 0xffff */ ;   /* Raw offset (postbyte) - was unsigned */
    char mainclass;                 /* Class for this location */

    struct data_bounds *kls = 0;
    LABEL_DEF *mylabel = 0;

    if (amod == AM_REL)
    {
        raw += curloc;
    }

    if (IsROF)
    {
        if (IsRef(dst, curloc, adr))
        {
            return 1;
        }
    }

    /* if amod is non-zero, we're doing a label class */

    if (amod)
    {
        kls = ClasHere(LAdds[amod], CmdEnt);
        if (kls)
        {
            mainclass = kls->b_typ;

            if (kls->dofst)     /* Offset ? */
            {
                if (kls->dofst->add_to)
                {
                    raw -= kls->dofst->of_maj;
                }
                else
                {
                    raw += kls->dofst->of_maj;
                }

                /* Let's attempt to insert the label for PC-Rel offets here */

                if (kls->dofst->incl_pc)
                {
                    raw += CmdEnt;
                    addlbl (kls->dofst->oclas_maj, raw, NULL);
                }
            }
        }
        else
        {
            /*mainclass = DEFAULTCLASS;*/
            mainclass = DfltLbls[amod - 1];
        }
    }
    else              /* amod=0, it's a boundary def  */
    {
        if (NowClass)
        {
            kls = ClasHere (dbounds, CmdEnt);
            mainclass = NowClass;

            if (kls->dofst)
            {
                if (kls->dofst->add_to)
                {
                    raw -= kls->dofst->of_maj;
                }
                else
                {
                    raw += kls->dofst->of_maj;
                }

                if (kls->dofst->incl_pc)
                {
                    raw += CmdEnt;
                }
            }
        }
        else
        {
            return 0;
        }
    }

    /* Attempt to restrict class 'L' */
    /*if (mainclass == 'L')
    {
        raw &= 0x3ffff;
    }*/

    if (Pass == 1)
    {
        addlbl (mainclass, raw, NULL);
    }
    else
    {                           /*Pass2 */
        char tmpname[20];

        mylabel = findlbl(mainclass, raw);
        if (mylabel)
        {
            PrintLbl (tmpname, mainclass, raw, mylabel, amod);
            strcat (dst, tmpname);
        }
        else
        {                       /* Special case for these */
            if (strchr ("^$@&%", mainclass))
            {
                PrintLbl (tmpname, mainclass, raw, mylabel, amod);
                strcat (dst, tmpname);
            }
            else
            {
                char t;

                t = (mainclass ? mainclass : 'D');
                fprintf (stderr, "Lookup error on Pass 2 (main)\n");
                fprintf (stderr, "Cannot find %c - %05x\n", t, raw);
             /*   fprintf (stderr, "Cmd line thus far: %s\n", tmpname);*/
                exit (1);
            }
        }

        /* Now process offset, if any */

        if (kls && kls->dofst)
        {
            char c = kls->dofst->oclas_maj;

            if (kls->dofst->add_to)
            {
                strcat (dst, "+");
            }
            else
            {
                strcat (dst, "-");
            }

            if (kls->dofst->incl_pc)
            {
                strcat (dst, "*");

                if (kls->dofst->of_maj)
                {
                    strcat (dst, "-");
                }
                else
                {
                    return 1;
                }
            }
            mylabel = findlbl(c, kls->dofst->of_maj);
            if (mylabel)
            /*if ((mylabel = FindLbl (LblList[strpos (lblorder, c)],
                                    kls->dofst->of_maj)))*/
            {
                PrintLbl (tmpname, c, kls->dofst->of_maj, mylabel, amod);
                strcat (dst, tmpname);
            }
            else
            {                   /* Special case for these */
                if (strchr ("^$@&", c))
                {
                    PrintLbl (tmpname, c, kls->dofst->of_maj, mylabel, amod);
                    strcat (dst, tmpname);
                }
                else
                {
                    char t;

                    t = (c ? c : 'D');
                    fprintf (stderr, "Lookup error on Pass 2 (offset)\n");
                    fprintf (stderr, "Cannot find %c%x\n", t,
                             kls->dofst->of_maj);
                    /*fprintf (stderr, "Cmd line thus far: %s\n", tmpname);*/
                    exit (1);
                }
            }

        }
    }

    return 1;
}
