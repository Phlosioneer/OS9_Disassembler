/* ************************************************************************ *
 *                                                                          *
 * os9disasm - a project to disassemble Os9-coco modules into source code   *
 *             following the example of Dynamite+                           *
 *                                                                          *
 * ************************************************************************ *
 *                                                                          *
 *  Edition History:                                                        *
 *  #  Date       Comments                                              by  *
 *  -- ---------- -------------------------------------------------     --- *
 *  01 2003/01/31 First began project                                   dlb *
 * ************************************************************************ *
 * File:  cmdfile.c                                                         *
 * Purpose: process command file                                            *
 *                                                                          *
 * ************************************************************************ *
 *                                                                          *
 * Copyright (c) 2017 David Breeding                                        *
 *                                                                          *
 * This file is part of osk-disasm.                                         *
 *                                                                          *
 * osk-disasm is free software: you can redistribute it and/or modify       *
 * it under the terms of the GNU General Public License as published by     *
 * the Free Software Foundation, either version 3 of the License, or        *
 * (at your option) any later version.                                      *
 *                                                                          *
 * osk-disasm is distributed in the hope that it will be useful,            *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
 * GNU General Public License for more details.                             *
 *                                                                          *
 * You should have received a copy of the GNU General Public License        *
 * (see the file "COPYING") along with osk-disasm.  If not,                 *
 * see <http://www.gnu.org/licenses/>.                                      *
 *                                                                          *
 * ************************************************************************ */

#include "pch.h"

#include "nlohmann/json.hpp"

#include "cmdfile.h"
#include "commonsubs.h"
#include "main_support.h"

using json = nlohmann::json;

RegionManager allRegions;

void do_cmd_file(struct options* opt)
{
    /* We will do our check for a specification for the CmdFile here */
    if (opt->CmdFileName.empty())
    {
        return;
    }

    json commands;
    try
    {
        commands = json::parse(std::ifstream(opt->CmdFileName));
    }
    catch (nlohmann::detail::exception e)
    {
        throw e;
    }
    const auto regions = commands["ranges"];
    for (auto& region : regions)
    {
        auto type = region["type"];
        if (type == "data")
        {
            auto size = region["size"];
            OperandSize sizeEnum;
            if (size == "byte")
            {
                sizeEnum = OperandSize::Byte;
            }
            else if (size == "word")
            {
                sizeEnum = OperandSize::Word;
            }
            else if (size == "long")
            {
                sizeEnum = OperandSize::Long;
            }
            else
            {
                throw std::runtime_error("Unexpected size");
            }

            Range<size_t> range(region["start"], region["end"]);
            allRegions.addDataRegion(DataRegion(range, sizeEnum));
        }
    }
    return;
}

#pragma region DataRegion

DataRegion::DataRegion(Range<size_t> range, OperandSize size) : range(range), size(size)
{
}

#pragma endregion

#pragma region RegionManager

RegionManager::RegionManager()
{
}

/*
 * See if a Data boundary for this address is defined
 * Passed : (1) Pointer to Boundary Class list
 *          (2) Address to check for
 * Returns: Ptr to Boundary definition if found,  NULL if no match.
 * Pure function.
 */
const DataRegion* RegionManager::classHere(size_t address) const
{
    for (auto& region : _dataRegions)
    {
        if (region.range.contains(address))
        {
            return &region;
        }
    }
    return nullptr;
}

#pragma endregion
