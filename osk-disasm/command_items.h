
#ifndef COMMAND_ITEMS_H
#define COMMAND_ITEMS_H

#include <ostream>
#include <stdio.h>

#include "disglobs.h"
#include "reader.h"

struct opst;
struct options;

#define LABEL_LEN 200
#define MNEM_LEN 50
#define CODE_LEN 10
#define OPCODE_LEN 200
#define COMMENT_LEN 200

struct cmd_items
{
    int cmd_wrd = 0; // The single effective address word (the command)
    // char lblname[LABEL_LEN];
    char* lblname = nullptr;
    char mnem[MNEM_LEN]{};
    short code[CODE_LEN]{};
    int wcount = 0;            // The count of words in the instrct/.(except sea)
    char params[OPCODE_LEN]{}; // Possibly ovesized, but just to be safe
    // char comment[COMMENT_LEN];     // Inline comment - NULL if none
    char* comment = nullptr;
    extWbrief extend{}; // The extended command (if present)
};

struct parse_state
{
    uint32_t PCPos = 0;
    uint32_t CmdEnt = 0; /* The entry point for the instruction / command */
    int Pass = 0;        /* The disassembler is a two-pass assembler */
    BigEndianStream* Module = nullptr;

    // Temporary?
    struct options* opt = nullptr;
};

int get_eff_addr(struct cmd_items* ci, char* ea, int mode, int reg, int size, struct parse_state* state);
int get_ext_wrd(struct cmd_items* ci, struct extWbrief* extW, int mode, int reg, struct parse_state* state);

int reg_ea(struct cmd_items* ci, int j, const struct opst* op, struct parse_state* state);
int movem_cmd(struct cmd_items* ci, int j, const struct opst* op, struct parse_state* state);
int link_unlk(struct cmd_items* ci, int j, const struct opst* op, struct parse_state* state);
int getnext_w(struct cmd_items* ci, struct parse_state* state);
void ungetnext_w(struct cmd_items* ci, struct parse_state* state);
struct cmd_items* initcmditems(struct cmd_items* ci);

// Unused
char getnext_b(struct cmd_items* ci, struct parse_state* state);

extern struct cmd_items Instruction;
extern const char* SizSufx[3];
extern const char dispRegNam[];

#endif // COMMAND_ITEMS_H