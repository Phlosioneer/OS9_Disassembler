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

#include "rof.h"

#include <sstream>
#include <stdio.h>
#include <string.h>

#include "command_items.h"
#include "commonsubs.h"
#include "exit.h"
#include "label.h"
#include "main_support.h"
#include "modtypes.h"

// Advances past any space, tab, or any newline character in the string.
// Pure function
char* skipblank(char* p)
{
    if (p)
    {
        while (*p != '\0' && isspace(*p))
        {
            p++;
        }
    }

    return p;
}

// Reverses the bit order for a value. `Length` is given in bits.
// Pure function
unsigned int revbits(unsigned int num, int length)
{
    int n2 = 0;
    int c, i;

    for (c = (length - 1), i = 0; c >= 0; c--, i++)
    {
        n2 <<= 1;

        if (num & (1 << i)) n2 |= 1;
    }

    return n2;
}

// Read one byte. If the read fails, the program is immediately exited.
unsigned char fread_b(FILE* fp)
{
    unsigned char b;

    if (fread(&b, 1, 1, fp) < 1)
    {
        filereadexit();
    }

    return b;
}

// Sidestep any endian-ness issues by reading one byte at a time. Not a
// good strategy, but it's only temporary while transitioning to C++ streams.
unsigned short fread_w(FILE* fp)
{
    return (fread_b(fp) << 8) | fread_b(fp);
}

unsigned int fread_l(FILE* fp)
{
    return (fread_w(fp) << 16) | fread_w(fp);
}

// Returns the word value stored at pos pt in a buffer
unsigned short bufReadW(char** pt)
{
    unsigned int val = 0;

    val = *(*pt)++ & 0xff;
    val = (val << 8) | (*(*pt)++ & 0xff);
    /*return ((*(*pt)++ & 0xff) << 8) | (*((*pt)++) & 0xff);*/
    return val;
}

// Returns the long value stored at pos pt in a buffer
unsigned int bufReadL(char** pt)
{
    unsigned int byteCnt;
    unsigned int val = 0;

    for (byteCnt = 0; byteCnt < 4; byteCnt++)
    {
        val = (val << 8) | (*((*pt)++) & 0xff);
    }

    return val;
}

// Read a null-terminated string from the file, allocate memory for that
// string, and store it there.
char* freadString(FILE* fp)
{
    std::ostringstream buffer;

    char ch = getc(fp);
    while (ch && (ch > 0))
    {
        buffer << ch;
        //*(strPt++) = ch;
        ch = getc(fp);
    }

    //*strPt = '\0';
    // strcpy ((newStr = (char *)mem_alloc(strlen(strBuf) + 1)), strBuf);
    std::string temp = buffer.str();
    return _strdup(temp.c_str());
}