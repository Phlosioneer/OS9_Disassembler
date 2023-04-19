
/* ******************************************************************** *
 * This is a file for defining strings used by the monitor. If you      *
 * want to change the prompt, an error message, etc. this is the        *
 * place you will find it.                                              *
 * Note, if a new string is added, then userdef's extern statement      *
 * must be changed for the commands to recognize it.                    *
 *                                                                      *
 * ******************************************************************** *
 *                                                                      *
 * This file came from Motorola's FBug and is in the public domain      *
 *                                                                      *
 * ******************************************************************** */

#ifndef HAVE_TEXTDEF
#define HAVE_TEXTDEF
/*
userdef.h contains the define fields. It will be included at the start
of every command, general, print, getline,main, and assembley routine.
*/

#include "userdef.h"

/*
 * proto.h includes defs for the jump routines in the tables
 */

#include "command_items.h"
#include "commonsubs.h"
#include "dismain.h"
#include "opcode00.h"
#include "opcodes020.h"

extern const SIZETYPES sizefield[];
extern const CONDITIONALS typecondition[];
extern const EAALLOWED_TYPE EAtype[];

extern EASPEC EA[2];

extern const OPSTRUCTURE instr00[];
extern const OPSTRUCTURE instr01[];
extern const OPSTRUCTURE instr02[];
extern const OPSTRUCTURE instr03[];
extern const OPSTRUCTURE instr04[];
extern const OPSTRUCTURE instr05[];
extern const OPSTRUCTURE instr06[];
extern const OPSTRUCTURE instr07[];
extern const OPSTRUCTURE instr08[];
extern const OPSTRUCTURE instr09[];
extern const OPSTRUCTURE instr11[];
extern const OPSTRUCTURE instr12[];
extern const OPSTRUCTURE instr13[];
extern const OPSTRUCTURE instr14[];

/* ****************ADDITIONS*********************** */

/*
these are the predefined symbols for the symbol table. The correspond
to the standard MOTOROLA memory map. To change the startup symbols,
change them here. To add or delete the startup symbols, add or delete
from here and in doinit under main.c .
*/

extern const char ROMSYMB[];

/*
these are the miscellanous messages that are needed in different parts
of the program.
*/

extern const char PROMPT[];
extern const char WHICHREGMSG[];
extern const char BRKMSG[];
extern const char SYMBMSG[];
extern const char UNKNOWNMSG[];
extern const char HITKEYMSG[];
extern const char MMASHELPMSG[];

/*
these are the ports known by the monitor. To add ports, add them here
*/

extern const struct port_element p[];

/* ***************************************************************** */
#endif
