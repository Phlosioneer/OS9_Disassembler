
#ifndef COMMAND_ITEMS_H
#define COMMAND_ITEMS_H

#include "pch.h"

#include <array>

#include "disglobs.h"
#include "params.h"
#include "reader.h"

struct OPSTRUCTURE;
struct options;
class RawParam;

struct cmd_items
{
  public:

    uint16_t cmd_wrd = 0;
    std::string lblname{};
    std::string mnem{};
    std::string comment{};
    std::unique_ptr<InstrParam> source{};
    std::unique_ptr<InstrParam> dest{};

    static constexpr size_t RAW_DATA_MAX = 10;
    uint16_t rawData[RAW_DATA_MAX]{};
    size_t rawDataSize = 0;

    bool forceRelativeImmediateMode = false;

    void setSource(const LiteralParam& param);
    void setSource(const RegParam& param);
    void setSource(const AbsoluteAddrParam& param);
    void setSource(const RegOffsetParam& param);
    void setSource(const MultiRegParam& param);

    void setDest(const LiteralParam& param);
    void setDest(const RegParam& param);
    void setDest(const AbsoluteAddrParam& param);
    void setDest(const RegOffsetParam& param);
    void setDest(const MultiRegParam& param);

    std::string renderParams() const;

    inline uint16_t cmd() const
    {
        if (rawDataSize == 0) throw std::runtime_error("No command word available");
        return rawData[0];
    }

    // Allow move-assignment
    struct cmd_items& operator=(struct cmd_items&& other) noexcept;
    // But not copy-assignment
    struct cmd_items& operator=(const struct cmd_items& other) = delete;
};

class EofException : public std::exception
{
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

std::unique_ptr<InstrParam> get_eff_addr(struct cmd_items* ci, uint8_t mode, uint8_t reg, OperandSize size,
                                         struct parse_state* state, AddrSpaceHandle literalSpaceHint = nullptr);

int reg_ea(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int cmd_movem(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int link_unlk(struct cmd_items* ci, const OPSTRUCTURE* op, struct parse_state* state);
int getnext_w(struct cmd_items* ci, struct parse_state* state);
void ungetnext_w(struct cmd_items* ci, struct parse_state* state);

std::unique_ptr<RawParam> parseImmediateParam(parse_state* state, OperandSize size);

// Unused
char getnext_b(struct cmd_items* ci, struct parse_state* state);

bool hasnext_w(parse_state* state);
bool hasnext_l(parse_state* state);
uint16_t getnext_w_raw(parse_state* state);
uint32_t getnext_l_raw(parse_state* state);
void ungetnext_w_raw(parse_state* state);
void ungetnext_l_raw(parse_state* state);

#endif // COMMAND_ITEMS_H