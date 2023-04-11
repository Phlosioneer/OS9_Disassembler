
#ifndef COMMON_SUBS_H
#define COMMON_SUBS_H

#include <stdio.h>
#include "structs.h"
#include "userdef.h"
#include "externc.h"

#ifdef __cplusplus
#include <fstream>

struct ifstream_handle {
	std::ifstream* inner;
};
#else
struct ifstream_handle {
	void* inner;
};
#endif // __cplusplus

// Returns the index of a character in a string, or -1 if not found.
// Pure function
cfunc int strpos(const char* s, char c);

// Advances past any space, tab, or any newline character in the string.
// Pure function
cfunc char* skipblank(char* p);

// Reverses the bit order for a value. `Length` is given in bits.
// Pure function
cfunc unsigned int revbits(unsigned int num, int length);

// IO
cfunc unsigned char fread_b(FILE* fp);
cfunc unsigned short fread_w(FILE* fp);
cfunc unsigned int fread_l(FILE* fp);
cfunc unsigned short bufReadW(char** pt);
cfunc unsigned int bufReadL(char** pt);
cfunc char* freadString(FILE* fp);

// Memory
cfunc void* mem_alloc(size_t size);


#endif