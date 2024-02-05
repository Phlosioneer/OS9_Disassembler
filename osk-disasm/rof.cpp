
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

#include "pch.h"

#include "rof.h"

#include <algorithm>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "disglobs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "label.h"
#include "main_support.h"
#include "params.h"
#include "userdef.h"
#include "writer.h"

/*
struct rof_extrn *refs_data, *refs_idata, *refs_code, *refs_remote, *refs_iremote,
    *extrns, // Generic external pointer
    *codeRefs_sav;
*/

//refmap refs_data, refs_idata, refs_code, refs_remote, refs_iremote, extrns;
ReferenceManager refManager{};

static void get_refs(std::string& vname, size_t count, ReferenceScope ref_typ, BigEndianStream* codebuffer,
                     BigEndianStream* Module);

rof_extrn::rof_extrn(uint16_t type, uint32_t offset, bool isExternal) : type(type), offset(offset), isExternal(isExternal)
{
}

const char* extern_def_name(struct rof_extrn* handle)
{
    if (!handle->hasName)
    {
        errexit("Cannot access name of label; not implemented yet");
    }
    return handle->name.c_str();
}

/*
 * Add the initialization data to the Labels Ref. On entry, the file pointer is
 * positioned to the begin of the initialized data list for this particular vsect.
 */
void AddInitLbls(refmap& tbl, char klas, BigEndianStream* Module)
{
    uint32_t refVal;

    for (auto& it : tbl)
    {
        if (!it.second.isExternal)
        {
            Module->seekAbsolute(it.second.offset);

            switch (it.second.size())
            {
            case 1: /*SIZ_BYTE:*/
                refVal = Module->read<uint8_t>();
                break;
            case 2: /*SIZ_WORD:*/
                refVal = Module->read<uint16_t>();
                break;
            default:
                refVal = Module->read<uint32_t>();
            }
            it.second.hasName = false;
            it.second.label = labelManager.addLabel(it.second.space, refVal);
        }
    }
}

void getRofHdr(struct options* opt)
{
    opt->IsROF = true;
    opt->ROFHd = std::make_unique<RoffFile>(opt->Module.get());
}

/*
 * Read and interpret rof header
 */
RoffFile::Header::Header(BigEndianStream& stream)
{

    stream.reset(); /* Start all over */

    uint32_t sync = stream.read<uint32_t>();

    if (sync != RoffFile::sync())
    {
        errexit("Illegal ROF Module sync bytes");
    }

    type = stream.read<uint8_t>();
    language = stream.read<uint8_t>();
    attributes = stream.read<uint8_t>();
    revision = stream.read<uint8_t>();
    valid = stream.read<uint16_t>();  /* Nonzero if valid */
    assemblerVersion = stream.read<uint16_t>(); /* Assembler version used to compile */
    stream.readVec(assembleDate, 6);
    edition = stream.read<uint16_t>();

    staticStorage = stream.read<uint32_t>();   /* Size of static variable storage */
    combinedDataSize = stream.read<uint32_t>();        /* Size of initialized data */
    codeSize = stream.read<uint32_t>();         /* Size of the object code  */
    stackSize = stream.read<uint32_t>();         /* Size of stack required   */
    entryPointOffset = stream.read<uint32_t>();    /* Offset to entry point of object code   */
    trapHandlerOffset = stream.read<uint32_t>();         /* Offset to unitialized trap entry point */
    remoteStaticDataSize = stream.read<uint32_t>(); /* Size of remote static storage */
    remoteCombinedDataSize = stream.read<uint32_t>(); /* Size of remote initialized data */
    debugSize = stream.read<uint32_t>();      /* Size of the debug   */

    moduleName = stream.read<std::string>();
}

RoffFile::RoffFile(BigEndianStream* stream, Header& header)
    : type(header.type), language(header.language), attributes(header.attributes), revision(header.revision),
      isValid(header.valid != 0), assemblerVersion(header.assemblerVersion), assembleDate(header.assembleDate),
      edition(header.edition), statstorage(header.staticStorage), combinedDataSize(header.combinedDataSize),
      codeSize(header.codeSize), stackSize(header.stackSize), entryPointOffset(header.entryPointOffset),
      trapHandlerOffset(header.trapHandlerOffset), remoteStaticDataSize(header.remoteStaticDataSize),
      remoteCombinedDataSize(header.remoteCombinedDataSize), debugSize(header.debugSize), moduleName(header.moduleName)
{
    if (header.valid > 1)
    {
        // TODO: Emit a warning
    }

    /* ************************************************ *
     * Get the Global definitions                       *
     * ************************************************ */
    uint16_t glbl_cnt, count; /* Generic counter */
    count = glbl_cnt = stream->read<uint16_t>();

    while (count--)
    {
        std::string name;
        uint16_t typ;
        uint32_t adrs;

        name = stream->read<std::string>();
        typ = stream->read<uint16_t>();
        adrs = stream->read<uint32_t>();

        RoffReferenceInfo info{typ, ReferenceScope::REFGLBL};

        auto me = labelManager.addLabel(info.space(), adrs, std::move(name));
        if (me)
        {
            me->setGlobal(true);
        }
    }

    /* Read code into buffer for get_refs() while we're here */

    // codeBuf = new char[(size_t)codeSize + 1];
    // stream->readRaw(codeBuf, codeSize);
    codeStream = std::make_unique<BigEndianStream>(stream->fork(codeSize));

    /* ********************************** *
     *    Initialized data Section        *
     * ********************************** */

    initDataStream = std::make_unique<BigEndianStream>(stream->fork(combinedDataSize));
    initRemoteDataStream = std::make_unique<BigEndianStream>(stream->fork(remoteCombinedDataSize));
    debugDataStream = std::make_unique<BigEndianStream>(stream->fork(debugSize));

    /* ********************************** *
     *    External References Section     *
     * ********************************** */

    for (auto ext_count = stream->read<uint16_t>(); ext_count > 0; ext_count--)
    {
        std::string _name;
        uint16_t refcount;

        _name = stream->read<std::string>();
        refcount = stream->read<uint16_t>();

        /* Get the individual occurrences for this name */

        get_refs(_name, refcount, ReferenceScope::REFXTRN, NULL, stream);
    }

    /* *************************** *
     *    Local variables...       *
     * *************************** */

    auto local_count = stream->read<uint16_t>();
    get_refs(std::string(), local_count, ReferenceScope::REFLOCAL, codeStream.get(), stream);

    /* Now we need to add labels for these refs */

    /* common block variables... */
    /* Do this after everything else is done */

    AddInitLbls(refManager.refs_idata, '_', initDataStream.get());
    AddInitLbls(refManager.refs_iremote, 'H', initRemoteDataStream.get());

    /* Now we're ready to disassemble the code */
}

#define IS_COMMON(type) ((type & 0x100) != 0)
#define IS_COMMON_INIT(type) ((type & 0x020) != 0)
/* Docs are backward? */
#define IS_DATA(type)   ((type & 0x004) == 0)
#define IS_REMOTE(type) ((type & 0x002) != 0)
/* Docs are backward ? */
#define IS_INIT(type)   ((type & 0x001) != 0)
#define IS_EQUATE(type) ((type & 0x002) != 0)
#define IS_DEBUG(type)  ((type & 0x200) != 0)

/*
 * Returns the Destination reference for the reference.
 * Passed: The Type byte from the reference.
 * Returns: The Class Letter for the entry.
 */
AddrSpaceHandle RoffReferenceInfo::space() const
{
    /* We'll tie up additional classes for data/bss as follows
     * D for data
     * _ for init data
     * G for remote
     * H for remote init
     *
     */

    switch (scope)
    {
    case ReferenceScope::REFGLBL:
        switch (type & 0x100)
        {
        case 0:                 /* NOT common */
            switch (type & 0x04) /* Docs are backward? */
            {
            case 0:                 /* Data */
                switch (type & 0x01) /* Docs are backward ? */
                {
                case 0: /* Uninit */
                    switch (type & 0x02)
                    {
                    case 0:
                        // return 'D';
                        return &UNINIT_DATA_SPACE;
                    default:
                        // return 'G';
                        return &UNINIT_REMOTE_SPACE;
                    }
                default: /* Init */
                    switch (type & 0x02)
                    {
                    case 0:
                        // return '_';
                        return &INIT_DATA_SPACE;
                    default:
                        // return 'H';
                        return &INIT_REMOTE_SPACE;
                    }
                }
            default: /* Code or Equ */
                switch (type & 0x02)
                {
                case 0: /* NOT remote */
                    // return 'L';
                    return &CODE_SPACE;
                default:
                    // return 'L';
                    return &CODE_SPACE; /* FIXME: This is actually 'equ' */
                }
            }
        default: /* common */
            switch (type & 0x20)
            {
            case 0: /* NOT Remote */
                /* These are WRONG! but for now, we'll use them */
                // return '_';
                return &UNINIT_DATA_SPACE;
            default:
                // return 'D';
                return &INIT_DATA_SPACE;
            }
        }

        break;

    case ReferenceScope::REFXTRN:
    case ReferenceScope::REFLOCAL:
        switch (type & 0x20)
        {
        case 0: /* NOT remote */
            switch (type & 0x200)
            {
            case 0: /* data */
                // return '_';
                return &INIT_DATA_SPACE;
            default: /* remote */
                // return 'L';
                return &CODE_SPACE;
            }
        default:
            switch (type & 0x200)
            {
            case 0: /* code */
                // return 'L';
                return &CODE_SPACE;
            default: /* debug */
                // return 'L';
                return &DEBUG_SPACE;
            }
        }
    }

    // return 'L'; /* Should never get to here, but for safety's sake */
    throw std::runtime_error("Unknown address space");
}

/*
 * Get entries for given reference, either external or local.
 * Passed:  name (or blank for locals)
 *          count - number of entries to process
 *          1 if external, 0 if local
 */
static void get_refs(std::string& vname, size_t count, ReferenceScope ref_typ, BigEndianStream* code_buf,
                     BigEndianStream* Module)
{
    struct rof_extrn* prevRef = NULL;
    AddrSpaceHandle space;
    uint16_t _ty;
    uint32_t _ofst;
    refmap* base;

    for (; count > 0; count--)
    {
        _ty = Module->read<uint16_t>();   // fread_w(ModFP);
        _ofst = Module->read<uint32_t>(); // fread_l(ModFP);

        RoffReferenceInfo info{_ty, ref_typ};

        /* Add to externs table */
        space = info.space();
        if (!space) throw std::runtime_error("Unexpected class: nullptr");
        if (*space == CODE_SPACE)
        {
            base = &refManager.refs_code;
        }
        else if (*space == UNINIT_DATA_SPACE)
        {
            base = &refManager.refs_data;
        }
        else if (*space == INIT_DATA_SPACE)
        {
            base = &refManager.refs_idata;
        }
        else if (*space == UNINIT_REMOTE_SPACE)
        {
            base = &refManager.refs_remote;
        }
        else if (*space == INIT_REMOTE_SPACE)
        {
            base = &refManager.refs_iremote;
        }
        else if (*space == DEBUG_SPACE)
        {
            /* Skip Debug refs */
            continue;
        }
        else
        {
            throw std::runtime_error("Unexpected class: " + space->name);
        }
        
        rof_extrn new_ref(_ty, _ofst, ref_typ == ReferenceScope::REFXTRN);

        /*base = &refs_data;*/ /* For the time being, let's try to just use one list for all refs */

        if (new_ref.isExternal)
        {
            new_ref.hasName = true;
            new_ref.name = vname;
        }
        else
        {
            register int dstVal;
            code_buf->seekAbsolute(new_ref.offset);

            RoffReferenceInfo globalInfo{_ty, ReferenceScope::REFGLBL};
            new_ref.space = globalInfo.space();

            if ((ref_typ == ReferenceScope::REFLOCAL) && (*space == CODE_SPACE))
            {
                switch (new_ref.size())
                {
                case 1:
                    // dstVal = *pt & 0xff;
                    dstVal = code_buf->read<uint8_t>();
                    break;
                case 2:
                    // dstVal = bufReadW(&pt);
                    dstVal = code_buf->read<uint16_t>();
                    break;
                case 3:
                    // dstVal = bufReadL(&pt);
                    dstVal = code_buf->read<uint32_t>();
                    break;
                default:
                    throw std::runtime_error("Unexpected size");
                }
                new_ref.hasName = false;
                new_ref.label = labelManager.addLabel(new_ref.space, dstVal);
            }
            else
            {
                // These are local refs; they indicate a label's value should be subbed
                // into the expression. DoDataBlock should handle this automatically for
                // data references by just existing in the refmap. Not sure about code references?

                // TODO: Lookup the value in the specified location, and ensure there
                // is a label for it. Maybe add a tag to the label to force it to appear
                // for that particular address?
            }
        }

        (*base)[_ofst] = new_ref;
    }
}

struct rof_extrn* ReferenceManager::find_extrn(refmap& xtrn, unsigned int adrs)
{
    auto it = xtrn.find(adrs);
    if (it == xtrn.end()) return nullptr;
    return &it->second;
}

/*
 * Process a block composed of an initialized reference from a data area.
 * Passed : (1) struct rof_extrn *mylist - pointer to tree element
 *          (2) int datasize - the size of the area to process
 *          (3) char class - the label class (D or C)
 */
void DataDoBlock(refmap* refsList, uint32_t blkEnd, AddrSpaceHandle space, struct parse_state* state)
{
    /* Insert Label if applicable */

    auto label = labelManager.getLabel(space, state->CmdEnt);
    std::string labelName;
    if (label)
    {
        if (label->global())
        {
            labelName = label->nameWithColon();
        }
        else
        {
            labelName = label->name();
        }
    }

    while (state->PCPos < blkEnd)
    {
        state->CmdEnt = state->PCPos;

        // Check if this is the start of a reference.
        rof_extrn* ref = refsList ? refManager.find_extrn(*refsList, state->CmdEnt) : nullptr;
        if (ref)
        {
            OperandSize size;
            std::vector<uint16_t> rawData;
            switch (ref->size())
            {
            case 1: /* SIZ_BYTE */
                size = OperandSize::Byte;
                rawData.push_back(state->Module->read<uint8_t>());
                break;
            case 2: /* SIZ_WORD */
                size = OperandSize::Word;
                state->Module->readVec(rawData, 1);
                break;
            default: /* SIZ_LONG */
                size = OperandSize::Long;
                state->Module->readVec(rawData, 2);
            }
            state->PCPos += OperandSizes::getByteCount(size);

            std::string mnem("dc");
            mnem += OperandSizes::getSuffix(size);

            std::string name;
            if (ref->isExternal)
            {
                name = ref->name;
            }
            else
            {
                name = ref->label->name();
            }
            
            PrintDirective(labelName, mnem.c_str(), name, state->CmdEnt, state->PCPos, state->opt, rawData, space);
            labelName.clear();
            state->CmdEnt = state->PCPos;
        }
        else /* No reference entry for this area */
        {
            if (DoAsciiBlock(labelName, blkEnd - state->CmdEnt, space, state) != 0)
            {
                // Only apply the label for the first line.
                labelName.clear();
                continue;
            }
            else
            {
                OperandSize size;
                switch ((blkEnd - state->PCPos) % 4)
                {
                case 0:
                    size = OperandSize::Long;
                    break;
                case 2:
                    size = OperandSize::Word;
                    break;
                default:
                    size = OperandSize::Byte;
                }

                const auto directive = std::string("dc") + OperandSizes::getSuffix(size);
                const auto dataCount = (blkEnd - state->PCPos) / OperandSizes::getByteCount(size);

                for (size_t i = 0; i < dataCount; i++)
                {
                    int val = 0;

                    switch (size)
                    {
                    case OperandSize::Byte:
                        val = state->Module->read<uint8_t>();
                        break;
                    case OperandSize::Word:
                        val = state->Module->read<uint16_t>();
                        break;
                    case OperandSize::Long:
                        val = state->Module->read<uint32_t>();
                        break;
                    default:
                        throw std::runtime_error("Unexpected size");
                    }
                    state->PCPos += OperandSizes::getByteCount(size);
                    auto formatted = FormattedNumber(val, size, &LITERAL_HEX_SPACE);
                    PrintDirective(labelName, directive.c_str(), formatted,
                                   state->CmdEnt, state->PCPos,
                                   state->opt, space);
                    // Only apply the label for the first line.
                    labelName.clear();
                    state->CmdEnt = state->PCPos;
                }
            }
        }
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
bool rof_setup_ref(std::string& out_name, refmap& ref, uint32_t addrs, int32_t val)
{
    auto r = refManager.find_extrn(ref, addrs);
    if (r)
    {
        if (r->hasName)
        {
            out_name = r->name;
        }
        else
        {
            out_name = r->label->name();
        }

        if (val != 0)
        {
            out_name += val > 0 ? "+" : "-";
            char temp[200];
            sprintf_s(temp, "%d", abs(val));
            out_name += temp;
        }

        return true;
    }
    else
    {
        return false;
    }
}

bool IsRef(std::string& out_name, uint32_t curloc, uint32_t ival, int Pass)
{
    register char* retVal = NULL;

    auto it = refManager.refs_code.find(curloc);
    if (it != refManager.refs_code.end())
    {
        if (Pass == 1)
        {
            return true;
        }
        else
        {
            if (it->second.isExternal)
            {
                out_name = it->second.name;

                if (ival)
                {
                    out_name += (it->second.type & 0x80) ? "-" : "+";
                    char temp[200];
                    sprintf_s(temp, "%d", ival);
                    out_name += temp;
                }
                return true;
            } /* Else leave retVal=NULL - for local refs, let calling process handle it */
            else
            {
                // Pretty sure this is a bug, and it's supposed to be strcpy().
                out_name = it->second.label->name();
                return true;
            }
        }
    }

    return retVal;
}

void ReferenceManager::clear()
{
    refs_data.clear();
    refs_idata.clear();
    refs_remote.clear();
    refs_iremote.clear();
    refs_code.clear();
    extrns.clear();
}