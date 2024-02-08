#pragma once

// Separated from the address_space.h file for improved compile speed, since it has
// so many inline items and there's no way to pre-declare AddrSpaceHandle.

class AddressSpace;

typedef const AddressSpace* AddrSpaceHandle;