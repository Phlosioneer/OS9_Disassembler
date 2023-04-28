/* ******************************************************************** *
 * structs.h - Define structures that are used with oskdis              *
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

#ifndef HAVE_STRUCTS
#define HAVE_STRUCTS

/*struct extended020 {
};*/

/* Offset 9 (-L00xx) - type stuff ] */

struct offset_tree
{
    char oclas_maj; /* Class to use in offset addressing          */
    int of_maj;     /* The main offset value                      */
    char incl_pc;   /* Flag to include PC offset mode             */
    int add_to;     /* Flag: if set, add to offset, else subtract */
    /*int of_sec;          Secondary offset (0 if none) */
    /*char oclas_sec;      Class of secondary offset */
};

/* Data areas/Label Addressing Modes tree structure */

struct data_bounds
{
    int b_lo,     /* Lower (beginning) boundary address       */
        b_hi,     /* Upper (ending) boundary address          */
        b_siz;    /* Size of one unit in the set              */
    char b_typ;   /* Boundary type for DA's and Lbl Class for AModes */
    char b_class; /* Class for class 'L' and 'S' boundaries          */
    struct offset_tree* dofst;
    struct data_bounds *DLess, *DMore, *DPrev;
};

#endif /*    #define HAVE_STRUCTS */
