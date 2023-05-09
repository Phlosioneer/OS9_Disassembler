
#ifndef LABEL_H
#define LABEL_H

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
    Label(char category, int value, const char* name);
    Label(char category, int value, const std::string& name);

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

    void setName(const char* newName);
    void setName(std::string newName);

    std::string nameWithColon() const;

    const char category;
    const long myAddr;

  private:
    std::string _name;

    bool _nameIsDefault;
    bool _stdName;
    bool _global;

    static std::string makeDefaultName(char category, long value);
};

class LabelCategory
{
  public:
    typedef typename std::vector<Label*>::iterator iterator;

    LabelCategory(char code);
    ~LabelCategory();

    const char code;

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

    inline size_t size() const
    {
        return _labels.size();
    }

  private:
    // This list is always sorted by address / value.
    std::vector<Label*> _labels;
    std::map<long, Label*> _labelsByValue;

    // Because of _handle, need to ensure it is always allocated/freed correctly.
    LabelCategory(LabelCategory const&) = delete;
    LabelCategory& operator=(LabelCategory const&) = delete;
    LabelCategory& operator=(LabelCategory&&) = delete;
};

class LabelManager
{
  public:
    std::string validLabelClasses{"_!=ABCDEFGHIJKLMNOPQRSTUVWXYZ\0"};
    LabelManager();
    ~LabelManager();

    LabelCategory* getCategory(char code);
    Label* addLabel(char code, long value, const char* name);
    Label* getLabel(char code, long value);
    void printAll();

  private:
    std::map<char, LabelCategory*> _labelCategories;

    LabelManager(LabelManager const&) = delete;
    LabelManager& operator=(LabelManager const&) = delete;
    LabelManager& operator=(LabelManager&&) = delete;
};

Label* label_getNext(Label* handle);
Label* labelclass_getFirst(LabelCategory* handle);

Label* findlbl(char lblclass, int lblval);
Label* addlbl(char lblclass, int val, const char* newname);
bool LblCalc(char* dst, int adr, int amod, int curloc, bool isRof, int Pass);
void PrintNumber(char* dest, int value, int amod, int PBytSiz, char clas = '\0');
void PrintNumber(std::ostream& dest, int value, int amod, int PBytSiz, char clas = '\0');

extern LabelManager* labelManager;

extern const char lblorder[];

extern const char defaultDefaultLabelClasses[];
extern const char programDefaultLabelClasses[];
extern const char driverDefaultLabelClasses[];
extern char defaultLabelClasses[AM_MAXMODES];

#endif // LABEL_H
