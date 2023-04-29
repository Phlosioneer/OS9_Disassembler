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

//#define _GNU_SOURCE     /* Needed to get isblank() defined */
#include "cmdfile.h"
#include "commonsubs.h"
#include "disglobs.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "label.h"
#include "main_support.h"
#include "structs.h"
#include "userdef.h"
#include <ctype.h>
#include <stdio.h>
#include <string.h>
/*#include "amodes.h"*/

#include <fstream>
#include "nlohmann/json.hpp"

using json = nlohmann::json;

struct data_bounds* dbounds;

static void bdinsert(struct data_bounds* bb);

void do_cmd_file(struct options* opt)
{
    /* We will do our check for a specification for the CmdFile here */
    if (!opt->CmdFileName)
    {
        return;
    }
    opt->CmdFP = fopen(opt->CmdFileName, BINREAD);

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
    for (auto &region : regions)
    {
        auto type = region["type"];
        if (type == "data")
        {
            auto size = region["size"];
            struct data_bounds* bounds = (struct data_bounds*)mem_alloc(sizeof(struct data_bounds));
            memset(bounds, 0, sizeof(struct data_bounds));

            if (size == "byte")
            {
                bounds->b_siz = 1;
                bounds->b_typ = 2; // See switch in NsrtBnds
            }
            else if (size == "word")
            {
                bounds->b_siz = 2;
                bounds->b_typ = 6; // See switch in NsrtBnds
            }
            else if (size == "long")
            {
                bounds->b_siz = 4;
                bounds->b_typ = 4; // See switch in NsrtBnds
            }
            else
            {
                throw std::runtime_error("Unexpected size");
            }

            bounds->b_lo = region["start"];
            bounds->b_hi = region["end"];
            bounds->b_class = '$';

            if (!dbounds)
            { // First entry
                bounds->DPrev = nullptr;
                dbounds = bounds;
            }
            else
            {
                bdinsert(bounds);
            }
        }
    }
    return;
}

/*
 * bdinsert() - inserts an entry into the boundary table
 */
static void bdinsert(struct data_bounds* bb)
{
    register struct data_bounds* npt;
    register int mylo = bb->b_lo, myhi = bb->b_hi;

    npt = dbounds; /*  Start at base       */

    while (1)
    {
        if (myhi < npt->b_lo)
        {
            if (npt->DLess)
            {
                npt = npt->DLess;
                continue;
            }
            else
            {
                bb->DPrev = npt;
                npt->DLess = bb;
                return;
            }
        }
        else
        {
            if (mylo > npt->b_hi)
            {
                if (npt->DMore)
                {
                    npt = npt->DMore;
                    continue;
                }
                else
                {
                    bb->DPrev = npt;
                    npt->DMore = bb;
                    return;
                }
            }
            else
            {
                throw std::runtime_error("Boundary Overlap");
            }
        }
    }
}