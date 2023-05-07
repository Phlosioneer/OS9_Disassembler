
#ifndef COMMON_SUBS_H
#define COMMON_SUBS_H

#include "userdef.h"
#include <fstream>
#include <stdio.h>

struct ifstream_handle
{
    std::ifstream* inner;
};

// Returns the index of a character in a string, or -1 if not found.
// Pure function
int strpos(const char* s, char c);

// Advances past any space, tab, or any newline character in the string.
// Pure function
char* skipblank(char* p);

// Reverses the bit order for a value. `Length` is given in bits.
// Pure function
unsigned int revbits(unsigned int num, int length);

// IO
unsigned char fread_b(FILE* fp);
unsigned short fread_w(FILE* fp);
unsigned int fread_l(FILE* fp);
unsigned short bufReadW(char** pt);
unsigned int bufReadL(char** pt);
char* freadString(FILE* fp);

#endif