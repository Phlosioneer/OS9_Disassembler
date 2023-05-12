
#ifndef LABEL_H
#define LABEL_H

#include "address_space.h"
#include "disglobs.h"

#define LBLLEN 40

struct cmd_items;

#include <map>
#include <memory>
#include <string>
#include <vector>

class Label
{
  public:
    Label(AddrSpaceHandle category, int value, const char* name);
    Label(AddrSpaceHandle category, int value, const std::string& name);

    inline const std::string& name() const
    {
        return _name;
    }
    inline bool stdName() const
    {
        return _stdName;
    }
    inline void setStdName(bool isStdName)
    {
        _stdName = isStdName;
    }
    inline bool global() const
    {
        return _global;
    }
    inline void setGlobal(bool isGlobal)
    {
        _global = isGlobal;
    }
    inline bool nameIsDefault() const
    {
        return _nameIsDefault;
    }

    void setName(const char* newName);
    void setName(std::string newName);

    std::string nameWithColon() const;

    const AddrSpaceHandle category;
    const long myAddr;

  private:
    std::string _name;

    bool _nameIsDefault;
    bool _stdName;
    bool _global;
};

class LabelCategory
{
  public:
    typedef typename std::vector<Label*>::iterator iterator;

    LabelCategory(AddrSpaceHandle code);
    ~LabelCategory();

    const AddrSpaceHandle code;

    inline iterator begin()
    {
        return _labels.begin();
    }
    inline iterator end()
    {
        return _labels.end();
    }
    Label* add(long value, const char* newName);
    Label* get(long value);
    void printAll();
    Label* getNextAfter(Label* label);
    Label* getFirst();
    void addRedirect(long addr, Label* label);

    inline size_t size() const
    {
        return _labels.size();
    }

  private:
    // This list is always sorted by address / value.
    std::vector<Label*> _labels;
    std::map<long, Label*> _labelsByValue;
    std::map<long, Label*> _labelRedirects;

    // Because of _handle, need to ensure it is always allocated/freed correctly.
    LabelCategory(LabelCategory const&) = delete;
    LabelCategory& operator=(LabelCategory const&) = delete;
    LabelCategory& operator=(LabelCategory&&) = delete;
};

class LabelManager
{
  public:
    LabelManager();
    ~LabelManager();

    LabelCategory* getCategory(AddrSpaceHandle code);
    Label* addLabel(AddrSpaceHandle code, long value, const char* name);
    Label* getLabel(AddrSpaceHandle code, long value);
    void printAll();

  private:
    std::map<std::string, LabelCategory*> _labelCategories;

    LabelManager(LabelManager const&) = delete;
    LabelManager& operator=(LabelManager const&) = delete;
    LabelManager& operator=(LabelManager&&) = delete;
};

Label* label_getNext(Label* handle);
Label* labelclass_getFirst(LabelCategory* handle);

Label* findlbl(AddrSpaceHandle lblclass, int lblval);
Label* addlbl(AddrSpaceHandle lblclass, int val, const char* newname);
bool LblCalc(char* dst, int adr, int amod, int curloc, bool isRof, int Pass);
void PrintNumber(char* dest, int value, int amod, int PBytSiz, AddrSpaceHandle space = nullptr);
void PrintNumber(std::ostream& dest, int value, int amod, int PBytSiz, AddrSpaceHandle space = nullptr);

extern LabelManager* labelManager;

extern const char defaultDefaultLabelClasses[];
extern const char programDefaultLabelClasses[];
extern const char driverDefaultLabelClasses[];
extern char defaultLabelClasses[AM_MAXMODES];

#endif // LABEL_H
