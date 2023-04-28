
#ifndef CMDFILE_H
#define CMDFILE_H

#include "structs.h"
#include <stdio.h>

void do_cmd_file(struct options* opt);
char* cmdsplit(char* dest, char* src);
void getrange(char* pt, int* lo, int* hi, int usize, int allowopen, int GettingAmode);
void boundsline(char* mypos);
void setupbounds(char* lpos);

extern struct data_bounds* dbounds;
extern struct data_bounds* LAdds[];

#endif
