
#ifndef DPRINT_H
#define DPRINT_H

#include "userdef.h"
#include "externc.h"

struct cmd_items;

/* ******************
 * ireflist structure: Represents an entry in the Initialized Refs
 *       list.
 */

struct ireflist {
    struct ireflist *Prev;
    struct ireflist *Next;
    int dAddr;
};

cfunc void PrintPsect(struct options* opt);
cfunc char* get_apcomment(char clas, int addr);
cfunc void PrintLine(const char* pfmt, struct cmd_items* ci, char cClass, int cmdlow, int cmdhi, struct options* opt);
cfunc void printXtraBytes(char* data);
cfunc void PrintComment(char lblcClass, int cmdlow, int cmdhi, struct options* opt);
cfunc void ROFPsect(struct rof_header* rptr, struct options* opt);
cfunc void WrtEnds(struct options* opt);
cfunc void ParseIRefs(char rClass, struct options* opt);
cfunc void GetIRefs(struct options* opt);
cfunc int DoAsciiBlock(struct cmd_items* ci, const char* buf, int bufEnd, char iClass, struct options* opt);
cfunc void ROFDataPrint(struct options* opt);
cfunc void OS9DataPrint(struct options* opt);
cfunc void ListData(struct symbol_def* me, int upadr, char cClass, struct options* opt);
cfunc void WrtEquates(int stdflg, struct options* opt);

cglobal const char pseudcmd[80];
cglobal const char realcmd[80];
cglobal int PrevEnt;
cglobal int LinNum;
cglobal char EaString[200]; /* Buffer to hold the effective address. */
cglobal struct ireflist* IRefs;

/* Comments tree */

cglobal struct comment_tree* Comments[33];
cglobal struct append_comment* CmntApnd[33];

#endif
