
#include "pch.h"

#include "address_space.h"

#include "dprint.h"

AddressSpace::AddressSpace(const char* name, const char* shortcode, bool allowsAliases)
    : name(name), shortcode(shortcode), allowsAliases(allowsAliases)
{
}

bool AddressSpace::operator==(const AddressSpace& other) const
{
    return name == other.name;
}

std::string AddressSpace::makeDefaultName(size_t address) const
{
    if (address > 0xFFFFF)
    {
        fprintf(stderr, "Warning: Address is too large for default name (21+ bits): %llx", address);
    }
    std::ostringstream ret;
    ret << shortcode << PrettyNumber<size_t>(address).fill('0').width(5).hex();
    return ret.str();
}

const AddressSpace CODE_SPACE("code", "L");
const AddressSpace INIT_DATA_SPACE("initData", "_");
const AddressSpace UNINIT_DATA_SPACE("uninitData", "D");
const AddressSpace INIT_REMOTE_SPACE("initRemote", "H");
const AddressSpace UNINIT_REMOTE_SPACE("uninitRemote", "G");
const AddressSpace UNKNOWN_DATA_SPACE("unknownData", "U");
const AddressSpace LITERAL_SPACE("literal", "@", true);
const AddressSpace LITERAL_DEC_SPACE("literal:decimal", "&", true);
const AddressSpace LITERAL_HEX_SPACE("literal:hex", "$", true);
const AddressSpace LITERAL_ASCII_SPACE("literal:ascii", "^", true);
const AddressSpace EQUATE_SPACE("equate", "Q", true);

const std::vector<AddrSpaceHandle> allSpaces{&CODE_SPACE,        &INIT_DATA_SPACE,     &UNINIT_DATA_SPACE,
                                             &INIT_REMOTE_SPACE, &UNINIT_REMOTE_SPACE, &LITERAL_SPACE,
                                             &EQUATE_SPACE};
