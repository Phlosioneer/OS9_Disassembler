
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

    /* Read code into buffer for parseRefSection() while we're here */

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

        parseRefSection(_name, refcount, ReferenceScope::REFXTRN, NULL, stream);
    }

    /* *************************** *
     *    Local variables...       *
     * *************************** */

    auto local_count = stream->read<uint16_t>();
    parseRefSection(std::string(), local_count, ReferenceScope::REFLOCAL, codeStream.get(), stream);

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
 * Process a block composed of an initialized reference from a data area.
 * Passed : (1) struct RelocatedReference *mylist - pointer to tree element
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
        const std::vector<RelocatedReference>* refs = refManager.find_extrn(space, state->CmdEnt);
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
 * ref: Reference to desired struct RelocatedReference
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


static bool areAllRefsExternal(const std::vector<RelocatedReference>& refs)
{
    for (const RelocatedReference& ref : refs) {
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
bool refsToExpression(std::string& out_text, const std::vector<RelocatedReference>& refs, uint32_t currentAddress, uint32_t literalValue,
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

    for (const RelocatedReference& ref : refs)
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