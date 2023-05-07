
#ifndef DIS_68_H
#define DIS_68_H

#include <stdio.h>
#include <string>
#include <vector>
#include <memory>

#include "reader.h"

struct options
{
    int PrintAllCode = 0;
    std::string CmdFileName{};
    FILE* CmdFP = nullptr;
    struct writer_handle* asmFile = nullptr;
    bool IsROF = false;
    /* Pointers to the path names for the files */
    std::vector<std::string> labelFiles{};
    int PgWidth = 80;
    bool IsUnformatted = false;
    std::string DefDir{};
    std::string ModFile{};
    std::unique_ptr<BigEndianStream> Module{};

    ~options();
};

void usage(void);
std::unique_ptr<options> getoptions(int argc, char** argv);
FILE* build_path(const std::string& p, char* faccs, struct options* opt);
void do_opt(char* c, struct options* opt);
char* pass_eq(char* p);
void readModuleFile(options* opt);

extern char* PsectName;
extern int ExtBegin; /* The position of the begin of the extended list (for PC-Relative addressing) */

#endif
