
#ifndef COMMAND_ITEMS_H
#define COMMAND_ITEMS_H

struct cmd_items {
    int cmd_wrd;        /* The single effective address word (the command) */
    char* lblname;
    char mnem[50];
    short code[10];
    int wcount;         /* The count of words in the instrct/.(except sea) */
    char opcode[200];   /* Possibly ovesized, but just to be safe */
    char* comment;     /* Inline comment - NULL if none */
    /*struct extWbrief extend;*/   /* The extended command (if present) */
};

#ifdef __cplusplus
extern "C"
#else
extern
#endif
struct cmd_items Instruction;

#endif // COMMAND_ITEMS_H