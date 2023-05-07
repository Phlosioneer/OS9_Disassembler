
#ifndef DIS_68_H
#define DIS_68_H

#include <stdio.h>

#include "reader.h"

#define MAX_LBFIL 32
struct options
{
    int PrintAllCode;
    char* CmdFileName;
    FILE* CmdFP;
    struct writer_handle* asmFile;
    int IsROF;
    /* Count of Label files specified     */
    int LblFilz;
    /* Pointers to the path names for the files */
    char* LblFNam[MAX_LBFIL];
    int PgWidth;
    int IsUnformatted;
    char* DefDir;
    char* ModFile;
    BigEndianStream* Module;
};

void usage(void);
struct options* getoptions(int argc, char** argv);
FILE* build_path(char* p, char* faccs, struct options* opt);
void do_opt(char* c, struct options* opt);
char* pass_eq(char* p);
void readModuleFile(options* opt);

struct options* options_new();
void options_destroy(struct options* opt);
void options_addLabelFile(struct options* opt, const char* name);

extern char* PsectName;
extern int ExtBegin; /* The position of the begin of the extended list (for PC-Relative addressing) */

#endif
