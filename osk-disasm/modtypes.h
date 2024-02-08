/* ******************************************************************** *
 * modtypes.h - Definitions for the module types found                  *
 *    in the module header.                                             *
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

#pragma once

#include "pch.h"


/* *************************** *
 * Module Type/Language values *
 * *************************** */

enum ModuleType : uint8_t
{
	MT_Any = 0,
    MT_Program,
    MT_Subroutine,
    MT_MultiModule,
    MT_Data,
	MT_CsdData,

	MT_TrapLibrary = 11,
    MT_System,
    MT_FileManager,
    MT_DeviceDriver,
    MT_DeviceDescriptor
};

/* Module Language values */
enum ModuleLanguage : uint8_t
{
	ML_Any = 0,
    ML_Object,
    ML_ICode
};

inline uint16_t mktypelang(uint8_t type, uint8_t lang)
{
    return (static_cast<uint16_t>(type) << 8) | lang;
}

/* Module Attribute values */
#define MA_REENT 0x80
#define MA_GHOST 0x40
#define MA_SUPER 0x20
