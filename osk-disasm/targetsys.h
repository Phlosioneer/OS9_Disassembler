/* ******************************************************************** *
 *                                                                      *
 * This is the easiest place to make change. If you make a change here, *
 * then all the .c files must be recompiled. This can be done with the  *
 * make command and the appropriate makefile.                           *
 *                                                                      *
 * ******************************************************************** *
 *                                                                      *
 * This file came from Motorola's FBug program and is public domain     *
 *                                                                      *
 * ******************************************************************** */

/*
the boolean logic symbols defined for code readability.
*/

#ifndef HAVE_TAERGETSYS
#define HAVE_TAERGETSYS

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

/*
these are the delimiters. Most are selfexpalnitory.
*/

#define BINDEL '%'    /* binary number */
#define OCTDEL '@'    /* octal number */
#define DECDEL '&'    /* decimalnumber */
#define HEXDEL '$'    /* hexadecimal */
#define PLUSDEL '+'   /* the arithmatic plus */
#define MINUSDEL '-'  /* the arithmatic minus */
#define SYMBOLDEL '/' /* start of a symbol in the symbol table */
#define OPTDEL '-'    /* start of an option on a command line */
#define COUNTDEL ':'  /* indicates range uses a count, not address */
#define ADDRDEL ','   /* Used for assembly,change getnum if you change this */
#define TEXTDEL ';'   /* start of a text field */

/*
these mark various breaks in the structures and strings for such
things as commands, register displays, etc.
*/

#define ENDCMD ' ' /* used to show the end of a command */
#define BREAK '='  /* used to request a break in a display */
#define LASTCMD 0  /* ends a structure of indeterminate length */

#define ENDSTR '\0' /* end of a string */
#define LF 10       /* line feed */
#define CR 13       /* carriage return */

/* ******************************************************************


            begining of MPU and processor dependant defines



   ******************************************************************* */
/*
the maximums for displaying o the screen.
*/

#define MAXLINE 80   /* maximum characters on a line on the screen */
#define MAXSCREEN 20 /* maximum lines to display on the screen at once */

#define MAXBR 8       /* number of breakpoints available to user */
#define MAXSYMBOL 20  /* number of symbols in symbol table */
#define MAXSYMBLEN 10 /* maximum length of symbol name */

/*
memory locations, used for memory map purposes.
*/

/* *************************** ASM/DISASM DEFINES ************************ */

/* Defines that determine which 68xxx device the target system uses
   and will determine what device the asm/disasm mimics.  If size
   is a factor then deletions in the textdef.h instruction file
   may be made based on the number of instructions that will be referenced
   the user should define both the DEVICE, EMULATOR and the COPROCESSOR features
   directly below this statement */

/* ********************** */
/* ********************** */
/* ********************** */
/* ********************** */
/* ********************** */
/* ********************** */
/* ********************** */
/* ********************** */
/* ********************** */
/* ********************** */
/* ********************** */
/* ********************** */

/* known devices are 68000,68008,68010,68020,68030,68040
   this determines what version of the asm/disasm
   will be compiled  */

/* NOTE: The 68HC000 should be defined as a 68000 */

/* ********************************************************************* */

/* ********************************************************************* */
/* ********************** MEMORY MAP FOR DEBUGGER *********************** */

#define DUARTALOC 0xffe02000 /* MC68681 duart channel a */
#define DUARTBLOC 0xffe02008 /* MC68681 duart channel b */

#define SRSTART 0x2700 /* status register	*/

#define TERMINAL DUARTALOC /* location of terminal (i.e. screen) */
#define HOST DUARTBLOC     /* location of host computer port */

/* ************************** END MEMMORY MAP ************************** */
/* ********************************************************************* */

#ifndef MAXINST
#define MAXINST 124
#endif

#define MAXCOPROCINST 36

#ifndef MAXREGS
#define MAXREGS 33 /* most registers used by any one device */
#endif
/* ************************************************************************ */

/*
location of program counter, status register and stack pointer in mpu register
list.
*/

#define PC 0
#define SR 1
#define USP 3
#define MSP 4
#define ISP 5
#define VBR 6
#define CACR 7
#define CAAR 8
#define SFC 9
#define DFC 10
#define D0 12
#define A7 28

/* **********	end of hardware and MPU dependant code  *************** */
#endif
