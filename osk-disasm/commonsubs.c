/* ************************************************************************ *
 * commonsubs.c - Common subroutines and functions that are used            *
 *          by several calls.                                               *
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


#include <string.h>
#include <stdio.h>
#include "userdef.h"
#include "modtypes.h"

#include "rof.h"

#include "commonsubs.h"
#include "exit.h"
#include "label.h"
#include "command_items.h"
#include "main_support.h"

static char strBuf[2000];

/*
 * strpos() - Similar to strchr except that it returns the
 *        base-1 offset from the begin of the string.
 */

int strpos (const char *s, char c)
{
    register int p;

    p = (int)strchr(s, c);
    return (p ? (p - (int)s) : -1);
}

/* **************************************************************** *
 * skipblank() passes over any space, tab, or any newline character *
 *             in the string                                        *
 * Passed: p pointer to begin of string to parse                    *
 * Returns: pointer to first character of "valid" data,             *
 *          or null if end of data                                  *
 * **************************************************************** */

char * skipblank (char *p)
{
    /* We did just pass over spaces or tabs, but we need to
     * also be sure we are past all return characters
     * ( especially the extra character MS-Dos uses
     */

    while ((*p) && (strchr (" \t\r\f\n", *p)))
    {
        ++p;
    }

    if (*p == '\n')
    {
        *p = 0;
    }

    return p;
}



/* ------------------------------------------------------------------ *
 * revbits() - Reverses the bit order for a value.                    *
 * ------------------------------------------------------------------ */


int revbits(int num, int lgth)
{
    int n2 = 0;
    int c, i;

    for (c = (lgth - 1), i = 0; c >= 0; c--,i++)
    {
        n2 <<= 1;

        if (num & (1 << i))
            n2 |= 1;
    }

    return n2;
}


unsigned int fget_w (FILE *fp)
{
    return ((unsigned char)fgetc(fp) << 8) | (unsigned char)fgetc(fp);
}

unsigned int fget_l (FILE *fp)
{
    unsigned int val,
                 c;
    val = (unsigned char)fgetc(fp);

    for (c = 0; c < 3; c++)
    {
        val = (val << 8) | (unsigned char)(fgetc(fp) & 0xff);
    }

    return val;
}

/* ************************************************************************* *
 * fread_* functions - These are partly convenience functions but mostly are *
 * used to enable retrieving multi-byte values regardless of the             *
 * "ENDIAN"ness of the CPU                                                   *
 * If the read fails, the program is immediately exited.                     *
 * ************************************************************************* */

char fread_b(FILE *fp)
{
    char b;

    if (fread(&b, 1, 1, fp) < 1)
    {
        filereadexit();
    }

    return b;
}


/* ******************************************************************** *
 * Some substitutions to allow portability. Most deal with the byte     *
 *  order of the CPU                                                    *
 * ******************************************************************** */

/* Read multi-byte numbers from the file.  
 * We are going to make a serious assumption here.  If it's _OSK then
 * assume it's LITTLE_ENDIAN, other wise it's BIG_ENDIAN.  Also we'll
 * assume that if it's _OSK, _STDC_ is #undef; otherwise it's defined
 */

#ifdef _OSK
short fread_w(fp)
    FILE *fp;
{
    short w;
    
    if (fread(&w, 2, 1, fp) < 1)
    {
        filereadexit();
    }

    return w;
}

int fread_l(fp)
    FILE *fp;
{
    int l;
    int count;
    
    l = (unsigned char)fgetc(fp)  & 0xff;

    for (count = 1; count < sizeof(int); count++)
    {
        l = (l << 8) | (unsigned char)fgetc(fp) & 0xff;
    }

    return l;
}
#else
short fread_w(FILE *fp)
{
    int tt;

    tt = (fgetc(fp) << 8) | (fgetc (fp) & 0xff);
    return tt;
}

int fread_l(FILE *fp)
{
    int tt;
    int tmpnum = 0;
    int count;

    for (count = 0; count < 4; count++)
    {
        if (fread(&tt, 1, 1, fp) < 1)
        {
            filereadexit();
        }

        tmpnum = (tmpnum<<8) | (tt & 0xff); 
    }

    return tmpnum;
}
#endif

/* **************************************************************** *
 * bufReadW() - Returns the word value stored at pos pt in a buffer *
 * **************************************************************** */

short bufReadW(char **pt)
{
    register int val = 0;

    val = *(*pt)++ & 0xff;
    val = (val << 8) | (*(*pt)++ & 0xff);
    /*return ((*(*pt)++ & 0xff) << 8) | (*((*pt)++) & 0xff);*/
    return val;
}

/* **************************************************************** *
 * bufReadL() - Returns the long value stored at pos pt in a buffer *
 * **************************************************************** */

int     bufReadL(char **pt)
{
    register int byteCnt;
    register int val = 0;

    for (byteCnt = 0; byteCnt < 4; byteCnt++)
    {
        val = (val << 8) | (*((*pt)++) & 0xff);
    }

    return val;
}

void * mem_alloc (size_t req)
{
    void *addr;

    addr = malloc(req);
    if (!addr)
    {
        errexit ("Failed to acquire requested memory");
    }

    return addr;
}

/* *************************************************************** *
 * freadString() - Read a null-terminated string from the file,    *
 *            allocate memory for that string, and store it there. *
 * Returns: Pointer to the new string.                             *
 * *************************************************************** */

char * freadString(FILE* fp)
{
    register char *strPt = strBuf;
    register char *newStr;
    register int ch;

    ch = getc(fp);
    while (ch && (ch > 0))
    {
        *(strPt++) = ch;
        ch = getc(fp);
    }

    *strPt = '\0';
    strcpy ((newStr = (char *)mem_alloc(strlen(strBuf) + 1)), strBuf);
    return newStr;
}


