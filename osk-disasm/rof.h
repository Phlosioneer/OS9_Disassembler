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

#ifndef ROF_H
#define ROF_H

#include "pch.h"

#include "address_space_handle.h"
#include "reader.h"
#include "size.h"
#include "label.h"

class rof_extrn;

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

    /* Documentation is WRONG. It has the sign flag and relative flag bits backwards.
     * Documentation says sign = 0x80, relative = 0x40.
     */
    constexpr static uint16_t SIGN_FLAG = 0x40;
    constexpr static uint16_t RELATIVE_FLAG = 0x80;
    constexpr static uint16_t REF_SIZE_OFFSET = 3;
    constexpr static uint16_t REF_SIZE_MASK = 0b11000;

    
    inline size_t rawSize() const noexcept
    {
        return (type & REF_SIZE_MASK) >> REF_SIZE_OFFSET;
    }

  public:
    inline RoffReferenceInfo(uint16_t type, ReferenceScope scope) noexcept : type(type), scope(scope)
    {
    }

    inline RoffReferenceInfo(const RoffReferenceInfo& other) noexcept : type(other.type), scope(other.scope)
    {
    }

    inline RoffReferenceInfo& operator=(const RoffReferenceInfo& other) noexcept
    {
        type = other.type;
        scope = other.scope;
    }

    AddrSpaceHandle space() const;

    inline ReferenceScope getScope() const
    {
        return scope;
    }

    inline bool isPositive() const
    {
        if (scope == ReferenceScope::REFXTRN || scope == ReferenceScope::REFLOCAL)
        {
            return (type & SIGN_FLAG) == 0;
        }
        return true;
    }

    inline bool isRelative() const
    {
        return (type & RELATIVE_FLAG) != 0;
    }

    inline size_t sizeInBytes() const
    {
        switch (rawSize())
        {
        case 0:
            throw std::runtime_error("Illegal size value: 0");
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 4;
        default:
            throw std::runtime_error("Unreachable");
        }
    }

    inline OperandSize opSize() const
    {
        switch (rawSize())
        {
        case 0:
            throw std::runtime_error("Illegal size value: 0");
        case 1:
            return OperandSize::Byte;
        case 2:
            return OperandSize::Word;
        case 3:
            return OperandSize::Long;
        default:
            throw std::runtime_error("Unreachable");
        }
    }
};

class rof_extrn
{
  private:
    bool hasName = false;
    std::string name{};
    std::shared_ptr<Label> label{};
  public:
    RoffReferenceInfo info;                /* Type Flag                        */
    AddrSpaceHandle space = nullptr; /* Class for referenced item NUll if extern */
    uint32_t offset = 0;                  /* Offset into code                 */
    
    rof_extrn(RoffReferenceInfo refInfo, uint32_t offset);


    inline bool isExternal() const
    {
        return info.getScope() == ReferenceScope::REFXTRN;
    }

    inline const std::string& getName() const
    {
        if (hasName)
        {
            return name;
        }
        else if (label)
        {
            return label->name();
        }
        else
        {
            throw std::runtime_error("Extern has no name or label!");
        }
    }

    inline void setName(const std::string& newName)
    {
        if (newName.empty())
        {
            throw std::runtime_error("Empty name assigned to external ref");
        }
        hasName = true;
        name = newName;
    }

    inline void setName(std::string&& newName)
    {
        if (newName.empty())
        {
            throw std::runtime_error("Empty name assigned to external ref");
        }
        hasName = true;
        name = std::move(newName);
    }

    inline void setName(const char* newName)
    {
        name = newName;
        if (name.empty())
        {
            throw std::runtime_error("Empty name assigned to external ref");
        }
        hasName = true;
    }

    inline void setLabel(std::shared_ptr<Label> label)
    {
        if (!label)
        {
            throw std::runtime_error("Null label assigned to external ref");
        }
        hasName = false;
        this->label = label;
    }
};

typedef std::unordered_map<uint32_t, std::vector<rof_extrn>> refmap;

class ReferenceManager
{
    // Needed for const iterators for missing refmaps.
    static const refmap dummyEmptyRefmap;

    std::unordered_map<AddrSpaceHandle, refmap> refsBySpace;
  public:

    typedef refmap::const_iterator ref_const_iterator;

    void addInitialLabels(AddrSpaceHandle space, BigEndianStream* Module);

    void clear();
    
    /*
     * Find an external reference.
     * Passed : (1) xtrn - starting extrn ref
     *          (2) adrs - Address to match
     * Pure function.
     */
    const std::vector<rof_extrn> *find_extrn(AddrSpaceHandle space, uint32_t adrs) const;

    void insert(AddrSpaceHandle space, rof_extrn&& move_ref);

    inline ref_const_iterator cbegin(AddrSpaceHandle space) const
    {
        auto it = refsBySpace.find(space);
        if (it != refsBySpace.cend())
        {
            return it->second.cbegin();
        }
        else
        {
            return dummyEmptyRefmap.cbegin();
        }
    }

    inline ref_const_iterator cend(AddrSpaceHandle space) const
    {
        auto it = refsBySpace.find(space);
        if (it != refsBySpace.cend())
        {
            return it->second.cend();
        }
        else
        {
            return dummyEmptyRefmap.cend();
        }
    }
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


void DataDoBlock(uint32_t blkEnd, AddrSpaceHandle space, struct parse_state* state);
bool rof_setup_ref(std::string& out_text, AddrSpaceHandle space, uint32_t addrs, uint32_t val, int Pass, OperandSize sizeConstraint,
                   bool isRelativeRefImplied);
bool IsRef(std::string& out_text, uint32_t curloc, uint32_t ival, int Pass, OperandSize sizeConstraint, bool flipRefSign);
bool refsToExpression(std::string& out_text, const std::vector<rof_extrn>& refs, uint32_t currentAddress, uint32_t literalValue,
                      int Pass, OperandSize sizeConstraint, bool isRelativeRefImplied);
OperandSize maxSizeOfRefs(const std::vector<rof_extrn>& refs);

#endif // ROF_H