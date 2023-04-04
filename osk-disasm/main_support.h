
#ifndef DIS_68_H
#define DIS_68_H

#include <stdio.h>

void usage(void);
void getoptions(int argc, char** argv);
FILE* build_path(char* p, char* faccs);
void do_opt(char* c);
char* pass_eq(char* p);

#endif
