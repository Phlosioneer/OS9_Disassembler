
#ifndef LABEL_H
#define LABEL_H
#include "externc.h"

#define LBLLEN 40

struct cmd_items;

/* Defines a Label */

struct symbol_def;
struct label_class;


#ifdef __cplusplus
extern "C" {
#endif

    const char* label_getName(struct symbol_def* handle);
    void label_setName(struct symbol_def* handle, const char* name);
    long label_getMyAddr(struct symbol_def* handle);
    int label_getStdName(struct symbol_def* handle);
    void label_setStdName(struct symbol_def* handle, int isStdName);
    int label_getGlobal(struct symbol_def* handle);
    void label_setGlobal(struct symbol_def* handle, int isGlobal);
    struct symbol_def* label_getNext(struct symbol_def* handle);

    /* Formerly the field named "cEnt" */
    struct symbol_def* labelclass_getFirst(struct label_class* handle);

    struct label_class* labelclass(char lblclass);
    struct data_bounds* ClasHere(struct data_bounds* bp, int adrs);
    struct symbol_def* findlbl(char lblclass, int lblval);
    char* lblstr(char lblclass, int lblval);
    struct symbol_def* addlbl(char lblclass, int val, const char* newname);
    void process_label(struct cmd_items* ci, char lblclass, int addr);
    void parsetree(char c);
    int LblCalc(char* dst, int adr, int amod, int curloc);

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus

#include <vector>
#include <memory>
#include <map>
#include <string>

class Label {
public:
    Label(char category, int value, const char* name);
    ~Label();

    const char category;
    const long myAddr;

    inline char* name() { return _name; }
    inline bool stdName() { return _stdName; }
    inline void setStdName(bool isStdName) { _stdName = isStdName; }
    inline bool global() { return _global; }
    inline void setGlobal(bool isGlobal) { _global = isGlobal; }
    inline symbol_def* handle() { return _handle; }

    void setName(const char* newName);

private:
    char _name[LBLLEN + 1];
    
    bool _stdName;
    bool _global;
    symbol_def* _handle;

    // Because of _handle, need to ensure it is always allocated/freed correctly.
    Label(Label const&) = delete;
    Label& operator=(Label const&) = delete;
    Label& operator=(Label&&) = delete;
};

class LabelCategory {
public:
    typedef typename std::vector<Label*>::iterator iterator;

    LabelCategory(char code);
    ~LabelCategory();
    
    const char code;
    
    inline label_class* handle() { return _handle; }
    inline iterator begin() { return _labels.begin(); }
    inline iterator end() { return _labels.end(); }
    Label* add(long value, const char* newName);
    Label* get(long value);
    void printAll();
    Label* getNextAfter(Label* label);
    Label* getFirst();

private:
    // This list is always sorted by address / value.
    std::vector<Label*> _labels;
    label_class* _handle;
    std::map<long, Label*> _labelsByValue;

    // Because of _handle, need to ensure it is always allocated/freed correctly.
    LabelCategory(LabelCategory const&) = delete;
    LabelCategory& operator=(LabelCategory const&) = delete;
    LabelCategory& operator=(LabelCategory&&) = delete;
};

class LabelManager {
public:
    std::string validLabelClasses{ "_!=ABCDEFGHIJKLMNOPQRSTUVWXYZ\0" };
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

extern LabelManager *labelManager;

#endif // __cplusplus




#ifdef __cplusplus

struct symbol_def {
    Label* inner;
};

struct label_class {
    LabelCategory* inner;
};

#else // __cplusplus

struct symbol_def {
    void* inner;
};

struct label_class {
    void* inner;
};

#endif // __cplusplus


cglobal const char lblorder[];
cglobal char DfltLbls[];

#endif // LABEL_H
