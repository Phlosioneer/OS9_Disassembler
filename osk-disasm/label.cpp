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
#include "exit.h"
#include "label.h"
#include "main_support.h"
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

/*
 * Handle label depending upon Pass.  If Pass 1, add
 *      it as needed, if Pass 2, place values into the struct cmd_items fields
 *
 */
void process_label(struct cmd_items* ci, char lblclass, int addr)
{
    if (Pass == 1)
    {
        labelManager->addLabel(lblclass, addr, NULL);
    }
    else /* Pass 2, find it */
    {
        Label* label = labelManager->getLabel(lblclass, addr);
        if (label)
        {
            strcpy(ci->params, label->name());
        }
        else
        {
            fprintf(stderr, "*** phasing error ***\n");
            sprintf(ci->params, "L%05x", addr);
        }
    }
}

/*
 * Append a char in the desired printable format onto dst
 */
static void singleCharData(std::ostream& dest, char ch)
{
    // char mytmp[10];

    if (isprint(ch & 0x7f) && ((ch & 0x7f) != ' '))
    {
        dest << '\'' << ch << '\'';
        // sprintf(mytmp, "'%c'", ch & 0x7f);
        // strcat(dst, mytmp);
    }
    else
    {
        Label* pp = labelManager->getLabel('^', ch);
        if (pp) /*if ((pp = FindLbl (ListRoot ('^'), ch & 0x7f)))*/
        {
            dest << pp->name();
            // strcat(dst, pp->name());
        }
        else
        {
            auto prevFill = dest.fill('0');
            auto prevWidth = dest.width(2);
            auto prevBase = dest.setf(std::ios_base::hex, std::ios_base::basefield);
            dest << (int)ch;
            dest.fill(prevFill);
            dest.width(prevWidth);
            dest.setf(prevBase, std::ios_base::basefield);

            // sprintf(mytmp, "$%02x", ch & 0x7f);
            // strcat(dst, mytmp);
        }
    }

    if (ch & 0x80)
    {
        dest << "+$80";
        // strcat(dst, "+$80");
    }
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

/*
 * Prints out the label to "dest", in the format needed.
 * Passed : (1) dest - The string buffer into which to print the label.
 *          (2) clas - The Class Letter for the label.
 *          (3)  adr - The label's address.
 *          (4)   dl - ptr to the nlist tree for the label
 */
static void PrintLbl(std::ostream& dest, char clas, int adr, Label* dl, int amod)
{
    auto prevFill = dest.fill();
    auto prevWidth = dest.width();
    auto prevBase = dest.flags() & std::ios_base::basefield;

    // char tmp[10];
    /*short decn = adr & 0xffff;*/
    int mask;

    /* Readjust class definition if necessary */
    if (clas == '@')
    {
        if (abs(adr) < 9)
        /*if ( (adr <= 9) ||
             ((PBytSiz == 1) && adr > 244) ||
             ((PBytSiz == 2) && adr > 65526) )*/
        {
            clas = '&';
        }
        else
        {
            clas = '$';
        }
    }

    switch (clas)
    {
        // char *hexfmt;

    case '$': /* Hexadecimal notation */
        dest << '$';
        switch (amod)
        {
        default:
            switch (PBytSiz)
            {
            case 1:
                adr &= 0xff;
                break;
            case 2:
                adr &= 0xffff;
                break;
            default:
                break;
            }

            if (abs(adr) <= 0xff)
            {
                dest.fill('0');
                dest.width(2);
                // hexfmt = "%02x";
            }
            else if (abs(adr) <= 0xffff)
            {
                dest.fill('0');
                dest.width(4);
                // hexfmt = "%04x";
            }
            else
            {
                // hexfmt = "%x";
            }

            break;
        case AM_LONG:
            dest.fill('0');
            dest.width(8);
            // hexfmt = "%08x";
            break;
        case AM_SHORT:
            dest.fill('0');
            dest.width(4);
            // hexfmt = "%04x";
            break;
        }

        dest << std::hex << adr;
        // sprintf (tmp, hexfmt, adr);
        // sprintf (dest, "$%s", tmp);
        break;
    case '&': /* Decimal */
        dest << adr;
        // sprintf (dest, "%d", adr);
        break;
    case '^': /* ASCII */
        //*dest = '\0';

        if (adr > 0xff)
        {
            singleCharData(dest, adr & 0xff);
            dest << "*256+";
            // movchr (dest, (adr >> 8) & 0xff);
            // strcat (dest, "*256+");
        }
        singleCharData(dest, adr & 0xff);

        break;
    case '%': /* Binary */
        // strcpy (dest, "%");
        dest << "%";

        if (adr > 0xffff)
        {
            mask = 0x80000000;
        }
        else if (adr > 0xff)
        {
            mask = 0x8000;
        }
        else
        {
            mask = 0x80;
        }

        while (mask)
        {
            // strcat (dest, (mask & adr ? "1" : "0"));
            dest << (mask & adr ? '1' : '0');
            mask >>= 1;
        }

        break;
    default:
        // strcpy (dest, dl->inner->name());
        dest << dl->name();
    }

    dest.fill(prevFill);
    dest.width(prevWidth);
    dest.setf(prevBase, std::ios_base::basefield);
}

/*
 * Calculate the Label for a location
 * Passed:  (1) dst - pointer to character string into which to APPEND result                                       *
 *          (2) adr -  the address of the label
 *          (3) amod - the AMode desired
 * This is NOT SAFE AT ALL.
 */
int LblCalc(char* dst, int adr, int amod, int curloc, int /*bool*/ isRof)
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
        if (IsRef(dst, curloc, adr))
        {
            return 1;
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
            return 0;
        }
    }

    /* Attempt to restrict class 'L' */
    /*if (mainclass == 'L')
    {
        raw &= 0x3ffff;
    }*/

    if (Pass == 1)
    {
        addlbl(mainclass, raw, NULL);
    }
    else
    { /*Pass2 */
        // char tmpname[20];

        mylabel = findlbl(mainclass, raw);
        if (mylabel)
        {
            PrintLbl(dest, mainclass, raw, mylabel, amod);
            // strcat (dst, tmpname);
        }
        else
        { /* Special case for these */
            if (strchr("^$@&%", mainclass))
            {
                PrintLbl(dest, mainclass, raw, mylabel, amod);
                // strcat (dst, tmpname);
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
    }
cleanup:
    std::string destStr = dest.str();
    strcat(dst, destStr.c_str());
    return 1;
}

/* For debugging. Prints out all labels organized by class. */
void parsetree(char c)
{
    if (Pass == 1) return;

    labelManager->printAll();
}