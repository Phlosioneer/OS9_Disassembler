/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  *
 * dis68.c - The Text Mode Front-End for the OSK disassembler           *
 *                                                                      *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  *
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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */

#include <ctype.h>
#include <string.h>
#ifdef _WIN32
#   include <io.h>
#endif
#include "disglobs.h"
#include "userdef.h"
#include "proto.h"
#include "commonsubs.h"

#ifdef _WIN32
#   define strdup _strdup
#   define access _access
#   define R_OK 4
#endif

extern int LblFilz;              /* Count of Label files specified     */
extern char *LblFNam[]; /* Pointers to the path names for the files */
extern char *CmdFileName;        /* The path for the Command File Name */
extern FILE *CmdFP;
extern int DoingCmds;

/* **********************
 * usage() - Print Help message
 *
 * ***** */

static void
usage()
{
    char *tab = "    ";
    fprintf (stderr, "\nOSKDis: Disassemble an OS9-68K Module\n");
    fprintf (stderr, "  Options:\n");
    fprintf (stderr,
            "%s-a%sPrint All code data (Default: print first 4 bytes)\n",
            tab, tab);
    fprintf (stderr, "%s-c%sSpecify the command file\n\n", tab, tab);
    fprintf (stderr, "%s-m=<x>%sSpecify CPU\n", tab, tab);
    fprintf (stderr, "%s%sx = 0 - 68000 (default)\n", tab, tab);
    fprintf (stderr, "%s%s    8 - 68008\n", tab, tab);
    fprintf (stderr, "%s%s   20 - 68020\n", tab, tab);
    fprintf (stderr, "\n%s-o=<filename>%sWrite an assembler source file\n",
            tab, tab);
    fprintf (stderr,
        "%s-s      Specify a label file (%d allowed)\n", tab, MAX_LBFIL);
    fprintf (stderr,
        "%s-u      print unformatted listing (without line #, headers or blank lines\n", tab);
    fprintf (stderr, "%s-?, -h  Show this help\n", tab);
}

/* **************************************************************** *
 * getoptions() - Parse the arguments list and process them         *
 *        We could have used getopt() in OSK or linux, but it       *
 *        doesn't seem to be available in Windows, so we'll do it   *
 *        the old-fashioned way.                                    *
 * **************************************************************** *
 */
static void getoptions(int argc, char **argv)
{
    register int count;

    for (count = 1; count < argc; count++)
    {
        if (argv[count][0] == '-')
        {    /* It's an option */
            do_opt (&argv[count][1]);
        }
        else
        {
            if (ModFile != NULL)
            {
                /* I think we did handle multiple files in the 6809 version
                   If so, we'll fix that later*/
                errexit("Only One File can be processed");
            }

            ModFile = argv[count];
        }
    }
}

int main(int argc,char **argv)
{

    /* Process command-line options first */

    /*while ((ret = getopt(argc, argv, "abc:d")) != -1)
    {
    }*/
    getoptions(argc, argv);

    /* We must have a file to disassemble */
    if (ModFile == NULL)
        errexit("You must specify a file to disassemble");

    /*ModFile = argv[1];*/
    Pass = 1;
    dopass(argc,argv,1);
    Pass = 2;
    dopass(argc, argv, Pass);

    return 0;
}

/* *************************
 * build_path() - Verify that the path is a valid path.
 *    If the path is not valid, try some alternatives.
 * ***** */

FILE * build_path (char *p, char *faccs)
{
    char tmpnam[100];
    char *c;
    FILE *fp;

    fp = fopen(p, faccs);
    if (fp)
    {
        return fp;
    }

    if (p[0] == '~')
    {
        c = getenv("HOME");
        if (c)   /* Try the HOME env variable */
        {
            /* We will make some assumptions here..
             * We will assume the path is in the form "~/..."*/
            sprintf (tmpnam, "%s%s", c, &p[1]);
            
            fp = fopen(tmpnam, faccs);
            if (fp)
            {
                return fp;
            }
            else
            {
                return NULL;
            }
        }
    }

    if (DefDir)
    {
        sprintf (tmpnam, "%s/%s", DefDir, p);

        fp = fopen(tmpnam, faccs);
        if (fp)
        {
            return fp;
        }
    }

    if (CmdFileName && strlen(CmdFileName))
    {
        char dirpath[256];
        char fname[256];
        int relpath;
#ifdef _WIN32
        char drv[3];
        char ext[256];

        _splitpath(p, drv, dirpath, fname, ext);
        relpath = (strlen(drv) + strlen(dirpath));

        if (relpath == 0)
        {
            _splitpath(CmdFileName, drv, dirpath, fname, ext);
            _makepath(tmpnam, drv, dirpath, p, NULL);
        }
        else
        {
            return NULL;
        }
#else
#endif
        fp = fopen(tmpnam, faccs);
        if (fp)
        {
            return fp;
        }
    }

    return NULL;         /* Everything failed */
}
 

/* **************************************************************** *
 * do_opt() - Searches for match of char pointed to by c and does   *
 *      whatever setup processing is needed.                        *
 *      This is used for both command-line opts and  opts found in  *
 *      the command file.                                           *
 * **************************************************************** */

void do_opt (char *c)
{
    char *pt = c;
    char *AsmFile;
    int v;

    switch (tolower (*(pt++)))
    {
    case 'a':
        PrintAllCode = 1;   /* Print all code words */
        break;
    case 'c':                  /* Specify Command file */
        if (CmdFileName)
        {
            fprintf (stderr, "Command file already defined\n");
            fprintf (stderr, "Ignoring %s\n", pass_eq (pt));
        }
        else
        {
            CmdFileName = pass_eq (pt);

            CmdFP = build_path(CmdFileName, BINREAD);
            if (!CmdFP)
            {
                fprintf (stderr, "*** Failed to open Command file %s***\n",
                        CmdFileName);
                fprintf (stderr,
                        "Continuing without using the Command file\n");
            }
        }

        break;
    case 'm':      /* Target CPU */
        pt = pass_eq(pt);
        
        switch (v = strtol(pt, &pt, 10))
        {
        case 68000:
        case 68008:
        case 68010:
        case 68020:
            cpu = v - 68000;
            break;
        case 0:
        case 8:
        case 10:
        case 20:
            cpu = v;
            break;
        default:
            fprintf (stderr, "Error: %d is not a valid CPU... Ignoring\n", v);
            break;
        }

        break;
    case 'o':                  /* output asm src file */
        AsmFile = pass_eq(pt);

        AsmPath = fopen(AsmFile, BINWRITE);
        if ( ! AsmPath)
        {
            if (strlen(AsmFile) == 0) {
                errexit("Error: no output file path after -o. Are you missing an = after -o? ");
            }
            else
            {
                errexit("Cannot open output file (are you missing an = after -o?)");
            }
        }
        
        WrtSrc = 1;
        break;
    /*case 'x':
        pt = pass_eq(pt);

        switch (toupper(*pt))
        {
            case 'C':
                OSType = OS_Coco;
                DfltLbls = CocoDflt;
                fprintf(stderr, "You are disassembling for coco\n");
                break;
            default:
                fprintf (stderr, "Error, undefined OS type: %s\n", pt);
                exit (1);
        }

        break;*/
    case 'r':           /* File is an ROF file */
        IsROF = 1;
        break;
    case 's':                  /* Label file name       */
        if (LblFilz < MAX_LBFIL)
        {
            pt = pass_eq (pt);

            if (*pt)
            {
                /* In the OS9 version we used build_path here,
                 * but let's try waiting till we read the file
                 */
                if (DoingCmds)
                {
                    LblFNam[LblFilz++] = strdup(pt);
                }
                else
                {
                    LblFNam[LblFilz++] = pt;
                }
            }
        }
        else
        {
            fprintf (stderr, "Max label files allotted -- Ignoring \'%s\'\n",
                     pass_eq (pt));
        }
        break;
    case 'g':                 /* tabs (g-print-capable) */
        /*tabinit ();*/
        break;
    case 'p':                  /* Page width/depth */
        switch (tolower (*(pt++)))
        {
        case 'w':
            PgWidth = atoi (pass_eq (pt));
            break;
        case 'd':
            PgDepth = atoi (pass_eq (pt));
            break;
        default:
            usage ();
            exit (1);
            break;
        }

        break;
    case 'u':                  /* Translate to upper-case */
        IsUnformatted = 1;
        /*UpCase = 1;*/
        break;
    case 'd':
        if ( ! DoingCmds)
        {
            DefDir = pass_eq (pt);
        }
        else
        {
            pt = pass_eq (pt);

            DefDir = strdup(pt);
            if ( ! DefDir)
            {
                fprintf (stderr, "Cannot allocate memory for Defs dirname\n");
                exit (1);
            }
        }

        break;
    /*case 'z':
        dozeros = 1;
        break;*/
    default:                   /* Unknown Option */
        usage ();
        exit (1);
    }
}

/* ***************************************************************************** *
 * errexit() - Exit when an error occurs.  Prints a prompt describing the error  *
 * Passed: A brief string describing the nature of the error.  A return is not   *
 *      required in the prompt string; the subroutine provides one.              *
 * ***************************************************************************** */

void errexit(char *pmpt)
{
    if (errno)
    {
        perror(pmpt);
    }
    else
    {
        fprintf(stderr, "%s\n", pmpt);
    }
    exit(errno ? errno : 1);
}

/* *******************************
 * Exit on File Read error...
 * ******************************* */

void filereadexit()
{
    if (feof(ModFP))
    {
        errexit ("End of file reached prematurely\n");
    }
    else
    {
        errexit ("Error reading file...\nAborting");
    }
}

