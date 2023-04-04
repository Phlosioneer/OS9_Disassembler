
#ifndef CMDFILE_H
#define CMDFILE_H

void do_cmd_file(void);
int ApndCmnt(char* lpos);
char* cmntsetup(char* cpos, char* clas, int* adrs);
char* cmdsplit(char* dest, char* src);
void getrange(char* pt, int* lo, int* hi, int usize, int allowopen);
void boundsline(char* mypos);
void setupbounds(char* lpos);
void tellme(char* pt);

#endif
