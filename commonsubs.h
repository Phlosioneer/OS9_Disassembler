
#ifndef COMMON_SUBS_H
#define COMMON_SUBS_H

#include <stdio.h>
#include "structs.h"
#include "userdef.h"

// Util
int revbits(int num, int lgth);

// Parsing
int strpos(char* s, char c);
char* skipblank(char* p);

// IO
unsigned int fget_w(FILE* fp);
unsigned int fget_l(FILE* fp);
char fread_b(FILE* fp);
short fread_w(FILE* fp);
int fread_l(FILE* fp);
short bufReadW(char** pt);
int bufReadL(char** pt);
char* freadString(FILE* fp);

// Memory
void* mem_alloc(size_t req);


#endif