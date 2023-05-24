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

#include "pch.h"

#include "label.h"

#include <ctype.h>

#include "userdef.h"
#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "main_support.h"
#include "params.h"
#include "rof.h"

LabelManager labelManager{};

LabelManager::LabelManager(){};

std::shared_ptr<LabelCategory> LabelManager::getCategory(AddrSpaceHandle code)
{
    auto pair = _labelCategories.find(code->name);
    if (pair == _labelCategories.end())
    {
        auto newCategory = std::make_shared<LabelCategory>(code);
        _labelCategories.insert({code->name, newCategory});
        return newCategory;
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

void LabelManager::clear()
{
    _labelCategories.clear();
}

std::shared_ptr<Label> LabelManager::addLabel(AddrSpaceHandle code, long value, const char* name)
{
    auto category = getCategory(code);
    return category->add(value, name);
}

std::shared_ptr<Label> LabelManager::getLabel(AddrSpaceHandle code, long value)
{
    return getCategory(code)->get(value);
}

LabelCategory::LabelCategory(AddrSpaceHandle code) : code(code), _labels(), _labelRedirects(), _labelsByValue(){};


std::shared_ptr<Label> LabelCategory::add(long value, const char* newName)
{
    auto it = _labelsByValue.find(value);
    if (it == _labelsByValue.end())
    {
        /* Add the label */
        auto label = std::make_shared<Label>(code, value, newName);
        
        // Keep the list of labels sorted by value.
        iterator it;
        for (it = begin(); it != end() && (*it)->value < value; it++)
            ;
        _labels.insert(it, label);

        _labelsByValue[value] = label;
        return label;
    }
    else if (newName && strlen(newName) > 0)
    {
        /* Rename the old label. */
        it->second->setName(newName);
    }

    return it->second;
}

std::shared_ptr<Label> LabelCategory::get(long value)
{
    auto redirectIt = _labelRedirects.find(value);
    if (redirectIt != _labelRedirects.end())
    {
        return _labelRedirects[value];
    }
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
        printf("\nLabel definitions for Class '%s'\n\n", code->name.c_str());
        for (auto label : _labels)
        {
            printf("%s equ $%d\n", label->name().c_str(), (int)(label->value));
        }
    }
}

std::shared_ptr<Label> LabelCategory::getFirst()
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

void LabelCategory::addRedirect(long addr, std::shared_ptr<Label> label)
{
    _labelRedirects[addr] = label;
}

/* Value is either the address of the label, or the value of the equate. */
Label::Label(AddrSpaceHandle category, int value, const char* name)
    : value(value), category(category), _stdName(false), _global(false),
      _nameIsDefault(name == nullptr || strlen(name) == 0),
      _name(name == nullptr || strlen(name) == 0 ? category->makeDefaultName(value) : std::string(name))
{
}
Label::Label(AddrSpaceHandle category, int value, const std::string& name)
    : value(value), category(category), _stdName(false), _global(false), _nameIsDefault(name.empty()),
      _name(name.empty() ? category->makeDefaultName(value) : name)
{
}

void Label::setName(const char* name)
{
    if (name == nullptr || strlen(name) == 0)
    {
        if (_nameIsDefault) return;
        _nameIsDefault = true;
        _name = category->makeDefaultName(value);
    }
    else
    {
        _nameIsDefault = false;
        _name = name;
    }
}

void Label::setName(std::string newName)
{
    if (newName.empty())
    {
        if (_nameIsDefault) return;
        _nameIsDefault = true;
        _name = category->makeDefaultName(value);
    }
    else
    {
        _nameIsDefault = false;
        _name = std::move(newName);
    }
}

std::string Label::nameWithColon() const
{
    return _global ? _name + ':' : _name;
}

void PrintNumber(char* dest, int value, int amod, int defaultHexSize, AddrSpaceHandle space)
{
    std::ostringstream stream;
    PrintNumber(stream, value, amod, defaultHexSize, space);
    auto result = stream.str();
    strcat(dest, result.c_str());
}

/*
 * Prints out the number to "dest", in the format needed.
 * Passed : (1) dest - The string buffer into which to print the label.
 *          (2) clas - The Class Letter for the label.
 *          (3)  adr - The label's address.
 */
void PrintNumber(std::ostream& dest, int value, int amod, int defaultHexSize, AddrSpaceHandle space)
{
    dest << MakeFormattedNumber(value, amod, defaultHexSize, space);
}

/*
 * Calculate the Label for a location
 * Passed:  (1) dst - pointer to character string into which to APPEND result                                       *
 *          (2) adr -  the address of the label
 *          (3) amod - the AMode desired
 * This is NOT SAFE AT ALL.
 */
bool LblCalc(char* dst, uint32_t adr, int amod, uint32_t curloc, bool isRof, int Pass)
{

    auto adjusted = adr;
    AddrSpaceHandle mainclass;   /* Class for this location */

    if (amod == AM_REL)
    {
        adjusted += curloc;
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
        // AMODE_BOUNDS_CHECK(amod);
        // mainclass = defaultLabelClasses[amod - 1];
        if (amod == AM_A6)
        {
            mainclass = &UNKNOWN_DATA_SPACE;
        }
        else if (amod <= AM_A7 || amod == AM_IMM)
        {
            mainclass = &LITERAL_DEC_SPACE;
        }
        else
        {
            mainclass = &CODE_SPACE;
        }
    }
    else /* amod=0, it's a boundary def  */
    {
        return false;
    }

    if (Pass == 1)
    {
        labelManager.addLabel(mainclass, adjusted, NULL);
    }
    else
    { /*Pass2 */
        auto mylabel = labelManager.getLabel(mainclass, adjusted);
        if (!mainclass || *mainclass == LITERAL_SPACE || *mainclass == LITERAL_HEX_SPACE ||
            *mainclass == LITERAL_DEC_SPACE || *mainclass == LITERAL_ASCII_SPACE)
        {
            return false;
        }
        else if (mylabel)
        {
            dest << mylabel->name();
        }
        else
        {
            auto t = (mainclass ? mainclass : &INIT_DATA_SPACE);
            fprintf(stderr, "Lookup error on Pass 2 (main)\n");
            fprintf(stderr, "Cannot find %s - %05x\n", t->name.c_str(), adjusted);
            /*   fprintf (stderr, "Cmd line thus far: %s\n", tmpname);*/
            throw std::runtime_error("");
        }
    }
    std::string destStr = dest.str();
    strcat(dst, destStr.c_str());
    return true;
}