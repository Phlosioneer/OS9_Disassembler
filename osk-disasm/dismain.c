
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  *
 * dismain.c - The main disassembler routine.  This handles a single    *
 *      pass for the disassembler routine. For each command, it passes  *
 *      off the job of disassembling that command.                      *
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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define _MAIN_  /* We will define all variables in one header file, then
                   define them extern from all other files */

#include <string.h>
#include <ctype.h>
#include "disglobs.h"
#include "textdef.h"
#include "modtypes.h"
#include "main_support.h"

#include "rof.h"
#include "commonsubs.h"
#include "cmdfile.h"
#include "def68def.h"
#include "exit.h"
#include "dismain.h"
#include "dprint.h"
#include "label.h"
#include "command_items.h"

void reflst();
#ifdef _WIN32
#   define strcasecmp _stricmp
#endif

#ifdef _OSK
#   define strcasecmp strcmp
#endif

/* Some variables that are only used in one or two modules */
int LblFilz;
char *LblFNam[MAX_LBFIL];
int error;
/*static int HdrLen;*/
int CodeEnd;

/* Module header variables */
unsigned int M_ID, M_SysRev;
long M_Size, M_Owner, M_Name;
int M_Accs;
char M_Type, M_Lang, M_Attr, M_Revs;
int M_Edit, M_Usage, M_Symbol, M_Parity,
    M_Exec, M_Except, M_Mem, M_Stack, M_IData,
    M_IRefs, M_Init, M_Term;
int IDataBegin;
int IDataCount;
int HdrEnd;   /* The first byte past end of header, usefull for begin of Pass 2 */

int AMode;
int NowClass;
int PBytSiz;

static int get_asmcmd(void);

static const char *DrvrJmps[] = {
    "Init", "Read", "Write", "GetStat", "SetStat", "Term", "Except", NULL
};

static const char *FmanJmps[] = {"Open", "Create", "Makdir", "Chgdir", "Delete", "Seek",
        "Read", "Write", "Readln", "Writeln", "Getstat", "Setstat", "Close", NULL};

/* ***********************
 * get_drvr_jmps()
 *    Read the Driver initialization table and set up
 *    label names.
 */
// NOT ACTIVELY MAINTAINED.
static void get_drvr_jmps(int mty)
{
    register const char **pt;
    register int jmpdst;
    int jmpbegin = ftell (ModFP);
    char boundstr[50];

    if (mty == MT_DEVDRVR)
    {
        pt = DrvrJmps;
    }
    else
    {
        pt = FmanJmps;
    }

    while (*pt)
    {
        jmpdst = fread_w(ModFP);

        if (jmpdst)
        {
            addlbl ('L', jmpdst, *pt);
            sprintf (boundstr, "L W L %x-%lx", jmpbegin, ftell(ModFP) - 1);
        }
        else
        {
            sprintf (boundstr, "L W & %x-%lx", jmpbegin, ftell(ModFP) - 1);
        }

        setupbounds (boundstr);
        jmpbegin = ftell(ModFP);
        ++pt;
    }

}

/* ****************************************************** *
 * Get the module header.  We will do this only in Pass 1 *
 * ****************************************************** */

static int get_modhead()
{
    /* Get standard (common to all modules) header fields */

    M_ID = fread_w(ModFP) & 0xffff;

    M_SysRev = 0;
    M_Size = 0;
    M_Owner = 0;
    M_Name = 0;
    M_Accs = 0;
    M_Type = 0;
    M_Lang = 0;
    M_Attr = 0;
    M_Revs = 0;
    M_Edit = 0;
    M_Usage = 0;
    M_Symbol = 0;
    M_Exec = 0;
    M_Except = 0;
    HdrEnd = 0;
    M_Mem = 0;
    M_Stack = 0;
    M_IData = 0;
    M_IRefs = 0;
    M_Init = 0;
    M_Term = 0;

    switch (M_ID)
    {
    case 0x4afc:
        M_SysRev = fread_w(ModFP);
        M_Size = fread_l( ModFP);
        M_Owner = fread_l(ModFP);
        M_Name = fread_l(ModFP);
        M_Accs = fread_w(ModFP);
        M_Type = fread_b(ModFP);
        M_Lang = fread_b(ModFP);
        M_Attr = fread_b(ModFP);
        M_Revs = fread_b(ModFP);
        M_Edit = fread_w(ModFP);
        M_Usage = fread_l(ModFP);
        M_Symbol = fread_l(ModFP);

        /* We have 14 bytes that are not used */
        if (fseek(ModFP, 14, SEEK_CUR) != 0)
        {
            errexit("Cannot Seek to file location");
        }

        M_Parity = fread_w(ModFP);

        /* Now get any further Mod-type specific headers */

        
        switch (M_Type)
        {
        case MT_PROGRAM:
        case MT_SYSTEM:
        case MT_TRAPLIB:
        case MT_FILEMAN:
        case MT_DEVDRVR:
            M_Exec = fread_l(ModFP);
            
            /* Add label for Exception Handler, if applicable */
            /* Only for specific Module Types??? */
            M_Except = fread_l(ModFP);
            if (M_Except)
            {
                addlbl('L', M_Except, "");
            }

            /* Add btext */
            /* applicable for only specific Moule Types??? */
            addlbl ('L', 0, "btext");

            HdrEnd = ftell(ModFP); /* We'll keep changing it if necessary */

            if ((M_Type != MT_SYSTEM) && (M_Type != MT_FILEMAN))
            {
                M_Mem = fread_l(ModFP);

                if (M_Type != MT_DEVDRVR)
                {
                    M_Stack = fread_l(ModFP);
                    M_IData = fread_l(ModFP);
                    M_IRefs = fread_l( ModFP);

                    if (M_Type == MT_TRAPLIB)
                    {
                        M_Init = fread_l(ModFP);
                        M_Term = fread_l(ModFP);
                    }
                }

                HdrEnd = ftell(ModFP);  /* The final change.. */
            }

            if ((M_Type == MT_DEVDRVR) || (M_Type == MT_FILEMAN))
            {
                fseek (ModFP, M_Exec, SEEK_SET);
                get_drvr_jmps (M_Type);
            }

           if (M_IData)
            {
                fseek (ModFP, M_IData, SEEK_SET);
                IDataBegin = fread_l (ModFP);
                IDataCount = fread_l (ModFP);
                /* Insure we have an entry for the first Initialized Data */
                addlbl ('D', IDataBegin, "");
                CodeEnd = M_IData;
            }
           else
           {
               /* This may be incorrect */
               CodeEnd = M_Size - 3;
           }
        }

        fseek (ModFP, 0, SEEK_END);

        if (ftell(ModFP) < M_Size)
        {
            errexit ("\n*** ERROR!  File size < Module Size... Aborting...! ***\n");
        }

        break;
    case 0xdead:
        getRofHdr(ModFP);
        /*errexit("Disassembly of ROF files is not yet implemented.");*/
        break;
    default:
        errexit("Unknown module type");
    }

    return 0;
}

/*
 * modnam_find() - search a modna struct for the desired value
 * Returns: On Success: Pointer to the desired value
 *          On Failure: NULL
 */

struct modnam * modnam_find (struct modnam *pt, int desired)
{
    while ((pt->val) && (pt->val != desired))
    {
        ++pt;
    }

    return (pt->val ? pt : NULL);
}

/* ******************************************************************** *
 * RdLblFile() - Reads a label file and stores label values into label  *
 *      tree if value (or address) is present in tree                   *
 *      Path to file has already been opened and is stored in "inpath"  *
 *                                                                      *
 *      Lines are in the format:                                        *
 *        NAME equ ADDR CLASS                                           *
 *      ADDR can be either decimal, or hex with the prefix $.           *
 *      CLASS is one "D" or "L"                                         *
 * ******************************************************************** */

static void RdLblFile (FILE *inpath)
{
    char labelname[30],
         clas,
         eq[10],
         strval[15],
        *lbegin;
    int address;
    struct symbol_def *nl;

    while ( ! feof (inpath))
    {
        char rdbuf[81];

        fgets (rdbuf, 80, inpath);

        lbegin = skipblank(rdbuf);
        if ( ! lbegin || (*lbegin == '*'))
        {
            continue;
        }

        if (sscanf (rdbuf, "%s %s %s %c", labelname, eq, strval, &clas) == 4)
        {
            clas = toupper (clas);

            if ( ! strcasecmp (eq, "equ"))
            {
                /* Store address in proper place */

                if (strval[0] == '$')   /* if represented in hex */
                {
                    sscanf (&strval[1], "%x", &address);
                }
                else
                {
                    address = atoi (strval);
                }

                nl = findlbl (clas, address);

                if (nl)
                {
                    label_setName(nl, labelname);
                    label_setStdName(nl, 1);
                }
            }
        }
    }
}

/* ******************************************************** *
 * GetLabels() - Set up all label definitions               *
 *      Reads in all default label files and then reads     *
 *      any files specified by the '-s' option.             *
 * ******************************************************** */

static void GetLabels ()                    /* Read the labelfiles */
{
    register int x;

    /* First, get built-in ascii definitions.  Later, if desired,
     * they can be redefined */

    /*for (x = 0; x < 33; x++)
    {
        if ((nl = FindLbl (ListRoot ('^'), x)))
        {
            strcpy (nl->sname, CtrlCod[x]);
        }
    }

    if ((nl = FindLbl (ListRoot ('^'), 0x7f)))
    {
        strcpy (nl->sname, "del");
    }*/

    /* Next read in the Standard systems names file */

    /*if ((OSType == OS_9) || (OSType == OS_Moto))
    {
        tmpnam = build_path ("sysnames");

        if ( ! (inpath = fopen (tmpnam, "rb")))
            fprintf (stderr, "Error in opening Sysnames file..%s\n",
                              filename);
        else
        {
            RdLblFile ();
            fclose (inpath);
        }
    }*/

    /* Now read in label files specified on the command line */

    for (x = 0; x < LblFilz; x++)
    {
        register FILE *inpath;

        inpath = build_path(LblFNam[x], BINREAD);
        if (inpath)
        {
            RdLblFile (inpath);
            fclose (inpath);
        }
        else
        {
            fprintf (stderr, "ERROR! cannot open Label File %s for read\n",
                     LblFNam[x]);
        }
    }
}

/*
 * dopass() - Do a complete single pass through the module.
 *      The first pass establishes the addresses of necessary labels
 *      On the second pass, the desired label names have been inserted
 *      and printing of the listing and writing of the source file is
 *      done, if either or both is desired.
 */

int dopass(int mypass)
{
    /*int sval = 0;
    int lval = 0;
    int wval = 0;*/

    if (Pass == 1)
    {
        ModFP = fopen(ModFile, BINREAD);
        if (!ModFP)
        {
            errexit("Cannot open Module file for read");
        }

        PCPos = 0;
        get_modhead();
        PCPos = ftell(ModFP);
        /*process_label(&Instruction, 'L', M_Exec);*/
        addlbl ('L', M_Exec, NULL);
        
        /* Set Default Addressing Modes according to Module Type */
        switch (M_Type)
        {
        case MT_PROGRAM:
            //strcpy(DfltLbls, "&&&&&&D&&&&L");
            strcpy(defaultLabelClasses, programDefaultLabelClasses, AM_MAXMODES);
            break;
        case MT_DEVDRVR:
            /*  Init/Term:
                 (a1)=Device Dscr
                Read/Write,Get/SetStat:
                 (a1)=Path Dscr, (a5)=Caller's Register Stack
                All:
                 (a1)=Path Dscr
                 (a2)=Static Storage, (a4)=Process Dscr, (a6)=System Globals

               (a1) & (a5) default to Read/Write, etc.  For Init/Term, specify
               AModes for these with Boundary Defs*/
            //strcpy (DfltLbls, "&ZD&PG&&&&&L");
            strncpy(defaultLabelClasses, driverDefaultLabelClasses, AM_MAXMODES);
            break;
        default:
            strncpy(defaultLabelClasses, defaultDefaultLabelClasses, AM_MAXMODES);
        }

        GetIRefs();
        do_cmd_file();

        setROFPass();
    }
    else   /* Do Pass 2 Setup */
    {
        /*parsetree ('A');*/
        GetLabels();

        /* We do this here so that we can rename labels
         * to proper names defined in the ROF file
         */
        if (IsROF)
        {
            setROFPass();
            RofLoadInitData();
        }

        WrtEquates (1);
        WrtEquates (0);
        /*showem();*/
        CmdEnt = 0;

        if (IsROF)
        {
            ROFPsect(&ROFHd);
            ROFDataPrint();
        }
        else
        {
            PrintPsect();
            OS9DataPrint();
        }
    }

    /* NOTE: This is just a temporary kludge The begin _SHOULD_ be
             the first byte past the end of the header, but until
             we get bounds working, we'll do  this. */
    if (fseek(ModFP, HdrEnd, SEEK_SET) != 0)
    {
        errexit("FIle Seek Error");
    }

    if (IsROF)
    {
        PCPos = 0;
    }
    else
    {
        PCPos = HdrEnd;
    }

    int instrNum = -1;
    while (PCPos < CodeEnd)
    {
        struct data_bounds *bp;

        instrNum += 1;

        memset(&Instruction, 0, sizeof(Instruction));
        CmdEnt = PCPos;

        /* NOTE: The 6809 version did an "if" and it apparently worked,
         *     but we had to do this to get it to work with consecutive bounds.
         */
        for (bp = ClasHere (dbounds, PCPos); bp; bp = ClasHere(dbounds, PCPos))
        {
            NsrtBnds (bp);
            CmdEnt = PCPos;
        }

        if (CmdEnt >= CodeEnd) continue;
       
        if (get_asmcmd())
        {
            if (Pass == 2)
            {
                /*PrintComment('L', CmdEnt, PCPos);*/
                Instruction.comment = get_apcomment ('L', CmdEnt);
                /*list_print (&Instruction, CmdEnt, NULL);*/
                PrintLine (pseudcmd, &Instruction, 'L', CmdEnt, PCPos);

                if (PrintAllCode && Instruction.wcount)
                {
                    int count = Instruction.wcount;
                    char codbuf[50];
                    int wpos = 0;
                    /*printf("%6s", "");*/
                    codbuf[0] = '\0';

                    while (count)
                    {
                        char tmpcod[10];

                        sprintf (tmpcod, "%04x ", (unsigned short)Instruction.code[wpos++]);
                        strcat (codbuf, tmpcod);
                        --count;
/*                        if (count > 1)
                        {
                            PrintAllCodLine(Instruction.code[wpos],
                                    Instruction.code[wpos + 1]);
                            count -= 2;
                            wpos += 2;
                        }
                        else
                        {
                            PrintAllCodL1(Instruction.code[wpos]);
                            --count;
                            ++wpos;
                        }*/
                       /*printf("%04x ", Instruction.code[count] & 0xffff);*/
                    }

                    printXtraBytes (codbuf);
                }
            }
        }
        else
        {
            if (Pass == 2)
            {
                strcpy (Instruction.mnem, "dc.w");
                sprintf (Instruction.params, "$%x",
                        Instruction.cmd_wrd & 0xffff);
                PrintLine (pseudcmd, &Instruction, 'L', CmdEnt, PCPos);
                CmdEnt = PCPos;
                /*list_print (&Instruction, CmdEnt, NULL);*/
            }
        }
    }

    if (Pass == 2)
    {
        WrtEnds();
    }

    /*reflst();*/
    return 0;
}

// Debugging function?
// NOT ACTIVELY MAINTAINED.
int showem()
{
    /*char c = '_';*/
    struct rof_extrn *rf = refs_code;
    /*LABEL_CLASS *l = labelclass(c);*/

    if (!rf)
        fprintf(stderr, "No Code refs found!\n");
    while (rf)
    {
        fprintf (stderr, "%04x: -> (%03x '%c') \"%-14s\" (%s)\n", rf->Ofst, rf->Type,
            rf->dstClass ? rf->dstClass : ' ', rf->Extrn ? rf->EName.nam : label_getName(rf->EName.lbl),
            rf->Extrn ? "Extern" : "Local");
        rf = rf->ENext;
    }

    return 0;
}

/*
 * noimplemented() - A dummy function which simply returns NULL for instructions
 *       that do not yet have handler functions
 */

int notimplemented(struct cmd_items *ci, int tblno, const OPSTRUCTURE *op)
{
    return 0;
}

/*extern OPSTRUCTURE *instr00,*instr01,*instr04,*instr05,*instr06,
       *instr07,*instr08,*instr09,*instr11,*instr12,*instr13,*instr14;*/
const OPSTRUCTURE *opmains[] =
{
    instr00,
    instr01,
    instr02,    /* Repeat 3 times for 3 move sizes */
    instr03,
    instr04,
    instr05,
    instr06,
    instr07,
    instr08,
    instr09,
    NULL,       /* No instr 010 */
    instr11,
    instr12,
    instr13,
    instr14,
    NULL
};

static int get_asmcmd()
{
    /*extern OPSTRUCTURE syntax1[];
    extern COPROCSTRUCTURE syntax2[];*/
    register const OPSTRUCTURE *optbl;

    int opword;
    int j;
    /*int size;*/


    /*size = 0;*/
    Instruction.wcount = 0;
    opword = getnext_w (&Instruction);
    /* Make adjustments for this being the command word */
    Instruction.cmd_wrd = Instruction.code[0] & 0xffff;
    Instruction.wcount = 0; /* Set it back again */

    /* This may be temporary.  Opword %1111xxxxxxxxxxxx is available
     * for 68030-68040 CPU's, but we are not yet making this available
     */
    if ((opword & 0xf000) == 0xf000)
        return 0;
    
    optbl = opmains[(opword >> 12) & 0x0f];
    if (!optbl)
    {
        return 0;
    }

    for (j = 0; j <= MAXINST; j++)
    {
        const OPSTRUCTURE *curop = &optbl[j];

        error = FALSE;

        if (!(curop->name))
            break;

        curop = tablematch (opword, curop);

        /* The table must be organized such that the "cpulvl" field
         * is sorted in ascending order.  Therefore, if a "cpulvl"
         * higher than "cpu" is encountered we can abort the search.
         */
        if (curop->cpulvl > cpu)
        {
            return 0;
        }

        if (!error)
        {
            if (curop->opfunc(&Instruction, curop->id, curop))
            {
                return 1;
            }
            else
            {
                if (ftell(ModFP) != RealEnt() + 2)
                {
                    fseek(ModFP, RealEnt() + 2, SEEK_SET);
                    PCPos = CmdEnt + 2;
                    initcmditems(&Instruction);
                }
            }
        }
    }

#if (DEVICE==68040 || COPROCESSOR==TRUE)
    for (h = 3; h <= MAXCOPROCINST; h++)
    {
        error = FALSE;
        j = fpmatch (start);
        if (!error)
        {
            size = disassembleattempt (start, j);
            if (size != 0)
                break;
        }
    }
#endif
/*    if (size == 0)
    {
        writer_printf(stdout_writer, "\n%c%8x", HEXDEL, start);
        writer_printf(stdout_writer, " %4X\t\t  DC.W", get16 (start));
        writer_printf(stdout_writer, " \t\t?  ");
        return (2);
    }
    else
        return (size);*/

    return 0;
}

/* ******************************************************************** *
 * MovBytes() - Reads data for Data Boundary range from input file and  *
 *          places it onto the print buffer (and does any applicable    *
 *          printing if in pass 2).                                     *
 * ******************************************************************** */

void MovBytes (struct data_bounds *db)
{
    struct cmd_items Ci;
    char tmps[20];
    unsigned int valu;
    int bmask;
    /*char *xFmt[3] = {"$%02x", "$%04x", "$%08x"};*/
    char xtrabytes[50];
    int cCount = 0,
        maxLst;
    char *xtrafmt;

    CmdEnt = PCPos;

    /* This may be temporary, and we may set PBytSiz
     * to the appropriate value */
    *xtrabytes = '\0';
    strcpy (Ci.mnem, "dc");
    Ci.params[0] = '\0';
    Ci.lblname = "";
    Ci.comment = NULL;
    Ci.cmd_wrd = 0;
    PBytSiz = db->b_siz;

    if (PBytSiz < 4)
    {
        xtrafmt = "%02x";
    }
    else
    {
        xtrafmt = "%04x";
    }

    switch (PBytSiz)
    {
    case 1:
        strcat (Ci.mnem, ".b");
        maxLst = 4;
        bmask = 0xff;
        break;
    case 2:
        strcat (Ci.mnem, ".w");
        maxLst = 2;
        bmask = 0xffff;
        break;
    case 4:
        strcat (Ci.mnem, ".l");
        maxLst = 1;
        bmask = 0xffff;
        break;
    default:
        errexit("Unexpected byte size");
    }

    while (PCPos <= db->b_hi)
    {
        /* Init dest buffer to null string for LblCalc concatenation */

        tmps[0] = '\0';

        switch (PBytSiz)
        {
        case 1:
            valu = fread_b(ModFP);
            break;
        case 2:
            valu = fread_w (ModFP);
            break;
        case 4:
            valu = fread_l (ModFP);
            break;
        default:
            errexit("Unexpected byte size");
        }

        PCPos += db->b_siz;
        ++cCount;

        /*process_label (&Ci, AMode, valu);*/


        LblCalc (tmps, valu, AMode, PCPos - db->b_siz);

        if (Pass == 2)
        {
            char tmpval[10];

            if (cCount == 0)
            {
                Ci.cmd_wrd = valu & bmask;
            }
            else if (cCount < maxLst)
            {
                Ci.cmd_wrd =  ((Ci.cmd_wrd << (PBytSiz * 8)) | (valu & bmask));
            }
            else
            {
                sprintf (tmpval, xtrafmt, valu & bmask);
                strcat (xtrabytes, tmpval);
            }

            ++cCount;

            if (strlen(Ci.params))
            {
                strcat (Ci.params, ",");
            }

            strcat (Ci.params, tmps);

            /* If length of operand string is max, print a line */

            if ( (strlen (Ci.params) > 22) || findlbl ('L', PCPos))
            {
                PrintLine(pseudcmd, &Ci, 'L', CmdEnt, PCPos);

                if (strlen(xtrabytes))
                {
                    printXtraBytes (xtrabytes);
                }

                Ci.params[0] = '\0';
                Ci.cmd_wrd = 0;
                Ci.lblname = NULL;
                CmdEnt = PCPos/* _ PBytSiz*/;
                cCount = 0;
            }
        }

        /*PCPos += PBytSiz;*/
    }

    /* Loop finished.. print any unprinted data */

    if ((Pass == 2) && strlen (Ci.params))
    {
        PrintLine (pseudcmd, &Ci, 'L', CmdEnt, PCPos);

        if (strlen(xtrabytes))
        {
            printXtraBytes (xtrabytes);
        }
    }
}


/* ******************************************
 * MovAsc() - Move nb byes fordcb" statement
 */
// TODO: Not sure how to trigger this code for testing?
void MovASC (int nb, char aclass)
{
    char oper_tmp[30];
    struct cmd_items Ci;
    int cCount = 0;

    strcpy (Ci.mnem, "dc.b");         /* Default mnemonic to "fcc" */
    CmdEnt = PCPos;
    *oper_tmp = '\0';
    Ci.cmd_wrd = 0;
    Ci.comment = NULL;
    Ci.lblname = "";

    while (nb--)
    {
        register int x;
        char c[6];

        if ((strlen (oper_tmp) > 24) ||
            (strlen (oper_tmp) && findlbl (aclass, PCPos)))
            /*(strlen (oper_tmp) && findlbl (ListRoot (aclass), PCPos + 1)))*/
        {
            sprintf (Ci.params, "\"%s\"", oper_tmp);
            PrintLine (pseudcmd, &Ci, 'L', CmdEnt, PCPos);
            oper_tmp[0] = '\0';
            CmdEnt = PCPos;
            Ci.lblname = "";
            Ci.cmd_wrd = 0;
            Ci.wcount = 0;
            cCount = 0;
        }

        x = fgetc (ModFP);
        ++cCount;
        ++PCPos;

        if (isprint (x) && (x != '"'))
        {
            if (Pass == 2)
            {
                /*if (strlen (pbuf->instr) < 12)
                {
                    sprintf (c, "%02x ", x);
                    strcat (pbuf->instr, c);
                }*/

                sprintf (c, "%c", x & 0x7f);
                strcat (oper_tmp, c);

                if (cCount < 16)
                {
                    Ci.cmd_wrd = (Ci.cmd_wrd << 8) | (x & 0xff);
                }
            }   /* end if (Pass2) */
        }
        else            /* then it's a control character */
        {
            if (Pass == 1)
            {
                if ((x & 0x7f) < 33)
                {
                    char lbl[10];
                    sprintf (lbl, "ASC%02x", x);
                    addlbl ('^', x & 0xff, lbl);
                }
            }
            else       /* Pass 2 */
            {
                /* Print any unprinted ASCII characters */
                if (strlen (oper_tmp))
                {
                    sprintf (Ci.params, "\"%s\"", oper_tmp);
                    PrintLine (pseudcmd, &Ci, aclass, CmdEnt, CmdEnt);
                    Ci.params[0] = '\0';
                    Ci.cmd_wrd = 0;
                    Ci.lblname = "";
                    oper_tmp[0] = '\0';
                    cCount = 0;
                    CmdEnt = PCPos - 1; /* We already have the byte */
                }

                if (isprint(x))
                {
                    sprintf (Ci.params, "'%c'", x);
                }
                else
                {
                    sprintf (Ci.params, "$%x", x);
                }

                Ci.cmd_wrd = x;
                PrintLine (pseudcmd, &Ci, aclass, CmdEnt, PCPos);
                Ci.lblname = "";
                Ci.params[0] = '\0';
                Ci.cmd_wrd = 0;
                cCount = 0;
                CmdEnt = PCPos;
            }
        }
    }       /* end while (nb--) - all chars moved */

    /* Finally clean up any remaining data. */
    if ((Pass == 2) && (strlen (oper_tmp)) )       /* Clear out any pending string */
    {
        sprintf (Ci.params, "\"%s\"", oper_tmp);
        /*list_print (&Ci, CmdEnt, NULL);*/
        PrintLine (pseudcmd, &Ci, 'L', CmdEnt, PCPos);
        Ci.lblname = "";
        *oper_tmp = '\0';
    }

    CmdEnt = PCPos;
}

/* ********************************* *
 * NsertBnds():	Insert boundary area *
 * ********************************* */

void NsrtBnds (struct data_bounds *bp)
{
    /*memset (pbuf, 0, sizeof (struct printbuf));*/
    AMode = 0;                  /* To prevent LblCalc from defining class */
    NowClass = bp->b_class;
    PBytSiz = 1;                /* Default to one byte length */

    switch (bp->b_typ)
    {
        case 1:                    /* Ascii */
            /* Bugfix?  Pc was bp->b_lo...  that setup allowed going past
             * the end if the lower bound was not right. */

            MovASC ((bp->b_hi) - PCPos + 1, 'L');
            break;                  /* bump PC  */
        case 6:                     /* Word */
            PBytSiz = 2;            /* Takes care of both Word & Long */
            MovBytes(bp);
            break;
        case 4:                     /* Long */
            PBytSiz = 4;            /* Takes care of both Word & Long */
            MovBytes(bp);
            break;
        case 2:                     /* Byte */
        case 5:                     /* Short */
            MovBytes (bp);
            break;
        case 3:                    /* "C"ode .. not implememted yet */
            break;
        default:
            break;
    }

    NowClass = 0;
}

#ifdef DoIsCmd
/* ******************************************************************** *
 * IsCmd() - Checks to see if code pointed to by p is valid code.       *
 *      On entry, we are poised at the first byte of prospective code.  *
 * Returns: pointer to valid lkuptable entry or 0 on fail               *
 * ******************************************************************** */

static struct lkuptbl *
IsCmd (int *fbyte, int *csiz)
{
    struct lkuptbl *T;          /* pointer to appropriate tbl   */
    register int sz;            /* # entries in this table      */
    int c = fgetc (progpath);

    *csiz = 2;

    switch (*fbyte = c)
    {
        case '\x10':
            T = Pre10;
            c = fgetc (progpath);
            *fbyte =(*fbyte <<8) + c;
            sz = sizeof (Pre10) / sizeof (Pre10[0]);
            break;
        case '\x11':
            T = Pre11;
            c = fgetc (progpath);
            *fbyte =(*fbyte <<8) + c;
            sz = sizeof (Pre11) / sizeof (Pre11[0]);
            break;
        default:
            *csiz = 1;
            T = Byte1;
            sz = sizeof (Byte1) / sizeof (struct lkuptbl);
            break;
    }

    while ((T->cod != c))
    {
        if (--sz == 0)
        {
            return 0;
        }

        ++T;
    }

    AMode = T->amode;

    return ((T->cod == c) && (T->t_cpu <= CpuTyp)) ? T : 0;
}

#endif           /* ifdef IsCmd */

