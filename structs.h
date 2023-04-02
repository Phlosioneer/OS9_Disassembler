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
#   define HAVE_STRUCTS

typedef struct cmd_items {
    int cmd_wrd;        /* The single effective address word (the command) */
    char *lblname;
    char mnem[50];
    short code[10];
    int wcount;         /* The count of words in the instrct/.(except sea) */
    char opcode[200];   /* Possibly ovesized, but just to be safe */
    char *comment;     /* Inline comment - NULL if none */
    /*struct extWbrief extend;*/   /* The extended command (if present) */
} CMD_ITEMS;


/*struct extended020 {
};*/


/* Offset 9 (-L00xx) - type stuff ] */

struct offset_tree {
    char oclas_maj;        /* Class to use in offset addressing          */
    int  of_maj;           /* The main offset value                      */
    char incl_pc;          /* Flag to include PC offset mode             */
    int add_to;            /* Flag: if set, add to offset, else subtract */
    /*int of_sec;          Secondary offset (0 if none) */
    /*char oclas_sec;      Class of secondary offset */
};

/* Data areas/Label Addressing Modes tree structure */

struct data_bounds {
    int  b_lo,         /* Lower (beginning) boundary address       */
         b_hi,         /* Upper (ending) boundary address          */
         b_siz;        /* Size of one unit in the set              */
    char b_typ;        /* Boundary type for DA's and Lbl Class for AModes */
    char b_class;      /* Class for class 'L' and 'S' boundaries          */
    struct offset_tree *dofst;
    struct data_bounds *DLess,
                        *DMore,
                        *DPrev;
};



/* ******************************************** *
 * xtndcmnt structures                          *
 * These are comments that are appended to the  *
 * end of the assembly line                     *
 * ******************************************** */

struct append_comment {
    int adrs;
    struct append_comment *apLeft;
    struct append_comment *apRight;
    char *CmPtr;
};

/* ************************************ *
 * Stand-alone Comment structures       *
 * ************************************ */

/* Single line of a comment */
struct comment_line {
    struct comment_line *nextline;
    char *ctxt;
};

/* Main tree */

struct comment_tree {
    int adrs;
    struct comment_tree *cmtUp;
    struct comment_tree *cmtLeft;
    struct comment_tree *cmtRight;
    struct comment_line *commts;
};


#endif             /*    #define HAVE_STRUCTS */


