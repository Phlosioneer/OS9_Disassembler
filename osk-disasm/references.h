#pragma once

#include "pch.h"

#include "address_space_handle.h"
#include "reader.h"
#include "size.h"
#include "label.h"

class RelocatedReference;

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

class RelocatedReference
{
  private:
    bool hasName = false;
    std::string name{};
    std::shared_ptr<Label> label{};

  public:
    RoffReferenceInfo info;          /* Type Flag                        */
    AddrSpaceHandle space = nullptr; /* Class for referenced item NUll if extern */
    uint32_t offset = 0;             /* Offset into code                 */

    RelocatedReference(RoffReferenceInfo refInfo, uint32_t offset);

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

typedef std::unordered_map<uint32_t, std::vector<RelocatedReference>> refmap;

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
    const std::vector<RelocatedReference>* find_extrn(AddrSpaceHandle space, uint32_t adrs) const;

    void insert(AddrSpaceHandle space, RelocatedReference&& move_ref);

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

void parseRefSection(const std::string& vname, size_t count, ReferenceScope ref_typ, BigEndianStream* codebuffer,
              BigEndianStream* Module);