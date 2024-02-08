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

#include "address_space.h"
#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "main_support.h"
#include "params.h"
#include "rof.h"
#include "userdef.h"

LabelManager labelManager{};

LabelManager::LabelManager(){};

LabelCategory& LabelManager::getCategory(AddrSpaceHandle code)
{
    if (!code) throw std::runtime_error("Address space cannot be null");
    if (code->kind == SpaceKind::LITERAL) throw std::runtime_error("Cannot make a category for a literal space");

    auto pair = _labelCategories.find(code->name);
    if (pair == _labelCategories.end())
    {
        auto& newPair = _labelCategories.emplace(code->name, code);
        if (!newPair.second) throw std::runtime_error("Inserted category that already existed");
        return newPair.first->second;
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
        it->second.printAll();
    }
}

void LabelManager::clear()
{
    _labelCategories.clear();
}

std::shared_ptr<Label> LabelManager::addLabel(AddrSpaceHandle code, long value)
{
    if (!code || code->kind == SpaceKind::LITERAL) return nullptr;

    return getCategory(code).add(value);
}

std::shared_ptr<Label> LabelManager::addLabel(AddrSpaceHandle code, long value, std::string&& name)
{
    if (!code || code->kind == SpaceKind::LITERAL) return nullptr;

    return getCategory(code).add(value, std::move(name));
}

std::shared_ptr<Label> LabelManager::getLabel(AddrSpaceHandle code, long value)
{
    if (!code || code->kind == SpaceKind::LITERAL) return nullptr;

    return getCategory(code).get(value);
}

LabelCategory::LabelCategory(AddrSpaceHandle code) : code(code), _labels(), _labelRedirects(), _labelsByValue(){};

std::shared_ptr<Label> LabelCategory::add(long value)
{
    auto it = _labelsByValue.find(value);
    if (it == _labelsByValue.end())
    {
        /* Add the label */
        auto label = std::make_shared<Label>(code, value);

        // Keep the list of labels sorted by value.
        auto sorter = [](const std::shared_ptr<Label>& lab, long value) { return lab->value < value; };
        iterator it = std::lower_bound(_labels.begin(), _labels.end(), value, sorter);
        _labels.insert(it, label);
        _labelsByValue.insert({value, label});
        return label;
    }

    return it->second;
}

std::shared_ptr<Label> LabelCategory::add(long value, std::string&& newName)
{
    auto it = _labelsByValue.find(value);
    if (it == _labelsByValue.end())
    {
        /* Add the label */
        auto label = std::make_shared<Label>(code, value, std::move(newName));

        // Keep the list of labels sorted by value.
        auto sorter = [](const std::shared_ptr<Label>& lab, long value) { return lab->value < value; };
        iterator it = std::lower_bound(_labels.begin(), _labels.end(), value, sorter);
        _labels.insert(it, label);
        _labelsByValue.insert({value, label});
        return label;
    }
    else // if (it->second->nameIsDefault())
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
        return redirectIt->second;
    }
    auto byValueIt = _labelsByValue.find(value);
    if (byValueIt != _labelsByValue.end())
    {
        return byValueIt->second;
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
    _labelRedirects.insert({addr, label});
}

/* Value is either the address of the label, or the value of the equate. */
Label::Label(AddrSpaceHandle category, int value)
    : value(value), category(category), _stdName(false), _global(false), _nameIsDefault(true),
      _name(category->makeDefaultName(value))
{
}

Label::Label(AddrSpaceHandle category, int value, std::string&& name)
    : value(value), category(category), _stdName(false), _global(false), _nameIsDefault(false), _name(std::move(name))
{
    if (_name.empty())
    {
        throw std::runtime_error("Empty name should use nameless constructor");
    }
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

std::string PrintNumber(int value, int amod, int defaultHexSize, AddrSpaceHandle space)
{
    std::ostringstream stream;
    PrintNumber(stream, value, amod, defaultHexSize, space);
    return stream.str();
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
 * 
 * isRelativeRefImplied : For some instructions(branches) and some argument forms(pc displacements), the assembler
 * forces references to be relative.For correct disassembly, we need to undo that.
 */
bool LblCalc(std::string& out_name, uint32_t adr, int amod, uint32_t curloc, bool isRof, int Pass, OperandSize sizeConstraint)
{

    auto adjusted = adr;
    AddrSpaceHandle mainclass; /* Class for this location */

    if (amod == AM_REL)
    {
        adjusted += curloc;
    }

    if (isRof)
    {
        if (IsRef(out_name, curloc, adr, Pass, sizeConstraint, amod == AM_REL))
        {
            return true;
        }
    }

    /* if amod is non-zero, we're doing a label class */

    if (amod != AM_NO_LABELS)
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
        if (isRof)
        {
        }
        return false;
    }

    if (Pass == 1)
    {
        labelManager.addLabel(mainclass, adjusted);
    }
    else
    { /*Pass2 */
        std::ostringstream dest;
        auto mylabel = labelManager.getLabel(mainclass, adjusted);
        if (!mainclass || mainclass->kind == SpaceKind::LITERAL)
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
        out_name = dest.str();
    }
    //std::string destStr = dest.str();
    //strcat(dst, destStr.c_str());
    return true;
}