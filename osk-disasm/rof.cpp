
/* ******************************************************************** *
 * rof.c - handles rof files                                            *
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

#include "rof.h"
#include "disglobs.h"
#include "userdef.h"
#include <ctype.h>
#include <stdio.h>
#include <string.h>

#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "label.h"
#include "main_support.h"
#include "writer.h"

struct rof_extrn *refs_data, *refs_idata, *refs_code, *refs_remote, *refs_iremote,
    *extrns, /* Generic external pointer */
    *codeRefs_sav;

static void get_refs(std::string& vname, int count, int ref_typ, char* codebuffer, BigEndianStream* Module);

const char* extern_def_name(struct rof_extrn* handle)
{
    if (!handle->hasName)
    {
        errexit("Cannot access name of label; not implemented yet");
    }
    return handle->nam.c_str();
}

char* rof_header_getPsectParams(struct rof_header* handle)
{
    char* ret = new char[100];
    if (!ret) errexit("OoM");
    snprintf(ret, 99, "%s,$%x,$%x,%d,%d,", handle->rname.c_str(), handle->ty_lan >> 8, handle->ty_lan & 0xff,
             handle->edition, handle->stksz);
    ret[99] = '\0';
    return ret;
}

/*
 * Returns the correct file position.  Returns CmdEnt. For Non-ROF files, CmdEnt
 * Offset by Code Entry Point.
 */
int RealEnt(struct options* opt, int CmdEnt)
{
    return opt->IsROF ? (CmdEnt + HdrEnd) : CmdEnt;
}

/*
 * Add the initialization data to the Labels Ref. On entry, the file pointer is
 * positioned to the begin of the initialized data list for this particular vsect.
 */
void AddInitLbls(struct rof_extrn* tbl, char klas, BigEndianStream& Module)
{
    uint32_t refVal;

    while (tbl)
    {
        if (!tbl->Extrn)
        {
            Module.seekAbsolute(tbl->Ofst);

            switch (REFSIZ(tbl->Type))
            {
            case 1: /*SIZ_BYTE:*/
                refVal = Module.read<uint8_t>();
                break;
            case 2: /*SIZ_WORD:*/
                refVal = Module.read<uint16_t>();
                break;
            default:
                refVal = Module.read<uint32_t>();
            }
            tbl->hasName = FALSE;
            tbl->lbl = addlbl(tbl->dstClass, refVal, "");
        }

        tbl = tbl->ENext;
    }
}

/*
 * Read and interpret rof header
 */
void getRofHdr(struct options* opt)
{
    uint16_t glbl_cnt, count; /* Generic counter */
    char* codeBuf;

    opt->IsROF = true;    /* Flag that module is an ROF module */
    opt->Module->reset(); /* Start all over */

    /* get header data */
    opt->ROFHd = std::make_unique<rof_header>();

    opt->ROFHd->sync = opt->Module->read<uint32_t>();

    if (opt->ROFHd->sync != 0xdeadface)
    {
        errexit("Illegal ROF Module sync bytes");
    }

    opt->ROFHd->ty_lan = opt->Module->read<uint16_t>();
    opt->ROFHd->att_rev = opt->Module->read<uint16_t>(); /* Attribute/Revision word */
    opt->ROFHd->valid = opt->Module->read<uint16_t>();   /* Nonzero if valid */
    opt->ROFHd->series = opt->Module->read<uint16_t>();  /* Assembler version used to compile */
    opt->Module->readVec(opt->ROFHd->rdate, 6);
    opt->ROFHd->edition = opt->Module->read<uint16_t>();

    opt->ROFHd->statstorage = opt->Module->read<uint32_t>();   /* Size of static variable storage */
    opt->ROFHd->idatsz = opt->Module->read<uint32_t>();        /* Size of initialized data */
    opt->ROFHd->codsz = opt->Module->read<uint32_t>();         /* Size of the object code  */
    opt->ROFHd->stksz = opt->Module->read<uint32_t>();         /* Size of stack required   */
    opt->ROFHd->code_begin = opt->Module->read<uint32_t>();    /* Offset to entry point of object code   */
    opt->ROFHd->utrap = opt->Module->read<uint32_t>();         /* Offset to unitialized trap entry point */
    opt->ROFHd->remotestatsiz = opt->Module->read<uint32_t>(); /* Size of remote static storage */
    opt->ROFHd->remoteidatsiz = opt->Module->read<uint32_t>(); /* Size of remote initialized data */
    opt->ROFHd->debugsiz = opt->Module->read<uint32_t>();      /* Size of the debug   */

    opt->ROFHd->rname = opt->Module->read<std::string>();

    /* Set ModData to an unreasonable high number so ListData
     * won't do it's thing...
     */

    // modHeader->memorySize = 0x10000;
    /*ModData = 0x7fff;*/

    /* ************************************************ *
     * Get the Global definitions                       *
     * ************************************************ */
    count = glbl_cnt = opt->Module->read<uint16_t>();

    while (count--)
    {
        std::string name;
        uint16_t typ;
        uint32_t adrs;

        name = opt->Module->read<std::string>();
        typ = opt->Module->read<uint16_t>();
        adrs = opt->Module->read<uint32_t>();

        Label* me = addlbl(rof_class(typ, REFGLBL), adrs, name.c_str());
        if (me)
        {
            me->setGlobal(true);
        }
    }

    /* Code section... read, or save file position   */
    HdrEnd = opt->Module->position();
    opt->ROFHd->CodeEnd = opt->ROFHd->codsz;

    /* Read code into buffer for get_refs() while we're here */

    codeBuf = new char[(size_t)opt->ROFHd->codsz + 1];
    opt->Module->readRaw(codeBuf, opt->ROFHd->codsz);

    /* ********************************** *
     *    Initialized data Section        *
     * ********************************** */

    IDataCount = opt->ROFHd->idatsz;
    IDataBegin = opt->Module->position();

    /* ********************************** *
     *    External References Section     *
     * ********************************** */

    opt->Module->seekAbsolute((size_t)IDataBegin + opt->ROFHd->idatsz + opt->ROFHd->remoteidatsiz +
                              opt->ROFHd->debugsiz);

    for (auto ext_count = opt->Module->read<uint16_t>(); ext_count > 0; ext_count--)
    {
        std::string _name;
        uint16_t refcount;

        _name = opt->Module->read<std::string>();
        refcount = opt->Module->read<uint16_t>();

        /* Get the individual occurrences for this name */

        get_refs(_name, refcount, REFXTRN, NULL, opt->Module.get());
    }

    /* *************************** *
     *    Local variables...       *
     * *************************** */

    auto local_count = opt->Module->read<uint16_t>();
    get_refs(std::string(), local_count, REFLOCAL, codeBuf, opt->Module.get());
    delete[] codeBuf;

    /* Now we need to add labels for these refs */

    /* common block variables... */
    /* Do this after everything else is done */
    /* NOTE: We may need to save current ftell() to restore it after this */

    opt->Module->seekAbsolute(IDataBegin);

    AddInitLbls(refs_idata, '_', opt->Module->fork(opt->ROFHd->idatsz));
    AddInitLbls(refs_iremote, 'H', opt->Module->fork(opt->ROFHd->remoteidatsiz));

    /* Now we're ready to disassemble the code */

    /* Position to begin of Code section */
    opt->Module->seekAbsolute(HdrEnd);
}

void RofLoadInitData(void)
{
    /* ********************************** *
     * Initialized data section           *
     * ********************************** */

    /* ********************************** *
     *   Initialized remote data Section  *
     * ********************************** */

    /* ********************************** *
     *     Debug Information Section      *
     * ********************************** */
}

/*
 * Returns the Destination reference for the reference.
 * Passed: The Type byte from the reference.
 * Returns: The Class Letter for the entry.
 */
char rof_class(int typ, int refTy)
{
    /* We'll tie up additional classes for data/bss as follows
     * D for data
     * _ for init data
     * G for remote
     * H for remote init
     *
     */

    switch (refTy)
    {
    case REFGLBL:
        switch (typ & 0x100)
        {
        case 0:                 /* NOT common */
            switch (typ & 0x04) /* Docs are backward? */
            {
            case 0:                 /* Data */
                switch (typ & 0x01) /* Docs are backward ? */
                {
                case 0: /* Uninit */
                    switch (typ & 0x02)
                    {
                    case 0:
                        return 'D';
                    default:
                        return 'G';
                    }
                default: /* Init */
                    switch (typ & 0x02)
                    {
                    case 0:
                        return '_';
                    default:
                        return 'H';
                    }
                }
            default: /* Code or Equ */
                switch (typ & 0x02)
                {
                case 0: /* NOT remote */
                    return 'L';
                default:
                    return 'L'; /* FIXME: This is actually 'equ' */
                }
            }
        default: /* common */
            switch (typ & 0x20)
            {
            case 0: /* NOT Remote */
                /* These are WRONG! but for now, we'll use them */
                return '_';
            default:
                return 'D';
            }
        }

        break;

    case REFXTRN:
    case REFLOCAL:
        switch (typ & 0x20)
        {
        case 0: /* NOT remote */
            switch (typ & 0x200)
            {
            case 0: /* data */
                return '_';
            default: /* remote */
                return 'L';
            }
        default:
            switch (typ & 0x200)
            {
            case 0: /* code */
                return 'L';
            default: /* debug */
                break;
            }
            return 'L';
        }
    }

    return 'L'; /* Should never get to here, but for safety's sake */
}

/*
 * Get entries for given reference, either external or local.
 * Passed:  name (or blank for locals)
 *          count - number of entries to process
 *          1 if external, 0 if local
 */
static void get_refs(std::string& vname, int count, int ref_typ, char* code_buf, BigEndianStream* Module)
{
    struct rof_extrn* prevRef = NULL;
    char myClass;
    uint16_t _ty;
    uint32_t _ofst;
    struct rof_extrn *new_ref, *curRef, **base = 0;

    for (; count > 0; count--)
    {
        _ty = Module->read<uint16_t>();   // fread_w(ModFP);
        _ofst = Module->read<uint32_t>(); // fread_l(ModFP);

        /* Skip Debug refs */
        if (ref_typ == REFLOCAL)
        {
            if ((_ty & 0x220) == 0x220)
            {
                continue;
            }
        }

        /* Add to externs table */
        switch (myClass = rof_class(_ty, ref_typ))
        {
        case 'L':
            base = &refs_code;
            break;
        case 'D':
            base = &refs_data;
            break;
        case '_':
            base = &refs_idata;
            break;
        case 'G':
            base = &refs_remote;
            break;
        case 'H':
            base = &refs_iremote;
            break;
        default:
            myClass = 'L'; /* Possibly cause erroneous result, but to avoid crash */
            base = &refs_code;
        }

        /*if ((ref_typ == REFLOCAL) && (myClass == 'L'))
        {
        }
        else*/
        {
            new_ref = new rof_extrn();

            new_ref->Type = _ty;
            new_ref->Ofst = _ofst;
            new_ref->Extrn = (ref_typ == REFXTRN);

            if (prevRef)
            {
                prevRef->MyNext = new_ref;
            }

            /*base = &refs_data;*/ /* For the time being, let's try to just use one list for all refs */

            /* If this tree has not yet been initialized, simply set the
             * base pointer to this entry (as the first)
             */

            if (!*base)
            {
                *base = new_ref;
            }

            /* If we get here, this particular tree has alreay been started,
             * so find where to put the new entry.  Note, for starters, let's
             * assume that each entry will be unique, that is, this location
             * won't be here
             */

            else /* We have entries, insert it into the proper place */
            {
                curRef = *base;
                /*extrns = *base;*/ /* Use the global externs pointer */

                if (_ofst < curRef->Ofst)
                {
                    new_ref->ENext = curRef;
                    curRef->EUp = new_ref;
                    *base = new_ref;
                }
                else
                {
                    while ((curRef->ENext) && (_ofst > curRef->ENext->Ofst))
                    {
                        curRef = curRef->ENext;
                    }

                    /*if (curRef->Ofst > _ofst)
                    {
                        curRef = curRef->EUp;
                    }*/

                    if (curRef->ENext)
                    {
                        curRef->ENext->EUp = new_ref;
                    }

                    new_ref->ENext = curRef->ENext;
                    new_ref->EUp = curRef;
                    curRef->ENext = new_ref;
                }

            } /* *base != NULL */

            prevRef = new_ref;

            if (new_ref->Extrn)
            {
                new_ref->hasName = TRUE;
                new_ref->nam = vname;
                new_ref->hasName = TRUE;
            }
            else
            {
                register int dstVal;
                char* pt = &(code_buf[new_ref->Ofst]);

                new_ref->dstClass = rof_class(_ty, REFGLBL);

                if ((ref_typ == REFLOCAL) && (myClass == 'L'))
                {
                    switch ((new_ref->Type >> 3) & 3)
                    {
                    case 1:
                        dstVal = *pt & 0xff;
                        break;
                    case 2:
                        dstVal = bufReadW(&pt);
                        break;
                    default:
                        dstVal = bufReadL(&pt);
                    }
                    new_ref->hasName = FALSE;
                    new_ref->lbl = addlbl(new_ref->dstClass, dstVal, "");
                }
            }
        } /* end "if (ref_typ == REFXTRN)" */
    }     /* end "while (count--) */
}

/*
 * Find an external reference.
 * Passed : (1) xtrn - starting extrn ref
 *          (2) adrs - Address to match
 * Pure function.
 */
struct rof_extrn* find_extrn(struct rof_extrn* xtrn, unsigned int adrs)
{
    /*int found = 0;*/

    if (!xtrn)
    {
        return 0;
    }

    while (((adrs > xtrn->Ofst) || !(xtrn->Extrn)) && (xtrn->ENext))
    {
        xtrn = xtrn->ENext;
    }

    return (xtrn->Ofst == adrs ? xtrn : NULL);
}

/*
 * Returns the end of rof data area
 * Passed: Label Class letter to search
 * Returns: size of this data area. If not a data area, returns 0.
 * Unused, but useful as documentation
 */
int rof_datasize(char cclass, struct options* opt)
{
    int dsize;

    switch (cclass)
    {
    case 'D':
        dsize = opt->ROFHd->statstorage;
        break;
    case 'H':
        dsize = opt->ROFHd->remoteidatsiz;
        break;
    case 'G':
        dsize = opt->ROFHd->remotestatsiz;
        break;
    case '_':
        dsize = opt->ROFHd->idatsz;
        break;
    default:
        dsize = 0;
    }

    return dsize;
}

/*
 * Process a block composed of an initialized reference from a data area.
 * Passed : (1) struct rof_extrn *mylist - pointer to tree element
 *          (2) int datasize - the size of the area to process
 *          (3) char class - the label class (D or C)
 */
static char* DataDoBlock(struct rof_extrn** refsList, Label** lblList, char* iBuf, unsigned int blkEnd, char cclass,
                         struct parse_state* state)
{
    /*struct rof_extrn *srch;*/
    struct cmd_items Ci;
    char lblString[200];

    /* Insert Label if applicable */

    if ((*lblList)->myAddr == state->CmdEnt)
    {
        strcpy(lblString, (*lblList)->name());
        Ci.lblname = lblString;

        if ((*lblList)->global())
        {
            strcat(Ci.lblname, ":");
        }

        (*lblList) = label_getNext(*lblList);
    }

    while (state->PCPos < blkEnd)
    {
        /*int bump = 2,
            my_val;*/

        state->CmdEnt = state->PCPos;
        /* First check that refsList is not null. If this vsect has no
         * references, 'refsList' will be null
         */

        if (*refsList && ((*refsList)->Ofst == state->CmdEnt))
        {
            strcpy(Ci.mnem, "dc.");

            switch (((*refsList)->Type >> 3) & 3)
            {
            case 1: /* SIZ_BYTE */
                strcat(Ci.mnem, "b");
                state->PCPos++;
                break;
            case 2: /* SIZ_WORD */
                strcat(Ci.mnem, "w");
                state->PCPos += 2;
                break;
            default: /* SIZ_LONG */
                strcat(Ci.mnem, "l");
                state->PCPos += 4;
            }

            if ((*refsList)->Extrn)
            {
                strcpy(Ci.params, (*refsList)->nam.c_str());
            }
            else
            {
                strcpy(Ci.params, (*refsList)->lbl->name());
            }

            PrintLine(pseudcmd, &Ci, cclass, state->CmdEnt, state->opt);
            state->CmdEnt = state->PCPos;
            Ci.lblname = NULL;
            Ci.params[0] = '\0';
            Ci.mnem[0] = '\0';
        }
        else /* No reference entry for this area */
        {
            int bytCount = 0;
            int bytSize;
            bytCount = DoAsciiBlock(&Ci, iBuf, blkEnd, cclass, state);
            if (bytCount)
            {
                iBuf += bytCount;
                continue;
            }
            else
            {
                register char* fmt;

                switch ((blkEnd - state->PCPos) % 4)
                {
                case 0:
                    bytSize = 4;
                    bytCount = (blkEnd - state->PCPos) >> 2;
                    strcpy(Ci.mnem, "dc.l");
                    fmt = "$%08x";
                    break;
                case 2:
                    bytSize = 2;
                    strcpy(Ci.mnem, "dc.w");
                    bytCount = (blkEnd - state->PCPos) >> 1;
                    fmt = "$%04x";
                    break;
                default:
                    bytSize = 1;
                    strcpy(Ci.mnem, "dc.b");
                    bytCount = blkEnd - state->PCPos;
                    fmt = "$%02x";
                }

                while (bytCount--)
                {
                    int val = 0;

                    switch (bytSize)
                    {
                    case 1:
                        val = *(iBuf++) & 0xff;
                        break;
                    case 4:
                        val = bufReadL(&iBuf);
                        break;
                    default:
                        val = bufReadW(&iBuf);
                    }

                    state->PCPos += bytSize;
                    sprintf(Ci.params, fmt, val);
                    PrintLine(pseudcmd, &Ci, cclass, state->CmdEnt, state->opt);
                    state->CmdEnt = state->PCPos;
                    Ci.lblname = NULL;
                    Ci.params[0] = '\0';
                }

                Ci.mnem[0] = '\0';
            }
        }
    }

    return iBuf;
}

/*
 * Moves initialized data into the listing. Really a setup routine.
 * Passed : (1) nl - Ptr to proper nlist, positioned at the first
 *                    element to be listed
 *          (2) mycount - count of elements in this sect.
 *          (3) class   - Label Class letter
 */
void ListInitROF(char* hdr, struct rof_extrn* refsList, char* iBuf, unsigned int isize, char iClass,
                 struct parse_state* state)
{
    auto category = labelManager->getCategory(iClass);
    Label* lblList = category ? category->getFirst() : NULL;

    while (state->PCPos < isize)
    {
        register int blkEnd;

        blkEnd = isize; /* Make this a default */

        if (lblList)
        {
            if (label_getNext(lblList))
            {
                blkEnd = label_getNext(lblList)->myAddr;
            }
        }

        iBuf = DataDoBlock(&refsList, &lblList, iBuf, blkEnd, iClass, state);
    }
}

void setupROFPass(int Pass)
{
    if (Pass == 1)
    {
        codeRefs_sav = refs_code;
    }
    else
    {
        refs_code = codeRefs_sav;
    }
}

/*
 * rof_setup_ref:
 *
 * ref: Reference to desired struct rof_extrn
 * addr: The position in the code where toe ref is located
 * dest: Pointer to where the string is to be stored
 * value: The value found at @addr.  If it's nonzero, this is the value to add o subtract to/from the ref
 *
 * Checks to see if an external reference is found at this location, nd if so, sets up the assembler string for this
 * portion of the opcode
 *
 * Returns: trturns TRUE (1) if a ref was found and set up, FALSE (0) if no ref found here
 */
int rof_setup_ref(struct rof_extrn* ref, int addrs, char* dest, int val)
{
    if (find_extrn(ref, addrs))
    {
        strcpy(dest, find_extrn(ref, addrs)->nam.c_str());

        if (val != 0)
        {
            strcat(dest, (val > 0 ? "+" : "-"));
            sprintf(&dest[strlen(dest)], "%d", abs(val));
        }

        return 1;
    }
    else
    {
        return 0;
    }
}

char* IsRef(char* dst, int curloc, int ival, int Pass)
{
    register char* retVal = NULL;

    if (refs_code && (refs_code->Ofst == curloc))
    {
        register struct rof_extrn* ep_tmp;

        if (Pass == 1)
        {
            refs_code = refs_code->ENext;
            retVal = dst;
        }
        else
        {
            if (refs_code->Extrn)
            {
                strcpy(dst, refs_code->nam.c_str());
                retVal = dst;

                if (ival)
                {
                    char offsetbuf[20];

                    strcat(dst, (refs_code->Type & 0x80) ? "-" : "+");
                    sprintf(offsetbuf, "%d", ival);
                    strcat(dst, offsetbuf);
                }
            } /* Else leave retVal=NULL - for local refs, let calling process handle it */
            else
            {
                // Pretty sure this is a bug, and it's supposed to be strcpy().
                strcat(dst, refs_code->lbl->name());
                retVal = dst;
            }

            ep_tmp = refs_code->ENext;

            if (!refs_code->MyNext)
            {
                /*if (refs_code->Extrn)
                {
                    free (refs_code->EName.nam);
                }*/
            }

            if (ep_tmp)
            {
                ep_tmp->EUp = NULL;
            }

            delete refs_code;
            refs_code = ep_tmp;
        }
    } /* End "if (refs_code && (refs_code->Ofst == val)) */

    return retVal;
}
