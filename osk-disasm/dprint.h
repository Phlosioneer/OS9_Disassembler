
#ifndef DPRINT_H
#define DPRINT_H

#include "address_space.h"
#include "label.h"
#include "rof.h"
#include "userdef.h"

#include <string>

struct cmd_items;

/*
 * ireflist structure: Represents an entry in the Initialized Refs
 *       list.
 */
// TODO: Replace this with a simple vector.
struct ireflist
{
    struct ireflist* Prev = nullptr;
    struct ireflist* Next = nullptr;
    // I think this should be uint32_t
    int32_t dAddr = 0;
    AddrSpaceHandle space = nullptr;
};

template <typename T>
class PrettyNumber;

template <typename T>
std::ostream& operator<<(std::ostream& os, const PrettyNumber<T>& self);

template <typename T>
class PrettyNumber
{
  public:
    PrettyNumber(T number)
        : _number(number), _hasFill(false), _hasWidth(false), _forcePlusSign(false), _fill('0'), _width(0),
          _format(Format::Unset)
    {
    }

    PrettyNumber<T>& number(T number)
    {
        _number = number;
        return *this;
    }

    PrettyNumber<T>& fill(char c)
    {
        _hasFill = true;
        _fill = c;
        return *this;
    }

    PrettyNumber<T>& width(size_t size)
    {
        _hasWidth = true;
        _width = size;
        return *this;
    }

    PrettyNumber<T>& decimal()
    {
        _format = Format::Decimal;
        return *this;
    }

    PrettyNumber<T>& hex()
    {
        _format = Format::Hex;
        return *this;
    }

    PrettyNumber<T>& showPlus()
    {
        _forcePlusSign = true;
        return *this;
    }

  private:
    enum class Format
    {
        Unset,
        Decimal,
        Hex
    };

    bool _hasFill;
    bool _hasWidth;
    bool _forcePlusSign;
    char _fill;
    Format _format;
    size_t _width;
    T _number;

    friend std::ostream& operator<<<T>(std::ostream& os, const PrettyNumber<T>& self);
};

template <typename T>
std::ostream& operator<<(std::ostream& os, const PrettyNumber<T>& self)
{
    auto prevFill = os.fill();
    auto prevWidth = os.width();
    auto prevFlags = os.flags();

    if (self._hasFill) os.fill(self._fill);
    if (self._hasWidth) os.width(self._width);
    switch (self._format)
    {
    case PrettyNumber<T>::Format::Unset:
        break;
    case PrettyNumber<T>::Format::Decimal:
        os.setf(std::ios_base::dec, std::ios_base::basefield);
        break;
    case PrettyNumber<T>::Format::Hex:
        os.setf(std::ios_base::hex, std::ios_base::basefield);
        break;
    default:
        throw std::exception();
    }

    if (self._forcePlusSign && self._number >= 0)
    {
        os << '+';
    }
    os << self._number;

    if (self._hasFill) os.fill(prevFill);
    if (self._hasWidth) os.width(prevWidth);
    if (self._format != PrettyNumber<T>::Format::Unset) os.setf(prevFlags);

    return os;
}

void PrintPsect(struct options* opt);
void PrintLine(const char* pfmt, struct cmd_items* ci, AddrSpaceHandle space, int CmdEnt, struct options* opt);
void printXtraBytes(std::string& data);
void ROFPsect(struct options* opt);
void WrtEnds(struct options* opt, int PCPos);
void ParseIRefs(AddrSpaceHandle space, struct options* opt);
void GetIRefs(struct options* opt);
int DoAsciiBlock(struct cmd_items* ci, uint32_t blockSize, AddrSpaceHandle space, struct parse_state* state);
int DoAsciiBlock(struct cmd_items* ci, const char* buf, unsigned int bufEnd, AddrSpaceHandle iSpace,
                 struct parse_state* state);
void ROFDataPrint(struct options* opt);
void OS9DataPrint(struct options* opt);
void ListUninitData(uint32_t maxAddress, AddrSpaceHandle space, struct options* opt);
void WrtEquates(int stdflg, struct options* opt);
void ListInit(refmap* refsList, AddrSpaceHandle iClass, struct parse_state* state);

extern const char pseudcmd[80];
extern const char realcmd[80];
extern int PrevEnt;
extern int LinNum;
extern struct ireflist* IRefs;

#endif
