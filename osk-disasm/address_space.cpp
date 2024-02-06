
#include "pch.h"

#include "address_space.h"

#include "dprint.h"

const char* SpaceKinds::getName(SpaceKind kind)
{
    switch (kind)
    {
    case SpaceKind::INITIALIZED:
        return "Initialized";
    case SpaceKind::UNINITIALIZED:
        return "Uninitialized";
    case SpaceKind::LITERAL:
        return "Literal";
    case SpaceKind::NAMED_LITERAL:
        return "Named Literal";
    default:
        throw std::runtime_error("Unreachable");
    }
}

AddressSpace::AddressSpace(const char* name, const char* shortcode, SpaceKind kind, bool allowsAliases, bool isRemote)
    : name(name), shortcode(shortcode), allowsAliases(allowsAliases), kind(kind), isRemote(isRemote)
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

const AddressSpace CODE_SPACE("code", "L", SpaceKind::INITIALIZED);
const AddressSpace INIT_DATA_SPACE("initData", "_", SpaceKind::INITIALIZED);
const AddressSpace UNINIT_DATA_SPACE("uninitData", "D", SpaceKind::UNINITIALIZED);
const AddressSpace INIT_REMOTE_SPACE("initRemote", "H", SpaceKind::INITIALIZED, AddressSpace::isRemote_tag_t{});
const AddressSpace UNINIT_REMOTE_SPACE("uninitRemote", "G", SpaceKind::UNINITIALIZED, AddressSpace::isRemote_tag_t{});
const AddressSpace DEBUG_SPACE("debug", "B", SpaceKind::INITIALIZED);
const AddressSpace UNKNOWN_DATA_SPACE("unknownData", "U", SpaceKind::NAMED_LITERAL);
const AddressSpace LITERAL_SPACE("literal", "@", SpaceKind::LITERAL, AddressSpace::canAlias_tag_t{});
const AddressSpace LITERAL_DEC_SPACE("literal:decimal", "&", SpaceKind::LITERAL, AddressSpace::canAlias_tag_t{});
const AddressSpace LITERAL_HEX_SPACE("literal:hex", "$", SpaceKind::LITERAL, AddressSpace::canAlias_tag_t{});
const AddressSpace LITERAL_ASCII_SPACE("literal:ascii", "^", SpaceKind::LITERAL, AddressSpace::canAlias_tag_t{});
const AddressSpace EQUATE_SPACE("equate", "Q", SpaceKind::NAMED_LITERAL, AddressSpace::canAlias_tag_t{});

const std::vector<AddrSpaceHandle> allSpaces{&CODE_SPACE,        &INIT_DATA_SPACE,     &UNINIT_DATA_SPACE,
                                             &INIT_REMOTE_SPACE, &UNINIT_REMOTE_SPACE, &DEBUG_SPACE, &LITERAL_SPACE,
                                             &EQUATE_SPACE};
