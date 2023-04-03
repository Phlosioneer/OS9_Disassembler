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
#include <string>

#include "disglobs.h"
#include <string.h>
#include <ctype.h>
#include "userdef.h"

#include "commonsubs.h"
#include "dis68.h"
#include "label.h"
#include "command_items.h"

LabelManager labelManager;

extern "C" struct data_bounds* LAdds[];
extern "C" struct data_bounds* dbounds;



extern "C" {
    const char* label_getName(struct symbol_def* handle) {
        return handle->inner->name();
    }

    void label_setName(struct symbol_def* handle, const char* name) {
        handle->inner->setName(name);
    }

    long label_getMyAddr(struct symbol_def* handle) {
        return handle->inner->myAddr;
    }

    int label_getStdName(struct symbol_def* handle) {
        return handle->inner->stdName();
    }

    void label_setStdName(struct symbol_def* handle, int isStdName) {
        handle->inner->setStdName((bool)isStdName);
    }

    int label_getGlobal(struct symbol_def* handle) {
        return handle->inner->global();
    }

    void label_setGlobal(struct symbol_def* handle, int isGlobal) {
        handle->inner->setGlobal((bool)isGlobal);
    }

    struct symbol_def* label_getNext(struct symbol_def* handle) {
        Label* label = labelManager.getCategory(handle->inner->category)->getNextAfter(handle->inner);
        return label ? label->handle() : nullptr;
    }

    struct symbol_def* labelclass_getFirst(struct label_class* handle) {
        Label* label = handle->inner->getFirst();
        return label ? label->handle() : nullptr;
    }

    struct label_class* labelclass(char lblclass) {
        return labelManager.getCategory(lblclass)->handle();
    }

    struct symbol_def* lblpos(char lblclass, int lblval)
    {
        Label* label = labelManager.getCategory(lblclass)->get(lblval);
        return label ? label->handle() : nullptr;
    }

    /* ************************
     * addlbl() - Add a label to the list
     *        Does nothing for class '^', '@', '$', or '&'
     *        if the label exists, and a different name is provided, renames the label
     * Passed : (1) char label class
     *          (2) int the address for the label
     *          (3) char * - the name for the label
     *              If NULL or empty string, the hex address of the label prepended with
     *              the class letter is used.
     */
    struct symbol_def* addlbl(char lblclass, int value, char* newName)
    {
        if (strchr("^@$&", lblclass))
        {
            return NULL;
        }

        // If the category doesn't exist already, create it.
        Label* label = labelManager.addLabel(lblclass, value, newName);
        return label ? label->handle() : nullptr;
    }

    /*
     * findlbl() - Finds the label with the exact value 'lblval'
     * Passed:  (1) - The character class for the label
     *          (2) - The value for the address
     * Returns: The label def if it exists, NULL if not found
     *
     */

    struct symbol_def* findlbl(char lblclass, int lblval)
    {
        if (strchr("^@$&", lblclass))
            return NULL;

        Label* label = labelManager.getLabel(lblclass, lblval);
        return label ? label->handle() : nullptr;
    }

    

    char* lblstr(char lblclass, int lblval)
    {
        Label* label = labelManager.getLabel(lblclass, lblval);
        return label ? label->name() : "";
    }


    /*
     * process_label: Handle label depending upon Pass.  If Pass 1, add
     *      it as needed, if Pass 2, place values into the struct cmd_items fields
     *
     */
    void process_label(struct cmd_items * ci, char lblclass, int addr)
    {
        if (Pass == 1)
        {
            labelManager.addLabel(lblclass, addr, NULL);
        }
        else   /* Pass 2, find it */
        {
            Label* label = labelManager.getLabel(lblclass, addr);
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

    /* ******************************************************************** *
     * movchr() - Append a char in the desired printable format onto dst    *
     * ******************************************************************** */

    void movchr(char* dst, unsigned char ch)
    {
        char mytmp[10];

        if (isprint(ch & 0x7f) && ((ch & 0x7f) != ' '))
        {
            sprintf(mytmp, "'%c'", ch & 0x7f);
            strcat(dst, mytmp);
        }
        else
        {
            Label* pp = labelManager.getLabel('^', ch);
            if (pp)
                /*if ((pp = FindLbl (ListRoot ('^'), ch & 0x7f)))*/
            {
                strcat(dst, pp->name());
            }
            else
            {
                sprintf(mytmp, "$%02x", ch & 0x7f);
                strcat(dst, mytmp);
            }
        }

        if (ch & 0x80)
        {
            strcat(dst, "+$80");
        }
    }
}

LabelManager::LabelManager() {};

LabelManager::~LabelManager()
{
    for (auto pair : _labelCategories) {
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
void LabelManager::printAll() {
    for (auto it = _labelCategories.begin(); it != _labelCategories.end(); it++) {
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

LabelCategory::LabelCategory(char code) : code(code), _handle(new label_class{ this }) {};

LabelCategory::~LabelCategory() {
    for (auto &label : _labels) {
        delete label;
        label = nullptr;
    }
    delete _handle;
    _handle = nullptr;
}

Label* LabelCategory::add(long value, const char* newName)
{
    Label* label = _labelsByValue[value];
    if (label == nullptr) {
        /* Add the label */
        label = new Label(code, value, newName);
        if (label)
        {
            // Keep the list of labels sorted by value.
            iterator it;
            for (it = begin(); it != end() && (*it)->myAddr < value; it++);
            _labels.insert(it, label);

            _labelsByValue[value] = label;
        }
    }
    else
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
        for (auto label : _labels) {
            printf("%s equ $%d\n", label->name(), (int)(label->myAddr));
        }
    }
}

Label* LabelCategory::getNextAfter(Label* label)
{
    iterator it;
    for (it = begin(); *it != label; it++);
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
Label::Label(char category, int value, const char* name) : 
    myAddr(value), category(category), _handle(new symbol_def{ this })
{
    setName(name);
}

Label::~Label()
{
    delete _handle;
    _handle = nullptr;
}

void Label::setName(const char* name) {
    if (name && strlen(name) > 0)
    {
        if (strlen(name) > LBLLEN) {
            printf("Error: label name '%s' too long. Truncating to %d characters.", name, LBLLEN);
        }
        strncpy(_name, name, LBLLEN);
        _name[LBLLEN] = '\0';
    }
    else
    {
        /* Assume that a program label does not exceed 20 bits */
        if (myAddr > 0x3FFFF) {
            printf("Error: label value %x is more than 20 bits. Truncating name to %05x.", myAddr, myAddr);
        }

        snprintf(_name, LBLLEN + 1, "%c%05x", toupper(category), myAddr & 0x3FFFF);
    }
}

/*
 * PrintLbl () - Prints out the label to "dest", in the format needed.
 * Passed : (1) dest - The string buffer into which to print the label.
 *          (2) clas - The Class Letter for the label.
 *          (3)  adr - The label's address.
 *          (4)   dl - ptr to the nlist tree for the label
 */

extern "C" void PrintLbl(char* dest, char clas, int adr, struct symbol_def* dl, int amod)
{
    char tmp[10];
    /*short decn = adr & 0xffff;*/
    register int mask;

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
        char *hexfmt;

        case '$':       /* Hexadecimal notation */
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
                        hexfmt = "%02x";
                    }
                    else if (abs(adr) <= 0xffff)
                    {
                        hexfmt = "%04x";
                    }
                    else
                    {
                        hexfmt = "%x";
                    }

                    break;
                case AM_LONG:
                    hexfmt = "%08x";
                    break;
                case AM_SHORT:
                    hexfmt = "%04x";
                    break;
            }

            sprintf (tmp, hexfmt, adr);
            sprintf (dest, "$%s", tmp);
            break;
        case '&':       /* Decimal */
            sprintf (dest, "%d", adr);
            break;
        case '^':       /* ASCII */
            *dest = '\0';

            if (adr > 0xff)
            {
                movchr (dest, (adr >> 8) & 0xff);
                strcat (dest, "*256+");
            }

            movchr (dest, adr & 0xff);

            break;
        case '%':       /* Binary */
            strcpy (dest, "%");

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
                strcat (dest, (mask & adr ? "1" : "0"));
                mask >>= 1;
            }

            break;
        default:
            strcpy (dest, dl->inner->name());
    }
}

/* **************************************************************** *
 * ClasHere()	See if a Data boundary for this address is defined  *
 * Passed : (1) Pointer to Boundary Class list                      *
 *          (2) Address to check for                                *
 * Returns: Ptr to Boundary definition if found,  NULL if no match. *
 * **************************************************************** */

extern "C" struct data_bounds* ClasHere(struct data_bounds* bp, int adrs)
{
    register struct data_bounds *pt;
    register int h = (int) adrs;

    pt = bp;
    if ( ! pt)
    {
        return 0;
    }

    while (1)
    {
        if (h < pt->b_lo)
        {
            if (pt->DLess)
                pt = pt->DLess;
            else
                return 0;
        }
        else
        {
            if (h > pt->b_hi)
            {
                if (pt->DMore)
                {
                    pt = pt->DMore;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return pt;
            }
        }
    }
}

/*
 * LblCalc() - Calculate the Label for a location
 * Passed:  (1) dst - pointer to character string into which to APPEND result                                       *
 *          (2) adr -  the address of the label
 *          (3) amod - the AMode desired
 */

extern "C" int LblCalc(char* dst, int adr, int amod, int curloc)
{
    int raw = adr /*& 0xffff */ ;   /* Raw offset (postbyte) - was unsigned */
    char mainclass;                 /* Class for this location */

    struct data_bounds *kls = 0;
    struct symbol_def *mylabel = 0;

    if (amod == AM_REL)
    {
        raw += curloc;
    }

    if (IsROF)
    {
        if (IsRef(dst, curloc, adr))
        {
            return 1;
        }
    }

    /* if amod is non-zero, we're doing a label class */

    if (amod)
    {
        kls = ClasHere(LAdds[amod], CmdEnt);
        if (kls)
        {
            mainclass = kls->b_typ;

            if (kls->dofst)     /* Offset ? */
            {
                if (kls->dofst->add_to)
                {
                    raw -= kls->dofst->of_maj;
                }
                else
                {
                    raw += kls->dofst->of_maj;
                }

                /* Let's attempt to insert the label for PC-Rel offets here */

                if (kls->dofst->incl_pc)
                {
                    raw += CmdEnt;
                    addlbl (kls->dofst->oclas_maj, raw, NULL);
                }
            }
        }
        else
        {
            /*mainclass = DEFAULTCLASS;*/
            mainclass = DfltLbls[amod - 1];
        }
    }
    else              /* amod=0, it's a boundary def  */
    {
        if (NowClass)
        {
            kls = ClasHere (dbounds, CmdEnt);
            mainclass = NowClass;

            if (kls->dofst)
            {
                if (kls->dofst->add_to)
                {
                    raw -= kls->dofst->of_maj;
                }
                else
                {
                    raw += kls->dofst->of_maj;
                }

                if (kls->dofst->incl_pc)
                {
                    raw += CmdEnt;
                }
            }
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
        addlbl (mainclass, raw, NULL);
    }
    else
    {                           /*Pass2 */
        char tmpname[20];

        mylabel = findlbl(mainclass, raw);
        if (mylabel)
        {
            PrintLbl (tmpname, mainclass, raw, mylabel, amod);
            strcat (dst, tmpname);
        }
        else
        {                       /* Special case for these */
            if (strchr ("^$@&%", mainclass))
            {
                PrintLbl (tmpname, mainclass, raw, mylabel, amod);
                strcat (dst, tmpname);
            }
            else
            {
                char t;

                t = (mainclass ? mainclass : 'D');
                fprintf (stderr, "Lookup error on Pass 2 (main)\n");
                fprintf (stderr, "Cannot find %c - %05x\n", t, raw);
             /*   fprintf (stderr, "Cmd line thus far: %s\n", tmpname);*/
                exit (1);
            }
        }

        /* Now process offset, if any */

        if (kls && kls->dofst)
        {
            char c = kls->dofst->oclas_maj;

            if (kls->dofst->add_to)
            {
                strcat (dst, "+");
            }
            else
            {
                strcat (dst, "-");
            }

            if (kls->dofst->incl_pc)
            {
                strcat (dst, "*");

                if (kls->dofst->of_maj)
                {
                    strcat (dst, "-");
                }
                else
                {
                    return 1;
                }
            }
            mylabel = findlbl(c, kls->dofst->of_maj);
            if (mylabel)
            /*if ((mylabel = FindLbl (LblList[strpos (lblorder, c)],
                                    kls->dofst->of_maj)))*/
            {
                PrintLbl (tmpname, c, kls->dofst->of_maj, mylabel, amod);
                strcat (dst, tmpname);
            }
            else
            {                   /* Special case for these */
                if (strchr ("^$@&", c))
                {
                    PrintLbl (tmpname, c, kls->dofst->of_maj, mylabel, amod);
                    strcat (dst, tmpname);
                }
                else
                {
                    char t;

                    t = (c ? c : 'D');
                    fprintf (stderr, "Lookup error on Pass 2 (offset)\n");
                    fprintf (stderr, "Cannot find %c%x\n", t,
                             kls->dofst->of_maj);
                    /*fprintf (stderr, "Cmd line thus far: %s\n", tmpname);*/
                    exit (1);
                }
            }

        }
    }

    return 1;
}

/* For debugging. Prints out all labels organized by class. */
extern "C" void parsetree(char c)
{
    if (Pass == 1)
        return;

    labelManager.printAll();
}