
#ifndef COMMON_SUBS_H
#define COMMON_SUBS_H

#include <stdio.h>
#include "structs.h"
#include "userdef.h"
#include "externc.h"

// Util
cfunc int revbits(int num, int lgth);

// Parsing
cfunc int strpos(const char* s, char c);
cfunc char* skipblank(char* p);

// IO
cfunc unsigned int fget_w(FILE* fp);
cfunc unsigned int fget_l(FILE* fp);
cfunc char fread_b(FILE* fp);
cfunc short fread_w(FILE* fp);
cfunc int fread_l(FILE* fp);
cfunc short bufReadW(char** pt);
cfunc int bufReadL(char** pt);
cfunc char* freadString(FILE* fp);

// Memory
cfunc void* mem_alloc(size_t req);


#endif