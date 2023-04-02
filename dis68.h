
#ifndef DIS_68_H
#define DIS_68_H

#include <stdio.h>

int main(int argc, char** argv);
FILE* build_path(char* p, char* faccs);
void do_opt(char* c);
__declspec(noreturn) void errexit(char* pmpt);
void filereadexit(void);

#endif
