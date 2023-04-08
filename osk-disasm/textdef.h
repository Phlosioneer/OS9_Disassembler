
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


#include "commonsubs.h"
#include "dismain.h"
#include "opcode00.h"
#include "opcodes020.h"
#include "command_items.h"

cglobal const SIZETYPES sizefield[];
cglobal const CONDITIONALS typecondition[];
cglobal const EAALLOWED_TYPE EAtype[];

EASPEC EA[2];	/* where SorD will be either TRUE or FALSE and be used to
		   determine which is being used ie. EA[SorD]		*/

cglobal const OPSTRUCTURE instr00[];
cglobal const OPSTRUCTURE instr01[];
cglobal const OPSTRUCTURE instr02[];
cglobal const OPSTRUCTURE instr03[];
cglobal const OPSTRUCTURE instr04[];
cglobal const OPSTRUCTURE instr05[];
cglobal const OPSTRUCTURE instr06[];
cglobal const OPSTRUCTURE instr07[];
cglobal const OPSTRUCTURE instr08[];
cglobal const OPSTRUCTURE instr09[];
cglobal const OPSTRUCTURE instr11[];
cglobal const OPSTRUCTURE instr12[];
cglobal const OPSTRUCTURE instr13[];
cglobal const OPSTRUCTURE instr14[];

/* ****************ADDITIONS*********************** */

/*
these are the predefined symbols for the symbol table. The correspond
to the standard MOTOROLA memory map. To change the startup symbols,
change them here. To add or delete the startup symbols, add or delete
from here and in doinit under main.c .
*/

cglobal const char ROMSYMB[];

/*
these are the miscellanous messages that are needed in different parts
of the program.
*/

cglobal const char PROMPT[];
cglobal const char WHICHREGMSG[];
cglobal const char BRKMSG[];
cglobal const char SYMBMSG[];
cglobal const char UNKNOWNMSG[];
cglobal const char HITKEYMSG[];
cglobal const char MMASHELPMSG[];

/*
these are the ports known by the monitor. To add ports, add them here
*/

cglobal const struct port_element p[];


/* ***************************************************************** */
#endif
