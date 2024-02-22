#ifndef ADDRESS_SPACE_H
#define ADDRESS_SPACE_H

#include "pch.h"

#include "address_space_handle.h"

enum class SpaceKind
{
    /// <summary>
    /// Members of this space point to data that was initialized by the file. All
    /// addresses have a corresponding file offset (though it's not tracked).
    /// </summary>
    INITIALIZED,

    /// <summary>
    /// Members of this space point to data that only exists at runtime. 
    /// </summary>
    UNINITIALIZED,

    /// <summary>
    /// Members of this space don't point to any memory at all. Instead, they're
    /// constant or abstract values.
    /// </summary>
    NAMED_LITERAL,

    /// <summary>
    /// Members of this space are unnamed literal values. Used to correctly render
    /// literals in different bases and formats (like ascii).
    /// </summary>
    LITERAL
};

namespace SpaceKinds
{

const char* getName(SpaceKind kind);

}

class AddressSpace
{
  public:
    class isRemote_tag_t
    {
    };
    class canAlias_tag_t
    {
    };

  private:
    AddressSpace(const char* name, const char* shortcode, SpaceKind kind, bool allowsAliases, bool isRemote);

  public:
    inline AddressSpace(const char* name, const char* shortcode, SpaceKind kind)
        : AddressSpace(name, shortcode, kind, false, false)
    {
    }
    inline AddressSpace(const char* name, const char* shortcode, SpaceKind kind, canAlias_tag_t tag)
        : AddressSpace(name, shortcode, kind, true, false)
    {
    }
    inline AddressSpace(const char* name, const char* shortcode, SpaceKind kind, isRemote_tag_t tag)
        : AddressSpace(name, shortcode, kind, false, true)
    {
    }
    virtual ~AddressSpace() = default;

    // Human readable name for the address space. Must be unique.
    const std::string name;

    // Prefix for unnamed values. Usually only one character, but allows for exceptions.
    const std::string shortcode;

    // Whether two entries with the same value should be considered interchangable.
    //
    // For example, two labels for the same instruction are interchangable. But an
    // error-code equate is never interchangable with a syscall equate, even if they
    // have the same value!
    //
    // TODO: allowsAliases is ignored by LabelCategory::add!
    // (corresponding TODO is also on LabelCategory::add)
    const bool allowsAliases;

    const SpaceKind kind;

    const bool isRemote;

    // Uses the unique name constraint as a shortcut.
    bool operator==(const AddressSpace& other) const;

    virtual std::string makeDefaultName(size_t address) const;
};

/* Values that are addresses into code. Formerly class 'L'. */
extern const AddressSpace CODE_SPACE;

/* Values that are in ROF file init data. Formerly class 'D'. */
extern const AddressSpace INIT_DATA_SPACE;

/* Values that are in ROF file uninit data. Formerly class 'D' or '_'. */
extern const AddressSpace UNINIT_DATA_SPACE;

/* Formerly class 'H'. */
extern const AddressSpace INIT_REMOTE_SPACE;

/* Formerly class 'G'. */
extern const AddressSpace UNINIT_REMOTE_SPACE;

// Values that are in ROF file debug data. Did not have a class before.
extern const AddressSpace DEBUG_SPACE;

/* Values that are in some data space, but it's unclear which one. In modules, these
 * values are resolved after the first pass based on the size of init data space.
 * In ROF files, the values must be hardcoded, and can't be resolved at all.
 * Formerly lumped in with 'D' class.
 */
extern const AddressSpace UNKNOWN_DATA_SPACE;

/* Constant values with special formatting. Formerly classes '@', '&', '$',
 * and '^'. */
extern const AddressSpace LITERAL_SPACE;

// Temp space while refactoring
extern const AddressSpace LITERAL_DEC_SPACE;

// Temp space while refactoring
extern const AddressSpace LITERAL_HEX_SPACE;

// Temp space while refactoring
extern const AddressSpace LITERAL_ASCII_SPACE;

/* Constant values with names. Did not have a class before. */
extern const AddressSpace EQUATE_SPACE;

extern const std::vector<AddrSpaceHandle> allSpaces;

#endif // ADDRESS_SPACE_H