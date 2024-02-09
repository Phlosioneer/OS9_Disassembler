/* ******************************************************************** *
 * rof.h - header file for rof definitions                              *
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
 * ******************************************************************** */

#ifndef ROF_H
#define ROF_H

#include "pch.h"

#include "references.h"


class RoffFile
{
  private:
    /* Represents the raw values in a ROFF file header.*/
    struct Header
    {
        uint8_t type = 0, language = 0, attributes = 0, revision = 0;
        uint16_t valid = 0, assemblerVersion = 0, edition = 0;
        uint32_t staticStorage = 0, combinedDataSize = 0, codeSize = 0, stackSize = 0, entryPointOffset = 0,
            trapHandlerOffset = 0, remoteStaticDataSize = 0, remoteCombinedDataSize = 0, debugSize = 0;
        std::vector<uint8_t> assembleDate{};
        std::string moduleName{};

        Header(BigEndianStream& stream);
    };

  public:
    const uint8_t type;
    const uint8_t language;
    const uint8_t attributes;
    const uint8_t revision;

    /* Flag in the Roff file indicating whether it can be linked. Probably used to prevent
     * linking partially-finished files.
     */
    const bool isValid;

    /* Assembler version used to compile the file. */
    const uint16_t assemblerVersion;
    
    /* The date this file was assembled. */
    const std::vector<uint8_t> assembleDate;

    const uint16_t edition;
    
    /* Size of static variable storage */
    const uint32_t statstorage;
    
    /* Size of uninitialized and initialized data */
    const uint32_t combinedDataSize;
    
    /* Size of the object code  */
    const uint32_t codeSize;
    
    /* Size of stack required   */
    const uint32_t stackSize;
    
    /* Offset to entry point of object code   */
    const uint32_t entryPointOffset;
    
    /* Offset to unitialized trap entry point */
    const uint32_t trapHandlerOffset;
    
    /* Size of remote static storage   */
    const uint32_t remoteStaticDataSize;
    
    /* Size of remote initialized data */
    const uint32_t remoteCombinedDataSize;
    
    /* Size of the debug   */ 
    const uint32_t debugSize;
    
    /* Module name  */
    const std::string moduleName;

    std::unique_ptr<BigEndianStream> codeStream{};
    std::unique_ptr<BigEndianStream> initDataStream{};
    std::unique_ptr<BigEndianStream> initRemoteDataStream{};
    std::unique_ptr<BigEndianStream> debugDataStream{};

    inline RoffFile(BigEndianStream* stream) : RoffFile(stream, Header(*stream))
    {
    }

    static constexpr uint32_t sync()
    {
        return 0xdeadface;
    }

private:
    RoffFile(BigEndianStream* stream, Header& header);
    
};


void DataDoBlock(uint32_t blkEnd, AddrSpaceHandle space, struct parse_state* state);
bool rof_setup_ref(std::string& out_text, AddrSpaceHandle space, uint32_t addrs, uint32_t val, int Pass, OperandSize sizeConstraint,
                   bool isRelativeRefImplied);
bool IsRef(std::string& out_text, uint32_t curloc, uint32_t ival, int Pass, OperandSize sizeConstraint, bool flipRefSign);
bool refsToExpression(std::string& out_text, const std::vector<RelocatedReference>& refs, uint32_t currentAddress, uint32_t literalValue,
                      int Pass, OperandSize sizeConstraint, bool isRelativeRefImplied);
OperandSize maxSizeOfRefs(const std::vector<RelocatedReference>& refs);

#endif // ROF_H