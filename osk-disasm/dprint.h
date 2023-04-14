
#ifndef DPRINT_H
#define DPRINT_H

#include "userdef.h"


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

void PrintPsect(struct options* opt);
char* get_apcomment(char clas, int addr);
void PrintLine(const char* pfmt, struct cmd_items* ci, char cClass, int cmdlow, int cmdhi, struct options* opt);
void printXtraBytes(char* data);
void PrintComment(char lblcClass, int cmdlow, int cmdhi, struct options* opt);
void ROFPsect(struct rof_header* rptr, struct options* opt);
void WrtEnds(struct options* opt);
void ParseIRefs(char rClass, struct options* opt);
void GetIRefs(struct options* opt);
int DoAsciiBlock(struct cmd_items* ci, const char* buf, int bufEnd, char iClass, struct options* opt);
void ROFDataPrint(struct options* opt);
void OS9DataPrint(struct options* opt);
void ListData(struct symbol_def* me, int upadr, char cClass, struct options* opt);
void WrtEquates(int stdflg, struct options* opt);

extern const char pseudcmd[80];
extern const char realcmd[80];
extern int PrevEnt;
extern int LinNum;
extern char EaString[200]; /* Buffer to hold the effective address. */
extern struct ireflist* IRefs;

/* Comments tree */

extern struct comment_tree* Comments[33];
extern struct append_comment* CmntApnd[33];

#endif
