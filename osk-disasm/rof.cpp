
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
#include <string.h>

#include "address_space.h"
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

const refmap ReferenceManager::dummyEmptyRefmap{};

ReferenceManager refManager{};

static void get_refs(const std::string& vname, size_t count, ReferenceScope ref_typ, BigEndianStream* codebuffer,
                     BigEndianStream* Module);

rof_extrn::rof_extrn(RoffReferenceInfo refInfo, uint32_t offset) : info(refInfo), offset(offset)
{
}


/*
 * Add the initialization data to the Labels Ref. On entry, the file pointer is
 * positioned to the begin of the initialized data list for this particular vsect.
 */
void ReferenceManager::addInitialLabels(AddrSpaceHandle space, BigEndianStream* Module)
{
    uint32_t refVal;

    // Note: creates a ref space, if it doesn't exist already.
    for (auto& vec : refsBySpace[space])
    {
        for (auto& ref : vec.second)
        {
            if (!ref.isExternal())
            {
                Module->seekAbsolute(ref.offset);

                switch (ref.info.opSize())
                {
                case OperandSize::Byte:
                    refVal = Module->read<uint8_t>();
                    break;
                case OperandSize::Word:
                    refVal = Module->read<uint16_t>();
                    break;
                case OperandSize::Long:
                    refVal = Module->read<uint32_t>();
                    break;
                default:
                    throw std::runtime_error("Unreachable");
                }
                ref.setLabel(labelManager.addLabel(ref.space, refVal));
            }
        }
    }
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

    refManager.addInitialLabels(&INIT_DATA_SPACE, initDataStream.get());
    refManager.addInitialLabels(&INIT_REMOTE_SPACE, initRemoteDataStream.get());

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
            switch (type & 0x04) /* Docs are backward? They say 0x01 */
            {
            case 0:                 /* Data */
                switch (type & 0x01) /* Docs are backward? They say 0x02 */
                {
                case 0: /* Uninit */
                    switch (type & 0x02) /* Docs are backward? They say 0x04 */
                    {
                    case 0:
                        // return 'D';
                        return &UNINIT_DATA_SPACE;
                    default:
                        // return 'G';
                        return &UNINIT_REMOTE_SPACE;
                    }
                default: /* Init */
                    switch (type & 0x02) /* Docs are backward? They say 0x04 */
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
                /* FIXME: Based on the above backwards columns, I think this should be `type & 0x1`.
                 * For now, it's using 0x02 as documented.
                 */
                switch (type & 0x02)
                {
                case 0: /* code */
                    // return 'L';
                    return &CODE_SPACE;
                default: /* equ */
                    // return 'L';
                    return &EQUATE_SPACE;
                }
            }
        default: /* common */
            /* FIXME: This appears to be a typo. */
            switch (type & 0x20)
            {
            case 0: /* NOT Remote */
                /* These are WRONG! but for now, we'll use them */
                return &UNINIT_DATA_SPACE;
            default:
                return &INIT_DATA_SPACE;
            }
        }

        break;

    case ReferenceScope::REFXTRN:
    case ReferenceScope::REFLOCAL:
        switch (type & 0x200)
        {
        case 0: /* NOT remote */
            switch (type & 0x20)
            {
            case 0: /* data */
                return &INIT_DATA_SPACE;
            default: /* code */
                return &CODE_SPACE;
            }
        default:
            switch (type & 0x20)
            {
            case 0: /* Remote */
                return &INIT_REMOTE_SPACE;
            default: /* debug (undocumented) */
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
static void get_refs(const std::string& vname, size_t count, ReferenceScope ref_typ, BigEndianStream* code_buf,
                     BigEndianStream* Module)
{
    rof_extrn* prevRef = NULL;
    AddrSpaceHandle space;
    uint16_t _ty;
    uint32_t _ofst;

    for (; count > 0; count--)
    {
        _ty = Module->read<uint16_t>();
        _ofst = Module->read<uint32_t>();

        RoffReferenceInfo info{_ty, ref_typ};

        /* Add to externs table */
        space = info.space();
        if (!space) throw std::runtime_error("Unexpected class: nullptr");
        if (*space == DEBUG_SPACE)
        {
            // Skip Debug refs
            continue;
        }
        
        rof_extrn new_ref(info, _ofst);

        if (new_ref.isExternal())
        {
            new_ref.setName(vname);
        }
        else
        {
            register int dstVal;
            code_buf->seekAbsolute(new_ref.offset);

            RoffReferenceInfo globalInfo{_ty, ReferenceScope::REFGLBL};
            new_ref.space = globalInfo.space();

            if ((ref_typ == ReferenceScope::REFLOCAL) && (*space == CODE_SPACE))
            {
                switch (new_ref.info.opSize())
                {
                case OperandSize::Byte:
                    dstVal = code_buf->read<uint8_t>();
                    break;
                case OperandSize::Word:
                    dstVal = code_buf->read<uint16_t>();
                    break;
                case OperandSize::Long:
                    dstVal = code_buf->read<uint32_t>();
                    break;
                default:
                    throw std::runtime_error("Unexpected size");
                }
                new_ref.setLabel(labelManager.addLabel(new_ref.space, dstVal));
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

        refManager.insert(space, std::move(new_ref));
    }
}

const std::vector<rof_extrn>* ReferenceManager::find_extrn(AddrSpaceHandle space, uint32_t adrs) const
{
    auto refmap = refsBySpace.find(space);
    if (refmap == refsBySpace.cend())
    {
        return nullptr;
    }

    auto it = refmap->second.find(adrs);
    if (it == refmap->second.cend())
    {
        return nullptr;
    }

    return &it->second;
}

void ReferenceManager::insert(AddrSpaceHandle space, rof_extrn&& move_ref)
{
    // This will create a refmap if the space is absent, then create a vector for the
    // address if that's absent.
    refsBySpace[space][move_ref.offset].emplace_back(move_ref);
}

/*
 * Process a block composed of an initialized reference from a data area.
 * Passed : (1) struct rof_extrn *mylist - pointer to tree element
 *          (2) int datasize - the size of the area to process
 *          (3) char class - the label class (D or C)
 */
void DataDoBlock(uint32_t blkEnd, AddrSpaceHandle space, struct parse_state* state)
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
        const std::vector<rof_extrn>* refs = refManager.find_extrn(space, state->CmdEnt);
        if (refs && refs->size() > 0)
        {
            const OperandSize size = maxSizeOfRefs(*refs);
            std::vector<uint16_t> rawData;
            uint32_t valueRead;
            switch (size)
            {
            case OperandSize::Byte:
                valueRead = state->Module->read<uint8_t>();
                rawData.push_back(valueRead);
                break;
            case OperandSize::Word:
                valueRead = state->Module->read<uint16_t>();
                state->Module->undo();
                state->Module->readVec(rawData, 1);
                break;
            case OperandSize::Long:
                valueRead = state->Module->read<uint32_t>();
                state->Module->undo();
                state->Module->readVec(rawData, 2);
                break;
            default:
                throw std::runtime_error("Unreachable");
            }
            state->PCPos += OperandSizes::getByteCount(size);

            std::string mnem("dc");
            mnem += OperandSizes::getSuffix(size);
            
            std::string expression;
            refsToExpression(expression, *refs, state->PCPos, valueRead, state->Pass, OperandSize::Long, false);
            
            PrintDirective(labelName, mnem.c_str(), expression, state->CmdEnt, state->PCPos, state->opt, rawData, space);
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
                        throw std::runtime_error("Unreachable");
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
 * 
 * isRelativeRefImplied: For some instructions (branches) and some argument forms (pc displacements), the assembler
 * forces references to be relative. For correct disassembly, we need to undo that.
 */
bool rof_setup_ref(std::string& out_text, AddrSpaceHandle space, uint32_t addrs, uint32_t val, int Pass, OperandSize sizeConstraint, bool isRelativeRefImplied)
{
    auto refs = refManager.find_extrn(space, addrs);
    if (refs && refs->size() > 0)
    {
        return refsToExpression(out_text, *refs, addrs, val, Pass, sizeConstraint, isRelativeRefImplied);
    }
    return false;
}

 /* isRelativeRefImplied : For some instructions(branches) and some argument forms(pc displacements), the assembler
  * forces references to be relative.For correct disassembly, we need to undo that.
  */
bool IsRef(std::string& out_text, uint32_t curloc, uint32_t ival, int Pass, OperandSize sizeConstraint,
           bool isRelativeRefImplied)
{
    const auto refs = refManager.find_extrn(&CODE_SPACE, curloc);
    if (refs)
    {
        return refsToExpression(out_text, *refs, curloc, ival, Pass, sizeConstraint, isRelativeRefImplied);
    }

    return false;
}

void ReferenceManager::clear()
{
    refsBySpace.clear();
}

OperandSize maxSizeOfRefs(const std::vector<rof_extrn>& refs)
{
    OperandSize max = OperandSize::Byte;
    for (const rof_extrn& ref : refs)
    {
        max = OperandSizes::max(max, ref.info.opSize());
    }
    return max;
}

static bool areAllRefsExternal(const std::vector<rof_extrn>& refs)
{
    for (const rof_extrn& ref : refs) {
        if (!ref.isExternal())
        {
            return false;
        }
    }
    return true;
}

/* isRelativeRefImplied : For some instructions(branches) and some argument forms(pc displacements), the assembler
 * forces references to be relative.For correct disassembly, we need to undo that. 
 */
bool refsToExpression(std::string& out_text, const std::vector<rof_extrn>& refs, uint32_t currentAddress, uint32_t literalValue,
                      int Pass, OperandSize sizeConstraint, bool isRelativeRefImplied)
{
    std::ostringstream buffer;
    bool isFirstRef = true;

    if (literalValue != 0 && areAllRefsExternal(refs))
    {
        // TODO: This needs to change. If isRelativeRefImplied = true, and literal != 0, then this literal needs
        // to be registered as a label just like LblCalc would normally do. But we can't call lblcalc, because that's
        // recursive!
        bool labelWritten = false;
        if (isRelativeRefImplied)
        {
            int32_t adjustedValue = static_cast<int32_t>(literalValue + currentAddress);
            bool isNegative = (adjustedValue < 0);
            uint32_t absoluteValue = abs(adjustedValue);
            if (Pass == 1)
            {
                labelManager.addLabel(&CODE_SPACE, absoluteValue);
            }
            else
            {
                auto label = labelManager.getLabel(&CODE_SPACE, absoluteValue);
                if (label)
                {
                    if (isNegative)
                    {
                        buffer << '-';
                    }
                    buffer << label->name();
                    labelWritten = true;
                }
            }
        }

        if (!labelWritten)
        {
            buffer << "$" << std::hex << literalValue;
        }
        isFirstRef = false;
    }

    for (const rof_extrn& ref : refs)
    {
        if (ref.info.opSize() > sizeConstraint)
        {
            return false;
        }

        if (isFirstRef)
        {
            isFirstRef = false;
            buffer << (ref.info.isPositive() ? "" : "-");
        }
        else
        {
            buffer << (ref.info.isPositive() ? "+" : "-");
        }

        // Note: I've confirmed through experiments that the assembler makes ALL
        //       references in an expression relative.
        if (ref.info.isRelative() && !isRelativeRefImplied)
        {
            // Print out as relative ref.
            buffer << "(*-" << ref.getName() << ")";
        }
        else
        {
            // Print out normally.
            buffer << ref.getName();
        }
    }

    out_text = buffer.str();
    return true;
}