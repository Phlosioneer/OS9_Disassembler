
#ifndef LABEL_H
#define LABEL_H

#define LBLLEN 40

/* Defines a Label */

typedef struct symbol_def {
    char sname[LBLLEN + 1];         /* Symbol name */
    long myaddr;                  /* Address of symbol */
    int stdname;                  /* Flag that it's a std named label */
    int global;                   /* For ROF use... flags that it's global */
    struct symbol_def* Next;           /* Next */
/*    struct symbol_def *More;*/
    struct symbol_def* Prev;           /* Previous entry */
} LABEL_DEF;

typedef struct {
    char lclass;
    LABEL_DEF* cEnt;
} LABEL_CLASS;

LABEL_CLASS* labelclass(char lblclass);
void PrintLbl(char* dest, char clas, int adr, LABEL_DEF* dl, int amod);
struct data_bounds* ClasHere(struct data_bounds* bp, int adrs);
LABEL_DEF* findlbl(char lblclass, int lblval);
char* lblstr(char lblclass, int lblval);
LABEL_DEF* addlbl(char lblclass, int val, char* newname);
void process_label(CMD_ITEMS* ci, char lblclass, int addr);
void parsetree(char c);
int LblCalc(char* dst, int adr, int amod, int curloc);

#endif
