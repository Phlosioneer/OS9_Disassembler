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

#include "pch.h"

/* location flags for Global Refs and Local dests */
#define REFCOMN 0x100    /* Reference is COMMON      */
#define EREFREMOTE 0x100 /* External Ref is Remote   */

#define DATREMOTE 0x02 /* Data is REMOTE           */
#define CODEEQU 0x02   /* Code/Equ is EQU          */

#define REFINIT 0x04 /* DATA is INITIALIZED      */
#define CODEREF 0x01 /* Reference is in CODE or EQU */

#define LOCLLOC 0x100   /* Local Ref is Remote      */
#define LOCLCCODE 0x200 /* Local Ref is in Code     */

#define REFSIZ(a) ((a >> 3) & 3)
#define REFREL 0x04 /* Ref is relative to loc   */
#define NEGMSK 0x08 /* Negate the symbol offset */

/* ROF header structure */

#include "address_space.h"
#include "label.h"
#include "reader.h"

#include <stdio.h>

struct cmd_items;
struct rof_header;
struct rof_extrn;

/* Define flags for type of reference */
enum
{
    REFGLBL = 1,
    REFXTRN,
    REFLOCAL
};

/* ************************* *
 *  External references      *
 *  -------------------      *
 *  We will attempt to place *
 *  all in one set           *
 * ************************* */
struct rof_header
{
    uint32_t sync = 0;
    uint8_t type = 0;
    uint8_t lang = 0;
    uint8_t attributes = 0;
    uint8_t revision = 0;
    uint16_t valid = 0, /* Nonzero if valid */
        series = 0;     /* Assembler version used to compile */
    std::vector<uint8_t> rdate{};
    uint16_t edition = 0;
    uint32_t statstorage = 0, /* Size of static variable storage */
        idatsz = 0,           /* Size of initialized data */
        codsz = 0,            /* Size of the object code  */
        stksz = 0,            /* Size of stack required   */
        code_begin = 0,       /* Offset to entry point of object code   */
        utrap = 0,            /* Offset to unitialized trap entry point */
        remotestatsiz = 0,    /* Size of remote static storage   */
        remoteidatsiz = 0,    /* Size of remote initialized data */
        debugsiz = 0;         /* Size of the debug   */
    std::string rname{};      /* Ptr to module name  */

    uint32_t CodeEnd = 0;
    std::unique_ptr<BigEndianStream> codeStream{};
    std::unique_ptr<BigEndianStream> initDataStream{};
    std::unique_ptr<BigEndianStream> initRemoteDataStream{};
    std::unique_ptr<BigEndianStream> debugDataStream{};
};

struct rof_extrn
{
    rof_extrn() = default;
    rof_extrn(uint16_t type, uint32_t offset, bool isExternal);

    int hasName = 0;
    std::string nam{};
    std::shared_ptr<Label> lbl{};
    /*  void *EName;*/                  /* External name                    */
    AddrSpaceHandle dstSpace = nullptr; /* Class for referenced item NUll if extern */
    uint16_t Type = 0;                  /* Type Flag                        */
    uint32_t Ofst = 0;                  /* Offset into code                 */
    int Extrn = 0;                      /* Flag that it's an external ref   */
    struct rof_extrn *EUp = nullptr,    /* Previous Ref for entire list     */
        *ENext = nullptr,               /* Next Reference for All externs   */
            *MyNext = nullptr;          /* Next ref for this name.  If NULL, we can free EName */
};

typedef std::unordered_map<uint32_t, rof_extrn> refmap;

extern refmap refs_data, refs_idata, refs_code, refs_remote, refs_iremote, extrns; /* Generic external pointer */

class RoffFile
{
  private:
    struct Header
    {
        uint32_t sync = 0;
        uint8_t type = 0;
        uint8_t lang = 0;
        uint8_t attributes = 0;
        uint8_t revision = 0;
        uint16_t valid = 0, /* Nonzero if valid */
            series = 0;     /* Assembler version used to compile */
        std::vector<uint8_t> rdate{};
        uint16_t edition = 0;
        uint32_t statstorage = 0, /* Size of static variable storage */
            idatsz = 0,           /* Size of initialized data */
            codsz = 0,            /* Size of the object code  */
            stksz = 0,            /* Size of stack required   */
            code_begin = 0,       /* Offset to entry point of object code   */
            utrap = 0,            /* Offset to unitialized trap entry point */
            remotestatsiz = 0,    /* Size of remote static storage   */
            remoteidatsiz = 0,    /* Size of remote initialized data */
            debugsiz = 0;         /* Size of the debug   */
        std::string rname{};      /* Ptr to module name  */

        Header(BigEndianStream& stream);
    };

  public:
    const uint32_t sync;
    const uint8_t type;
    const uint8_t lang;
    const uint8_t attributes;
    const uint8_t revision;
    /* Nonzero if valid */
    const uint16_t valid;
    /* Assembler version used to compile */
    const uint16_t series;
            
    const std::vector<uint8_t> rdate;
    const uint16_t edition;
    /* Size of static variable storage */
    const uint32_t statstorage;
    /* Size of initialized data */
    const uint32_t idatsz;
    /* Size of the object code  */
    const uint32_t codsz;
    /* Size of stack required   */
    const uint32_t stksz;
    /* Offset to entry point of object code   */
    const uint32_t code_begin;
    /* Offset to unitialized trap entry point */
    const uint32_t utrap;
    /* Size of remote static storage   */
    const uint32_t remotestatsiz;
    /* Size of remote initialized data */
    const uint32_t remoteidatsiz;
    /* Size of the debug   */ 
    const uint32_t debugsiz;
    /* Module name  */
    const std::string rname;

    uint32_t CodeEnd = 0;
    std::unique_ptr<BigEndianStream> codeStream{};
    std::unique_ptr<BigEndianStream> initDataStream{};
    std::unique_ptr<BigEndianStream> initRemoteDataStream{};
    std::unique_ptr<BigEndianStream> debugDataStream{};

    inline RoffFile(BigEndianStream* stream) : RoffFile(stream, Header(*stream))
    {
    }

private:
    RoffFile(BigEndianStream* stream, Header& header);
    
};



void AddInitLbls(refmap& tbl, char klas, BigEndianStream* Module);
void getRofHdr(struct options* opt);
AddrSpaceHandle rof_class(int typ, int refTy);
struct rof_extrn* find_extrn(refmap& xtrn, unsigned int adrs);
int rof_datasize(char cclass, struct options* opt);
void DataDoBlock(refmap* refsList, uint32_t blkEnd, AddrSpaceHandle space, struct parse_state* state);
int rof_setup_ref(refmap& ref, int addrs, char* dest, int val);
char* IsRef(char* dst, uint32_t curloc, int ival, int Pass);
const char* extern_def_name(struct rof_extrn* handle);

#endif // ROF_H