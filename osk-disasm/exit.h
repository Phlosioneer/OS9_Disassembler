
#ifndef EXIT_H
#define EXIT_H

#include "externc.h"

cfunc __declspec(noreturn) void errexit(char* pmpt);
cfunc void filereadexit(void);

#endif // EXIT_H