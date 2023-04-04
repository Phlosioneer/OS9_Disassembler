
#ifndef COMMAND_ITEMS_H
#define COMMAND_ITEMS_H

#include "disglobs.h"
#include "externc.h"

struct opst;

/*
struct cmd_items_inner;

struct cmd_items {
    struct cmd_items_inner* inner;
};
*/

#define LABEL_LEN 200
#define MNEM_LEN 50
#define CODE_LEN 10
#define OPCODE_LEN 200
#define COMMENT_LEN 200

struct cmd_items {
    int cmd_wrd;        // The single effective address word (the command)
    //char lblname[LABEL_LEN];
    char* lblname;
    char mnem[MNEM_LEN];
    short code[CODE_LEN];
    int wcount;         // The count of words in the instrct/.(except sea)
    char params[OPCODE_LEN];   // Possibly ovesized, but just to be safe
    //char comment[COMMENT_LEN];     // Inline comment - NULL if none
    char *comment;
    struct extWbrief extend;   // The extended command (if present)
};

/*
cfunc int instr_getOpWord(struct cmd_items* handle);
cfunc const char* instr_getLabel(struct cmd_items* handle);
cfunc const char* instr_getMneumonic(struct cmd_items* handle);
cfunc short* instr_getCode(struct cmd_items* handle);
cfunc int instr_getWordCount(struct cmd_items* handle);
cfunc const char* instr_getOpCode(struct cmd_items* handle);
cfunc const char* instr_getComment(struct cmd_items* handle);

cfunc void instr_setLabel(struct cmd_items* handle, char* name);
cfunc void instr_setOpcode(struct cmd_items* handle, const char* opcode);
cfunc void instr_setMneumonic(struct cmd_items* handle, const char* s);
cfunc void instr_setComment(struct cmd_items* handle, const char* s);

cfunc struct cmd_items* instr_new();
cfunc void instr_delete(struct cmd_items* handle);
*/

cfunc int get_eff_addr(struct cmd_items* ci, char* ea, int mode, int reg, int size);
cfunc int get_ext_wrd(struct cmd_items* ci, struct extWbrief* extW, int mode, int reg);
cfunc int process_extended_word_full(struct cmd_items* ci, char* dststr, struct extWbrief* ew, int mode,
    int reg, int size);
cfunc int process_extended_word_brief(struct cmd_items* ci, char* dststr, struct extWbrief* ew_b,
    int mode, int reg, int size);
cfunc void get_displ(struct cmd_items* ci, char* dst, int siz_flag);
cfunc int set_indirect_idx(char* dest, struct extWbrief* extW);

cfunc int reg_ea(struct cmd_items* ci, int j, struct opst* op);
cfunc char* regbyte(char* s, unsigned char regmask, char* ad, int doslash);
cfunc int movem_cmd(struct cmd_items* ci, int j, struct opst* op);
cfunc int link_unlk(struct cmd_items* ci, int j, struct opst* op);
cfunc int getnext_w(struct cmd_items* ci);
cfunc void ungetnext_w(struct cmd_items* ci);
cfunc struct cmd_items* initcmditems(struct cmd_items* ci);

// Unused
cfunc int get_extends_common(struct cmd_items* ci, char* mnem);
cfunc int ctl_addrmodesonly(int mode, int reg);
cfunc char getnext_b(struct cmd_items* ci);

cglobal struct cmd_items Instruction;
cglobal char* SizSufx[3];

#endif // COMMAND_ITEMS_H