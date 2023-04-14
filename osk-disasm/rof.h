/* ******************************************************************** *
 * rof.h - header file for rof definitions                              *
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
 * ******************************************************************** */

/* symbol table types */
/* symbol definition/reference type/location */

#ifndef ROF_H
#define ROF_H

/* location flags for Global Refs and Local dests */
#define REFCOMN     0x100       /* Reference is COMMON      */
#define EREFREMOTE  0x100       /* External Ref is Remote   */

#define DATREMOTE   0x02        /* Data is REMOTE           */
#define CODEEQU     0x02        /* Code/Equ is EQU          */

#define REFINIT     0x04        /* DATA is INITIALIZED      */
#define CODEREF     0x01        /* Reference is in CODE or EQU */

#define LOCLLOC     0x100       /* Local Ref is Remote      */
#define LOCLCCODE   0x200       /* Local Ref is in Code     */

#define REFSIZ(a)   ((a >> 3) & 3)
#define REFREL      0x04        /* Ref is relative to loc   */
#define NEGMSK      0x08        /* Negate the symbol offset */

/* ROF header structure */

#include "label.h"

#include <stdio.h>

struct cmd_items;
struct rof_header;
struct rof_extrn;



/* Define flags for type of reference */
enum {
    REFGLBL = 1,
    REFXTRN,
    REFLOCAL
};

extern struct rof_extrn *refs_data,
                 *refs_idata,
                 *refs_code,
                 *refs_remote,
                 *refs_iremote,
                 *extrns,                   /* Generic external pointer */
                 *codeRefs_sav;

extern struct rof_header* ROFHd;

int RealEnt(struct options* opt);
void AddInitLbls(struct rof_extrn* tbl, int dataSiz, char klas, FILE* ModFP);
void getRofHdr(FILE* progpath, struct options* opt);
void RofLoadInitData(void);
char rof_class(int typ, int refTy);
struct rof_extrn* find_extrn(struct rof_extrn* xtrn, int adrs);
int rof_datasize(char cclass);
void ListInitROF(char* hdr, struct rof_extrn* refsList, char* iBuf, int isize, char iClass, struct options* opt);
void setROFPass(void);
int rof_setup_ref(struct rof_extrn* ref, int addrs, char* dest, int val);
char* IsRef(char* dst, int curloc, int ival);

void extern_def_destroy(struct rof_extrn* handle);
const char* extern_def_name(struct rof_extrn* handle);

void rof_header_destroy(struct rof_header* handle);
int rof_header_getCodeAddress(struct rof_header* handle);
int rof_header_getUninitDataSize(struct rof_header* handle);
int rof_header_getInitDataSize(struct rof_header* handle);
int rof_header_getRemoteUninitDataSize(struct rof_header* handle);
int rof_header_getRemoteInitDataSize(struct rof_header* handle);
char* rof_header_getPsectParams(struct rof_header* handle);
//size_t rof

// Unused
struct rof_extrn* rof_lblref(struct cmd_items* ci, int* value, struct parse_state* state);

#endif // ROF_H