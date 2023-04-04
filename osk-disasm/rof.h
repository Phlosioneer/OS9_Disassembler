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
#include "externc.h"

struct cmd_items;

struct rof_header {
    int   sync;
    short ty_lan,        /* Type/Language */
        att_rev,       /* Attribute/Revision word */
        valid,         /* Nonzero if valid */
        series;        /* Assembler version used to compile */
    char  rdate[6];
    short edition;
    int   statstorage,   /* Size of static variable storage */
        idatsz,        /* Size of initialized data */
        codsz,         /* Size of the object code  */
        stksz,         /* Size of stack required   */
        code_begin,    /* Offset to entry point of object code   */
        utrap,         /* Offset to unitialized trap entry point */
        remotestatsiz, /* Size of remote static storage   */
        remoteidatsiz, /* Size of remote initialized data */
        debugsiz;      /* Size of the debug   */
    char* rname;         /* Ptr to module name  */
};


/* ************************* *
 *  External references      *
 *  -------------------      *
 *  We will attempt to place *
 *  all in one set           *
 * ************************* */

struct rof_extrn {
    union {
        char* nam;
        struct symbol_def* lbl;
    } EName;
    /*  void *EName;*/              /* External name                    */
    char  dstClass;             /* Class for referenced item NUll if extern */
    int   Type;                 /* Type Flag                        */
    int   Ofst;                 /* Offset into code                 */
    int   Extrn;                /* Flag that it's an external ref   */
    struct rof_extrn* EUp,      /* Previous Ref for entire list     */
        * ENext,                 /* Next Reference for All externs   */
        * MyNext;                /* Next ref for this name.  If NULL, we can free EName */
};

/* Define flags for type of reference */
enum {
    REFGLBL = 1,
    REFXTRN,
    REFLOCAL
};

struct asc_data {
    int start,
        length;
    struct asc_data *LNext,
                    *RNext;
};

cglobal struct asc_data *data_ascii;


/*struct rof_extrn *xtrn_data = 0,
                 *xtrn_idata,
                 *xtrn_code = 0,
                 *xtrn_remote,
                 *xtrn_iremote,
                 *extrns;*/                   /* Generic external pointer */


cglobal struct rof_extrn *refs_data,
                 *refs_idata,
                 *refs_code,
                 *refs_remote,
                 *refs_iremote,
                 *extrns,                   /* Generic external pointer */
                 *codeRefs_sav;

/*struct nlist *dp_base,
             *vsect_base,
             *code_base,
             *lblptr;*/


/*struct rof_header ROF_hd,
               *rofptr = &ROF_hd;*/


cfunc void reflst(void);
cfunc int RealEnt(void);
cfunc void AddInitLbls(struct rof_extrn* tbl, int dataSiz, char klas);
cfunc void getRofHdr(FILE* progpath);
cfunc void RofLoadInitData(void);
cfunc char rof_class(int typ, int refTy);
cfunc struct rof_extrn* find_extrn(struct rof_extrn* xtrn, int adrs);
cfunc int typeFetchSize(int rtype);
cfunc struct rof_extrn* rof_lblref(struct cmd_items* ci, int* value);
cfunc int rof_datasize(char cclass);
cfunc void ListInitROF(char* hdr, struct rof_extrn* refsList, char* iBuf, int isize, char iClass);
cfunc void rof_ascii(char* cmdline);
cfunc void setROFPass(void);
cfunc int rof_setup_ref(struct rof_extrn* ref, int addrs, char* dest, int val);
cfunc char* IsRef(char* dst, int curloc, int ival);

#endif // ROF_H