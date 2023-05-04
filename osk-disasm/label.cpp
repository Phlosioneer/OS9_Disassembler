/* ******************************************************************** *
 * lblfuncs.c - Functions related to labels and amodes                  *
 *                                                                      *
 * ******************************************************************** *
 *                                                                      *
 * Copyright (c) 2017 David Breeding                                    *
 *                                                                      *
 * This file is part of osk-disasm.                                     *
 *                                                                      *
 * osk-disasm is free software: you can redistribute it and/or modify   *
 * it under the terms of the GNU General Public License as published by *
 * the Free Software Foundation, either version 3 of the License, or    *
 * (at your option) any later version.                                  *
 *                                                                      *
 * osk-disasm is distributed in the hope that it will be useful,        *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of       *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        *
 * GNU General Public License for more details.                         *
 *                                                                      *
 * You should have received a copy of the GNU General Public License    *
 * (see the file "COPYING") along with osk-disasm.  If not,             *
 * see <http://www.gnu.org/licenses/>.                                  *
 *                                                                      *
 * ******************************************************************** */

#include <map>
#include <sstream>
#include <string>

#include "userdef.h"
#include <ctype.h>
#include <string.h>

#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "label.h"
#include "main_support.h"
#include "params.h"
#include "rof.h"

LabelManager* labelManager = new LabelManager();

const char lblorder[] = "_!^$&@%ABCDEFGHIJKLMNOPQRSTUVWXYZ";

const char defaultDefaultLabelClasses[] = "&&&&&&D&&LLL"; //"&&&&&&D&&LLLLLL";
const char programDefaultLabelClasses[] = "&&&&&&D&&&&L";
const char driverDefaultLabelClasses[] = "&ZD&PG&&&&&L";

char defaultLabelClasses[AM_MAXMODES];

static_assert(sizeof(defaultDefaultLabelClasses) == AM_MAXMODES, "Wrong number of default labels");
static_assert(sizeof(programDefaultLabelClasses) == AM_MAXMODES, "Wrong number of program labels");
static_assert(sizeof(driverDefaultLabelClasses) == AM_MAXMODES, "Wrong number of driver labels");

Label* label_getNext(Label* handle)
{
    return labelManager->getCategory(handle->category)->getNextAfter(handle);
}

Label* labelclass_getFirst(LabelCategory* handle)
{
    return handle->getFirst();
}

/*
 * Add a label to the list
 *        Does nothing for class '^', '@', '$', or '&'
 *        if the label exists, and a different name is provided, renames the label
 * Passed : (1) char label class
 *          (2) int the address for the label
 *          (3) char * - the name for the label
 *              If NULL or empty string, the hex address of the label prepended with
 *              the class letter is used.
 */
Label* addlbl(char lblclass, int value, const char* newName)
{
    if (strchr("^@$&", lblclass))
    {
        return NULL;
    }

    // If the category doesn't exist already, create it.
    return labelManager->addLabel(lblclass, value, newName);
}

/*
 * Finds the label with the exact value 'lblval'
 * Passed:  (1) - The character class for the label
 *          (2) - The value for the address
 * Returns: The label def if it exists, NULL if not found
 *
 */
Label* findlbl(char lblclass, int lblval)
{
    if (strchr("^@$&", lblclass)) return NULL;

    return labelManager->getLabel(lblclass, lblval);
}

char* lblstr(char lblclass, int lblval)
{
    Label* label = labelManager->getLabel(lblclass, lblval);
    return label ? label->name() : "";
}

LabelManager::LabelManager(){};

LabelManager::~LabelManager()
{
    for (auto pair : _labelCategories)
    {
        delete pair.second;
        pair.second = nullptr;
    }
}

LabelCategory* LabelManager::getCategory(char code)
{
    auto pair = _labelCategories.find(code);
    if (pair == _labelCategories.end())
    {
        auto result = _labelCategories.insert(std::make_pair(code, new LabelCategory(code)));
        return result.first->second;
    }
    else
    {
        return pair->second;
    }
}

/* Prints out all labels organized by class. */
void LabelManager::printAll()
{
    for (auto it = _labelCategories.begin(); it != _labelCategories.end(); it++)
    {
        it->second->printAll();
    }
}

Label* LabelManager::addLabel(char code, long value, const char* name)
{
    return getCategory(code)->add(value, name);
}

Label* LabelManager::getLabel(char code, long value)
{
    return getCategory(code)->get(value);
}

LabelCategory::LabelCategory(char code) : code(code){};

LabelCategory::~LabelCategory()
{
    for (auto& label : _labels)
    {
        delete label;
        label = nullptr;
    }
}

Label* LabelCategory::add(long value, const char* newName)
{
    Label* label = _labelsByValue[value];
    if (label == nullptr)
    {
        /* Add the label */
        label = new Label(code, value, newName);
        if (label)
        {
            // Keep the list of labels sorted by value.
            iterator it;
            for (it = begin(); it != end() && (*it)->myAddr < value; it++)
                ;
            _labels.insert(it, label);

            _labelsByValue[value] = label;
        }
    }
    else if (newName && strlen(newName) > 0)
    {
        /* Rename the old label. */
        label->setName(newName);
    }

    return label;
}

Label* LabelCategory::get(long value)
{
    if (_labelsByValue.count(value) != 0)
    {
        return _labelsByValue[value];
    }
    else
    {
        return nullptr;
    }
}

void LabelCategory::printAll()
{
    if (!_labels.empty())
    {
        printf("\nLabel definitions for Class '%c'\n\n", code);
        for (auto label : _labels)
        {
            printf("%s equ $%d\n", label->name(), (int)(label->myAddr));
        }
    }
}

Label* LabelCategory::getNextAfter(Label* label)
{
    iterator it;
    for (it = begin(); *it != label; it++)
        ;
    if (it == end() || it + 1 == end())
    {
        return nullptr;
    }
    else
    {
        return *(it + 1);
    }
}

Label* LabelCategory::getFirst()
{
    if (_labels.empty())
    {
        return nullptr;
    }
    else
    {
        return _labels[0];
    }
}

/* Value is either the address of the label, or the value of the equate. */
Label::Label(char category, int value, const char* name)
    : myAddr(value), category(category), _stdName(false), _global(false), _name("")
{
    setName(name);
}

void Label::setName(const char* name)
{
    if (name && strlen(name) > 0)
    {
        if (strlen(name) > LBLLEN)
        {
            printf("Error: label name '%s' too long. Truncating to %d characters.", name, LBLLEN);
        }
        strncpy(_name, name, LBLLEN);
        _name[LBLLEN] = '\0';
    }
    else
    {
        /* Assume that a program label does not exceed 20 bits */
        if (myAddr > 0x3FFFF)
        {
            printf("Error: label value %x is more than 20 bits. Truncating name to %05x.", myAddr, myAddr);
        }

        snprintf(_name, LBLLEN + 1, "%c%05x", toupper(category), myAddr & 0x3FFFF);
    }
}

void PrintNumber(char* dest, int value, int amod, int PBytSiz, char clas)
{
    std::ostringstream stream;
    PrintNumber(stream, value, amod, PBytSiz, clas);
    auto result = stream.str();
    strcat(dest, result.c_str());
}

/*
 * Prints out the number to "dest", in the format needed.
 * Passed : (1) dest - The string buffer into which to print the label.
 *          (2) clas - The Class Letter for the label.
 *          (3)  adr - The label's address.
 */
void PrintNumber(std::ostream& dest, int value, int amod, int PBytSiz, char clas)
{
    dest << MakeFormattedNumber(value, amod, PBytSiz, clas);
}

/*
 * Calculate the Label for a location
 * Passed:  (1) dst - pointer to character string into which to APPEND result                                       *
 *          (2) adr -  the address of the label
 *          (3) amod - the AMode desired
 * This is NOT SAFE AT ALL.
 */
bool LblCalc(char* dst, int adr, int amod, int curloc, bool isRof, int Pass)
{

    int raw = adr /*& 0xffff */; /* Raw offset (postbyte) - was unsigned */
    char mainclass;              /* Class for this location */

    Label* mylabel = 0;

    if (amod == AM_REL)
    {
        raw += curloc;
    }

    if (isRof)
    {
        if (IsRef(dst, curloc, adr, Pass))
        {
            return true;
        }
    }

    std::ostringstream dest;

    /* if amod is non-zero, we're doing a label class */

    if (amod)
    {
        /*mainclass = DEFAULTCLASS;*/
        AMODE_BOUNDS_CHECK(amod);
        mainclass = defaultLabelClasses[amod - 1];
    }
    else /* amod=0, it's a boundary def  */
    {
        if (NowClass)
        {
            mainclass = NowClass;
        }
        else
        {
            return false;
        }
    }

    if (Pass == 1)
    {
        addlbl(mainclass, raw, NULL);
    }
    else
    { /*Pass2 */
        mylabel = findlbl(mainclass, raw);
        if (strchr("^$@&%", mainclass))
        {
            return false;
        }
        else if (mylabel)
        {
            dest << mylabel->name();
        }
        else
        {
            char t;

            t = (mainclass ? mainclass : 'D');
            fprintf(stderr, "Lookup error on Pass 2 (main)\n");
            fprintf(stderr, "Cannot find %c - %05x\n", t, raw);
            /*   fprintf (stderr, "Cmd line thus far: %s\n", tmpname);*/
            exit(1);
        }
    }
    std::string destStr = dest.str();
    strcat(dst, destStr.c_str());
    return true;
}