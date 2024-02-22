
#ifndef LABEL_H
#define LABEL_H

#include "pch.h"

#include "address_space_handle.h"
#include "disglobs.h"
#include "size.h"

class Label
{
  public:
    Label(AddrSpaceHandle category, int value);
    Label(AddrSpaceHandle category, int value, std::string&& name);

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
    inline uint32_t address() const
    {
        return static_cast<uint32_t>(value);
    }

    void setName(const char* newName);
    void setName(std::string newName);

    std::string nameWithColon() const;

    const AddrSpaceHandle category;
    const long value;

  private:
    std::string _name;

    bool _nameIsDefault;
    bool _stdName;
    bool _global;
};

class LabelCategory
{
  public:
    typedef typename std::vector<std::shared_ptr<Label>>::iterator iterator;
    typedef typename std::vector<std::shared_ptr<Label>>::const_iterator const_iterator;

    LabelCategory(AddrSpaceHandle code);

    // Deleted copy constructor to avoid bugs. Plain `auto` defaults to copy instead of
    // reference!
    LabelCategory(const LabelCategory& other) = delete;

    const AddrSpaceHandle code;

    inline iterator begin()
    {
        return _labels.begin();
    }
    inline iterator end()
    {
        return _labels.end();
    }
    inline const_iterator cbegin() const
    {
        return _labels.cbegin();
    }
    inline const_iterator cend() const
    {
        return _labels.cend();
    }

    std::shared_ptr<Label> add(long value);
    std::shared_ptr<Label> add(long value, std::string&& newName);
    std::shared_ptr<Label> get(long value);
    void printAll();
    std::shared_ptr<Label> getFirst();
    void addRedirect(long addr, std::shared_ptr<Label> label);

    inline size_t size() const
    {
        return _labels.size();
    }

  private:
    // This list is always sorted by address / value.
    std::vector<std::shared_ptr<Label>> _labels;
    std::unordered_map<long, std::shared_ptr<Label>> _labelsByValue;
    std::unordered_map<long, std::shared_ptr<Label>> _labelRedirects;
};

class LabelManager
{
  public:
    LabelManager();

    LabelCategory& getCategory(AddrSpaceHandle code);
    std::shared_ptr<Label> addLabel(AddrSpaceHandle code, long value);
    std::shared_ptr<Label> addLabel(AddrSpaceHandle code, long value, std::string&& name);
    std::shared_ptr<Label> getLabel(AddrSpaceHandle code, long value);
    void printAll();
    void clear();

  private:
    std::unordered_map<std::string, LabelCategory> _labelCategories;
};

bool LblCalc(std::string& out_name, uint32_t adr, int amod, uint32_t curloc, bool isRof, int Pass,
             OperandSize sizeConstraint);
void PrintNumber(std::ostream& dest, int value, int amod, OperandSize defaultHexSize, AddrSpaceHandle space = nullptr);
std::string PrintNumber(int value, int amod, OperandSize defaultHexSize, AddrSpaceHandle space = nullptr);

extern LabelManager labelManager;

#endif // LABEL_H
