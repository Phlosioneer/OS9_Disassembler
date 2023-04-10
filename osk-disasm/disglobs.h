/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  *
 * disglobs.h - All the global variables used in the OSK disassembler   *
 *      All globals are defined in this file, then one code file will   *
 *      define _MAIN_, causing them to be defined, then all other       *
 *      files will simply have them defined "extern"                    *
 *                                                                      *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  *
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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef HAVE_GLOBALS
#define HAVE_GLOBALS

#define VERSION "0.1.0"

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

#ifdef _WIN32
#   define BINREAD "rb"
#   define BINWRITE "wb"
#   define PATHSEP '\\'
#else
#   define BINREAD "r"
#   define BINWRITE "w"
#   define PATHSEP '/'
#endif

#ifndef SEEK_SET
#   define SEEK_SET 0
#   define SEEK_CUR 1
#   define SEEK_END 2
#endif

#define MC68000 0
#define MC68008 8
#define MC68010 10
#define MC68020 20
#define MC68030 30
#define MC68040 40

enum {
    SIZ_BYTE,
    SIZ_WORD,
    SIZ_LONG
};

/* Addressing Modes */

enum {
    AM_A0 = 1,
    AM_A1,
    AM_A2,
    AM_A3,
    AM_A4,
    AM_A5,
    AM_A6,
    AM_A7,
    AM_IMM,
    AM_SHORT,   /* Absolute Short */
    AM_LONG,    /* Absolute Long */
    AM_REL,
    AM_MAXMODES   /* Count of Modes + 1 */
};
#define AMODE_BOUNDS_CHECK(mode)                                \
    if ((mode) >= AM_MAXMODES || (mode) == 0)                   \
    {                                                           \
        char _errMessage[30];                                   \
        snprintf(_errMessage, 30, "Invalid AMode: %d", (mode)); \
        errexit(_errMessage);                                   \
    }

/* The following two structures define
 * the extended word
 */
struct extWbrief {
    int isFull;      /* 1 = 68020-type */
    char regNam;     /* Index Register ('D' or 'A' */
    int regno;      /* Register # */
    int isLong;      /* Index size (W/L, 0 if sign-extended word */
    int scale;      /* Scale  00 = 1, 01 = 2, 03 = 4, 11= 8 */
    int displ;      /* Displacement (lower byte) */
    int is;         /* Index Suppress */
    int bs;         /* Base Displacement Suppress */
    int bdSize;     /* BD Size */
    int iiSel;      /* Index/Indirect Selection */
};

/* The following is part of the description for the full extended word */

/* I/IS combinations
 * IS   I/IS    Operation
         * 0    000 No memory indirection
         * 0    001 Indirect preindexed with null outer displacement
         * 0    010 Indirect preindexed with word od
         * 0    011 Indirect preindexed with long od
         * 0    101 Indirect postindexed with null od
         * 0    110 Indirect postindexed with word od
         * 0    111 Indirect postindexed with long od
         * 1    000 No memory indirection
         * 1    001 Memory indirect with null od
         * 1    010 Memory indirect with word od
         * 1    011 Memory indirect with long od
         */ 


#endif                     /* #ifdef HAVE_GLOBALS */
