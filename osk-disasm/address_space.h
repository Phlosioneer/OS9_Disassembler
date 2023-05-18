#ifndef ADDRESS_SPACE_H
#define ADDRESS_SPACE_H

#include "pch.h"

class AddressSpace
{
  public:
    AddressSpace(const char* name, const char* shortcode, bool allowsAliases = false);
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
    const bool allowsAliases;

    // Uses the unique name constraint as a shortcut.
    bool operator==(const AddressSpace& other) const;

    virtual std::string makeDefaultName(size_t address) const;
};

typedef const AddressSpace* AddrSpaceHandle;

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