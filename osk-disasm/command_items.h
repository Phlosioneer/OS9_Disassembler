
#ifndef COMMAND_ITEMS_H
#define COMMAND_ITEMS_H

#include "pch.h"

//#include <ostream>

#include "disglobs.h"
#include "params.h"
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
    std::string lblname{};
    char mnem[MNEM_LEN]{};
    short code[CODE_LEN]{};
    int wcount = 0;            // The count of words in the instrct/.(except sea)
    char params[OPCODE_LEN]{}; // Possibly ovesized, but just to be safe
    // char comment[COMMENT_LEN];     // Inline comment - NULL if none
    char* comment = "";
    extWbrief extend{}; // The extended command (if present)

    bool useNewParams = false;
    std::unique_ptr<InstrParam> source{};
    std::unique_ptr<InstrParam> dest{};

    void setSource(const LiteralParam& param);
    void setSource(const RegParam& param);
    void setSource(const AbsoluteAddrParam& param);
    void setSource(const RegOffsetParam& param);

    void setDest(const LiteralParam& param);
    void setDest(const RegParam& param);
    void setDest(const AbsoluteAddrParam& param);
    void setDest(const RegOffsetParam& param);

    std::string renderNewParams() const;

    // Allow move-assignment
    struct cmd_items& operator=(struct cmd_items&& other);
    // But not copy-assignment
    struct cmd_items& operator=(const struct cmd_items& other) = delete;
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
std::unique_ptr<InstrParam> get_eff_addr(struct cmd_items* ci, uint8_t mode, uint8_t reg, uint8_t size,
                                         struct parse_state* state);
std::unique_ptr<InstrParam> get_eff_addr(struct cmd_items* ci, uint8_t mode, uint8_t reg, OperandSize size,
                                         struct parse_state* state, AddrSpaceHandle literalSpaceHint = nullptr);
int get_ext_wrd(struct cmd_items* ci, struct extWbrief* extW, int mode, int reg, struct parse_state* state);

int reg_ea(struct cmd_items* ci, const struct opst* op, struct parse_state* state);
int movem_cmd(struct cmd_items* ci, const struct opst* op, struct parse_state* state);
int link_unlk(struct cmd_items* ci, const struct opst* op, struct parse_state* state);
bool hasnext_w(struct parse_state* state);
int getnext_w(struct cmd_items* ci, struct parse_state* state);
void ungetnext_w(struct cmd_items* ci, struct parse_state* state);

// Unused
char getnext_b(struct cmd_items* ci, struct parse_state* state);

extern const char* SizSufx[3];
extern const char dispRegNam[];

#endif // COMMAND_ITEMS_H