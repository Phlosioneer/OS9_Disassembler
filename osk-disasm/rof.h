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
enum class ReferenceScope
{
    REFGLBL = 1,
    REFXTRN,
    REFLOCAL
};

struct RoffReferenceInfo
{
  private:
    uint16_t type;
    ReferenceScope scope;

  public:
    inline RoffReferenceInfo(uint16_t type, ReferenceScope scope) noexcept : type(type), scope(scope)
    {
    }

    inline RoffReferenceInfo(const RoffReferenceInfo& other) noexcept : type(other.type), scope(other.scope)
    {
    }

    inline RoffReferenceInfo(RoffReferenceInfo&& other) noexcept : type(other.type), scope(other.scope)
    {
    }

    inline size_t size() const noexcept
    {
        return (type >> 3) & 3;
    }

    AddrSpaceHandle space() const;
};

struct rof_extrn
{
    rof_extrn() = default;
    rof_extrn(uint16_t type, uint32_t offset, bool isExternal);

    bool hasName = false;
    std::string name{};
    std::shared_ptr<Label> label{};
    AddrSpaceHandle space = nullptr; /* Class for referenced item NUll if extern */
    uint16_t type = 0;                  /* Type Flag                        */
    uint32_t offset = 0;                  /* Offset into code                 */
    bool isExternal = false;            /* Flag that it's an external ref   */

    inline size_t size() const
    {
        return (type >> 3) & 3;
    }
};

typedef std::unordered_map<uint32_t, rof_extrn> refmap;

class ReferenceManager
{
  public:
    refmap refs_data;
    refmap refs_idata;
    refmap refs_code;
    refmap refs_remote;
    refmap refs_iremote;

    /* Generic external pointer */
    refmap extrns;

    void clear();
    
    /*
     * Find an external reference.
     * Passed : (1) xtrn - starting extrn ref
     *          (2) adrs - Address to match
     * Pure function.
     */
    struct rof_extrn* find_extrn(refmap& xtrn, unsigned int adrs);
};

extern ReferenceManager refManager;

class RoffFile
{
  private:
    /* Represents the raw values in a ROFF file header.*/
    struct Header
    {
        uint8_t type = 0, language = 0, attributes = 0, revision = 0;
        uint16_t valid = 0, assemblerVersion = 0, edition = 0;
        uint32_t staticStorage = 0, combinedDataSize = 0, codeSize = 0, stackSize = 0, entryPointOffset = 0,
            trapHandlerOffset = 0, remoteStaticDataSize = 0, remoteCombinedDataSize = 0, debugSize = 0;
        std::vector<uint8_t> assembleDate{};
        std::string moduleName{};

        Header(BigEndianStream& stream);
    };

  public:
    const uint8_t type;
    const uint8_t language;
    const uint8_t attributes;
    const uint8_t revision;

    /* Flag in the Roff file indicating whether it can be linked. Probably used to prevent
     * linking partially-finished files.
     */
    const bool isValid;

    /* Assembler version used to compile the file. */
    const uint16_t assemblerVersion;
    
    /* The date this file was assembled. */
    const std::vector<uint8_t> assembleDate;

    const uint16_t edition;
    
    /* Size of static variable storage */
    const uint32_t statstorage;
    
    /* Size of uninitialized and initialized data */
    const uint32_t combinedDataSize;
    
    /* Size of the object code  */
    const uint32_t codeSize;
    
    /* Size of stack required   */
    const uint32_t stackSize;
    
    /* Offset to entry point of object code   */
    const uint32_t entryPointOffset;
    
    /* Offset to unitialized trap entry point */
    const uint32_t trapHandlerOffset;
    
    /* Size of remote static storage   */
    const uint32_t remoteStaticDataSize;
    
    /* Size of remote initialized data */
    const uint32_t remoteCombinedDataSize;
    
    /* Size of the debug   */ 
    const uint32_t debugSize;
    
    /* Module name  */
    const std::string moduleName;

    std::unique_ptr<BigEndianStream> codeStream{};
    std::unique_ptr<BigEndianStream> initDataStream{};
    std::unique_ptr<BigEndianStream> initRemoteDataStream{};
    std::unique_ptr<BigEndianStream> debugDataStream{};

    inline RoffFile(BigEndianStream* stream) : RoffFile(stream, Header(*stream))
    {
    }

    static constexpr uint32_t sync()
    {
        return 0xdeadface;
    }

private:
    RoffFile(BigEndianStream* stream, Header& header);
    
};



void AddInitLbls(refmap& tbl, char klas, BigEndianStream* Module);
void getRofHdr(struct options* opt);
void DataDoBlock(refmap* refsList, uint32_t blkEnd, AddrSpaceHandle space, struct parse_state* state);
bool rof_setup_ref(std::string& out_name, refmap& ref, uint32_t addrs, int32_t val);
bool IsRef(std::string& out_name, uint32_t curloc, uint32_t ival, int Pass);
const char* extern_def_name(struct rof_extrn* handle);

#endif // ROF_H