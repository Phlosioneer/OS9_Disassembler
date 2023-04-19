
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

#define _MAIN_ /* We will define all variables in one header file, then                                                \
                  define them extern from all other files */

#include "disglobs.h"
#include "main_support.h"
#include "modtypes.h"
#include "textdef.h"
#include <ctype.h>
#include <string.h>

#include "cmdfile.h"
#include "command_items.h"
#include "commonsubs.h"
#include "def68def.h"
#include "dismain.h"
#include "dprint.h"
#include "exit.h"
#include "label.h"
#include "rof.h"

#ifdef _WIN32
#define strcasecmp _stricmp
#endif

#ifdef _OSK
#define strcasecmp strcmp
#endif

/* Some variables that are only used in one or two modules */
int error;
/*static int HdrLen;*/
int CodeEnd;

struct module_header* modHeader = NULL;
int IDataBegin;
int IDataCount;
int HdrEnd;

int AMode;
int NowClass;
int PBytSiz;

static int get_asmcmd(struct parse_state* state);

static const char* DrvrJmps[] = {"Init", "Read", "Write", "GetStat", "SetStat", "Term", "Except", NULL};

static const char* FmanJmps[] = {"Open",  "Create", "Makdir",  "Chgdir",  "Delete",  "Seek",  "Read",
                                 "Write", "Readln", "Writeln", "Getstat", "Setstat", "Close", NULL};

const OPSTRUCTURE* opmains[] = {instr00, instr01, instr02, /* Repeat 3 times for 3 move sizes */
                                instr03, instr04, instr05, instr06, instr07, instr08, instr09, NULL, /* No instr 010 */
                                instr11, instr12, instr13, instr14, NULL};

struct module_header* module_new()
{
    struct module_header* ret = (module_header*)malloc(sizeof(struct module_header));
    if (!ret)
    {
        errexit("OoM");
    }
    memset(ret, 0, sizeof(struct module_header));
    return ret;
}

void module_destroy(struct module_header* module_)
{
    free(module_);
}

// Read the Driver initialization table and set up label names.
// NOT ACTIVELY MAINTAINED.
static void get_drvr_jmps(int mty, FILE* ModFP)
{
    register const char** pt;
    register int jmpdst;
    int jmpbegin = ftell(ModFP);
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
            addlbl('L', jmpdst, *pt);
            sprintf(boundstr, "L W L %x-%lx", jmpbegin, ftell(ModFP) - 1);
        }
        else
        {
            sprintf(boundstr, "L W & %x-%lx", jmpbegin, ftell(ModFP) - 1);
        }

        setupbounds(boundstr);
        jmpbegin = ftell(ModFP);
        ++pt;
    }
}

// Get the module header.  We will do this only in Pass 1.
static int get_modhead(struct options* opt)
{
    /* Get standard (common to all modules) header fields */

    struct module_header* mod = module_new();

    // Need to be careful to avoid sign-extension.
    mod->id = (unsigned short)fread_w(opt->ModFP);
    switch (mod->id)
    {
    case 0x4afc:
        mod->sysRev = fread_w(opt->ModFP);
        mod->size = fread_l(opt->ModFP);
        mod->owner = fread_l(opt->ModFP);
        mod->nameOffset = fread_l(opt->ModFP);
        mod->access = fread_w(opt->ModFP);
        mod->type = fread_b(opt->ModFP);
        mod->lang = fread_b(opt->ModFP);
        mod->attributes = fread_b(opt->ModFP);
        mod->revision = fread_b(opt->ModFP);
        mod->edition = fread_w(opt->ModFP);
        mod->usageOffset = fread_l(opt->ModFP);
        mod->symbolTableOffset = fread_l(opt->ModFP);

        /* We have 14 bytes that are not used */
        if (fseek(opt->ModFP, 14, SEEK_CUR) != 0)
        {
            errexit("Cannot Seek to file location");
        }

        mod->parity = fread_w(opt->ModFP);

        /* Now get any further Mod-type specific headers */
        switch (mod->type)
        {
        case MT_PROGRAM:
        case MT_SYSTEM:
        case MT_TRAPLIB:
        case MT_FILEMAN:
        case MT_DEVDRVR:
            mod->execOffset = fread_l(opt->ModFP);

            /* Add label for Exception Handler, if applicable */
            /* Only for specific Module Types??? */
            mod->exceptionOffset = fread_l(opt->ModFP);
            if (mod->exceptionOffset)
            {
                addlbl('L', mod->exceptionOffset, "");
            }

            /* Add btext */
            /* applicable for only specific Moule Types??? */
            addlbl('L', 0, "btext");

            if ((mod->type != MT_SYSTEM) && (mod->type != MT_FILEMAN))
            {
                mod->memorySize = fread_l(opt->ModFP);

                if (mod->type == MT_TRAPLIB || mod->type == MT_PROGRAM)
                {
                    mod->stackSize = fread_l(opt->ModFP);
                    mod->initDataHeaderOffset = fread_l(opt->ModFP);
                    mod->refTableOffset = fread_l(opt->ModFP);

                    if (mod->type == MT_TRAPLIB)
                    {
                        mod->initRoutineOffset = fread_l(opt->ModFP);
                        mod->terminationRoutineOffset = fread_l(opt->ModFP);
                    }
                }
            }

            HdrEnd = ftell(opt->ModFP);

            if ((mod->type == MT_DEVDRVR) || (mod->type == MT_FILEMAN))
            {
                fseek(opt->ModFP, mod->execOffset, SEEK_SET);
                get_drvr_jmps(mod->type, opt->ModFP);
            }

            if (mod->initDataHeaderOffset)
            {
                // Read the init data header.
                fseek(opt->ModFP, mod->initDataHeaderOffset, SEEK_SET);
                IDataBegin = fread_l(opt->ModFP);
                IDataCount = fread_l(opt->ModFP);
                /* Insure we have an entry for the first Initialized Data */
                addlbl('D', IDataBegin, "");
                CodeEnd = mod->initDataHeaderOffset;
            }
            else
            {
                /* This may be incorrect */
                CodeEnd = mod->size - 3;
            }
        }

        // Check if the file is complete.
        fseek(opt->ModFP, 0, SEEK_END);
        if (ftell(opt->ModFP) < mod->size)
        {
            errexit("\n*** ERROR!  File size < Module Size... Aborting...! ***\n");
        }
        modHeader = mod;

        break;
    case 0xdead:
        module_destroy(mod);
        modHeader = NULL;
        getRofHdr(opt->ModFP, opt);
        break;
    default:
        errexit("Unknown module type");
    }

    return 0;
}

/// <summary>Search a modna struct for the desired value</summary>
/// <returns>Pointer to the desired value, or `nullptr` if missing.</returns>
struct modnam* modnam_find(struct modnam* pt, int desired)
{
    while ((pt->val) && (pt->val != desired))
    {
        ++pt;
    }

    return (pt->val ? pt : NULL);
}

/*
 * Reads a label file and stores label values into label tree if value (or
 * address) is present in tree. Path to file has already been opened and is
 * stored in "inpath".
 *
 * Lines are in the format:
 *      NAME equ ADDR CLASS
 * ADDR can be either decimal, or hex with the prefix $. CLASS is one "D" or "L".
 */
static void RdLblFile(FILE* inpath)
{
    char labelname[30], clas, eq[10], strval[15], *lbegin;
    int address;
    Label* nl;

    while (!feof(inpath))
    {
        char rdbuf[81];

        fgets(rdbuf, 80, inpath);

        lbegin = skipblank(rdbuf);
        if (!lbegin || (*lbegin == '*'))
        {
            continue;
        }

        if (sscanf(rdbuf, "%s %s %s %c", labelname, eq, strval, &clas) == 4)
        {
            clas = toupper(clas);

            if (!strcasecmp(eq, "equ"))
            {
                /* Store address in proper place */

                if (strval[0] == '$') /* if represented in hex */
                    sscanf(&strval[1], "%x", &address);
                else
                {
                    address = atoi(strval);
                }

                nl = findlbl(clas, address);

                if (nl)
                {
                    nl->setName(labelname);
                    nl->setStdName(true);
                }
            }
        }
    }
}

/**
 * Set up all label definitions. Reads in all default label files and then reads
 * any files specified by the '-s' option.
 */
static void GetLabels(struct options* opt) /* Read the labelfiles */
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

    for (x = 0; x < opt->LblFilz; x++)
    {
        register FILE* inpath;

        inpath = build_path(opt->LblFNam[x], BINREAD, opt);
        if (inpath)
        {
            RdLblFile(inpath);
            fclose(inpath);
        }
        else
        {
            fprintf(stderr, "ERROR! cannot open Label File %s for read\n", opt->LblFNam[x]);
        }
    }
}

/*
 * Do a complete single pass through the module. The first pass establishes the
 * addresses of necessary labels. On the second pass, the desired label names
 * have been inserted and printing of the listing and writing of the source file
 * is done, if either or both is desired.
 */
int dopass(int mypass, struct options* opt)
{
    if (Pass == 1)
    {
        if (opt->ModFP)
        {
            fclose(opt->ModFP);
        }
        opt->ModFP = fopen(opt->ModFile, BINREAD);
        if (!opt->ModFP)
        {
            errexit("Cannot open Module file for read");
        }

        PCPos = 0;
        get_modhead(opt);
        PCPos = ftell(opt->ModFP);
        strncpy(defaultLabelClasses, defaultDefaultLabelClasses, AM_MAXMODES);
        if (modHeader)
        {
            addlbl('L', modHeader->execOffset, NULL);

            /* Set Default Addressing Modes according to Module Type */
            if (modHeader->type == MT_PROGRAM)
            {
                // strcpy(DfltLbls, "&&&&&&D&&&&L");
                strncpy(defaultLabelClasses, programDefaultLabelClasses, AM_MAXMODES);
            }
            else if (modHeader->type == MT_DEVDRVR)
            {
                /*  Init/Term:
                     (a1)=Device Dscr
                    Read/Write,Get/SetStat:
                     (a1)=Path Dscr, (a5)=Caller's Register Stack
                    All:
                     (a1)=Path Dscr
                     (a2)=Static Storage, (a4)=Process Dscr, (a6)=System Globals

                   (a1) & (a5) default to Read/Write, etc.  For Init/Term, specify
                   AModes for these with Boundary Defs*/
                // strcpy (DfltLbls, "&ZD&PG&&&&&L");
                strncpy(defaultLabelClasses, driverDefaultLabelClasses, AM_MAXMODES);
            }
        }
        else
        {
            // TODO: The label in a ROF psect is broken in pass 1. This line shouldn't be necessary.
            addlbl('L', 0, NULL);
        }

        GetIRefs(opt);
        do_cmd_file(opt);

        setROFPass();
    }
    else /* Do Pass 2 Setup */
    {
        GetLabels(opt);

        /* We do this here so that we can rename labels
         * to proper names defined in the ROF file
         */
        if (opt->IsROF)
        {
            setROFPass();
            RofLoadInitData();
        }

        WrtEquates(1, opt);
        WrtEquates(0, opt);
        /*showem();*/
        CmdEnt = 0;

        if (opt->IsROF)
        {
            ROFPsect(ROFHd, opt);
            ROFDataPrint(opt);
        }
        else
        {
            PrintPsect(opt);
            OS9DataPrint(opt);
        }
    }

    /* NOTE: This is just a temporary kludge The begin _SHOULD_ be
             the first byte past the end of the header, but until
             we get bounds working, we'll do  this. */
    if (fseek(opt->ModFP, HdrEnd, SEEK_SET) != 0)
    {
        errexit("FIle Seek Error");
    }

    if (opt->IsROF)
    {
        PCPos = 0;
    }
    else
    {
        PCPos = HdrEnd;
    }

    struct parse_state parseState;
    parseState.cpu = opt->cpu;
    parseState.ModFP = opt->ModFP;
    parseState.opt = opt;

    int instrNum = -1;
    while (PCPos < CodeEnd)
    {
        struct data_bounds* bp;

        instrNum += 1;

        memset(&Instruction, 0, sizeof(Instruction));
        CmdEnt = PCPos;

        /* NOTE: The 6809 version did an "if" and it apparently worked,
         *     but we had to do this to get it to work with consecutive bounds.
         */
        for (bp = ClasHere(dbounds, PCPos); bp; bp = ClasHere(dbounds, PCPos))
        {
            NsrtBnds(bp, &parseState);
            CmdEnt = PCPos;
        }

        if (CmdEnt >= CodeEnd) continue;

        if (get_asmcmd(&parseState))
        {
            if (Pass == 2)
            {
                Instruction.comment = get_apcomment('L', CmdEnt);
                PrintLine(pseudcmd, &Instruction, 'L', CmdEnt, PCPos, opt);

                if (opt->PrintAllCode && Instruction.wcount)
                {
                    int count = Instruction.wcount;
                    char codbuf[50];
                    int wpos = 0;
                    /*printf("%6s", "");*/
                    codbuf[0] = '\0';

                    while (count)
                    {
                        char tmpcod[10];

                        sprintf(tmpcod, "%04x ", (unsigned short)Instruction.code[wpos++]);
                        strcat(codbuf, tmpcod);
                        --count;
                    }

                    printXtraBytes(codbuf);
                }
            }
        }
        else
        {
            if (Pass == 2)
            {
                strcpy(Instruction.mnem, "dc.w");
                sprintf(Instruction.params, "$%x", Instruction.cmd_wrd & 0xffff);
                PrintLine(pseudcmd, &Instruction, 'L', CmdEnt, PCPos, opt);
                CmdEnt = PCPos;
            }
        }
    }

    if (Pass == 2)
    {
        WrtEnds(opt);
    }

    return 0;
}

/*
 * noimplemented() - A dummy function which simply returns NULL for instructions
 *       that do not yet have handler functions
 */
int notimplemented(struct cmd_items* ci, int tblno, const OPSTRUCTURE* op, struct parse_state* state)
{
    return 0;
}

static int get_asmcmd(struct parse_state* state)
{
    register const OPSTRUCTURE* optbl;

    int opword;
    int j;

    Instruction.wcount = 0;
    opword = getnext_w(&Instruction, state);
    /* Make adjustments for this being the command word */
    Instruction.cmd_wrd = Instruction.code[0] & 0xffff;
    Instruction.wcount = 0; /* Set it back again */

    /* This may be temporary.  Opword %1111xxxxxxxxxxxx is available
     * for 68030-68040 CPU's, but we are not yet making this available
     */
    if ((opword & 0xf000) == 0xf000) return 0;

    optbl = opmains[(opword >> 12) & 0x0f];
    if (!optbl)
    {
        return 0;
    }

    for (j = 0; j <= MAXINST; j++)
    {
        const OPSTRUCTURE* curop = &optbl[j];

        error = FALSE;

        if (!(curop->name)) break;

        curop = tablematch(opword, curop);

        /* The table must be organized such that the "cpulvl" field
         * is sorted in ascending order.  Therefore, if a "cpulvl"
         * higher than "cpu" is encountered we can abort the search.
         */
        if (curop->cpulvl > state->cpu)
        {
            return 0;
        }

        if (!error)
        {
            if (curop->opfunc(&Instruction, curop->id, curop, state))
            {
                return 1;
            }
            else
            {
                if (ftell(state->ModFP) != RealEnt(state->opt) + 2)
                {
                    fseek(state->ModFP, RealEnt(state->opt) + 2, SEEK_SET);
                    PCPos = CmdEnt + 2;
                    initcmditems(&Instruction);
                }
            }
        }
    }

#if (DEVICE == 68040 || COPROCESSOR == TRUE)
    for (h = 3; h <= MAXCOPROCINST; h++)
    {
        error = FALSE;
        j = fpmatch(start);
        if (!error)
        {
            size = disassembleattempt(start, j);
            if (size != 0) break;
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

/*
 * Reads data for Data Boundary range from input file and places it onto the print
 * buffer (and does any applicable printing if in pass 2).
 */
void MovBytes(struct data_bounds* db, struct parse_state* state)
{
    struct cmd_items Ci;
    char tmps[20];
    unsigned int valu;
    int bmask;
    char xtrabytes[50];
    int cCount = 0, maxLst;
    char* xtrafmt;

    CmdEnt = PCPos;

    /* This may be temporary, and we may set PBytSiz
     * to the appropriate value */
    *xtrabytes = '\0';
    strcpy(Ci.mnem, "dc");
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
        strcat(Ci.mnem, ".b");
        maxLst = 4;
        bmask = 0xff;
        break;
    case 2:
        strcat(Ci.mnem, ".w");
        maxLst = 2;
        bmask = 0xffff;
        break;
    case 4:
        strcat(Ci.mnem, ".l");
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
            valu = fread_b(state->ModFP);
            break;
        case 2:
            valu = fread_w(state->ModFP);
            break;
        case 4:
            valu = fread_l(state->ModFP);
            break;
        default:
            errexit("Unexpected byte size");
        }

        PCPos += db->b_siz;
        ++cCount;

        /*process_label (&Ci, AMode, valu);*/

        LblCalc(tmps, valu, AMode, PCPos - db->b_siz, state->opt->IsROF);

        if (Pass == 2)
        {
            char tmpval[10];

            if (cCount == 0)
            {
                Ci.cmd_wrd = valu & bmask;
            }
            else if (cCount < maxLst)
            {
                Ci.cmd_wrd = ((Ci.cmd_wrd << (PBytSiz * 8)) | (valu & bmask));
            }
            else
            {
                sprintf(tmpval, xtrafmt, valu & bmask);
                strcat(xtrabytes, tmpval);
            }

            ++cCount;

            if (strlen(Ci.params))
            {
                strcat(Ci.params, ",");
            }

            strcat(Ci.params, tmps);

            /* If length of operand string is max, print a line */

            if ((strlen(Ci.params) > 22) || findlbl('L', PCPos))
            {
                PrintLine(pseudcmd, &Ci, 'L', CmdEnt, PCPos, state->opt);

                if (strlen(xtrabytes))
                {
                    printXtraBytes(xtrabytes);
                }

                Ci.params[0] = '\0';
                Ci.cmd_wrd = 0;
                Ci.lblname = NULL;
                CmdEnt = PCPos /* _ PBytSiz*/;
                cCount = 0;
            }
        }

        /*PCPos += PBytSiz;*/
    }

    /* Loop finished.. print any unprinted data */

    if ((Pass == 2) && strlen(Ci.params))
    {
        PrintLine(pseudcmd, &Ci, 'L', CmdEnt, PCPos, state->opt);

        if (strlen(xtrabytes))
        {
            printXtraBytes(xtrabytes);
        }
    }
}

/*
 * Move nb byes fordcb" statement.
 * TODO: Not sure how to trigger this code for testing?
 */
void MovASC(int nb, char aclass, struct parse_state* state)
{
    char oper_tmp[30];
    struct cmd_items Ci;
    int cCount = 0;

    strcpy(Ci.mnem, "dc.b"); /* Default mnemonic to "fcc" */
    CmdEnt = PCPos;
    *oper_tmp = '\0';
    Ci.cmd_wrd = 0;
    Ci.comment = NULL;
    Ci.lblname = "";

    while (nb--)
    {
        register int x;
        char c[6];

        if ((strlen(oper_tmp) > 24) || (strlen(oper_tmp) && findlbl(aclass, PCPos)))
        {
            sprintf(Ci.params, "\"%s\"", oper_tmp);
            PrintLine(pseudcmd, &Ci, 'L', CmdEnt, PCPos, state->opt);
            oper_tmp[0] = '\0';
            CmdEnt = PCPos;
            Ci.lblname = "";
            Ci.cmd_wrd = 0;
            Ci.wcount = 0;
            cCount = 0;
        }

        x = fgetc(state->ModFP);
        ++cCount;
        ++PCPos;

        if (isprint(x) && (x != '"'))
        {
            if (Pass == 2)
            {
                sprintf(c, "%c", x & 0x7f);
                strcat(oper_tmp, c);

                if (cCount < 16)
                {
                    Ci.cmd_wrd = (Ci.cmd_wrd << 8) | (x & 0xff);
                }
            } /* end if (Pass2) */
        }
        else /* then it's a control character */
        {
            if (Pass == 1)
            {
                if ((x & 0x7f) < 33)
                {
                    char lbl[10];
                    sprintf(lbl, "ASC%02x", x);
                    addlbl('^', x & 0xff, lbl);
                }
            }
            else /* Pass 2 */
            {
                /* Print any unprinted ASCII characters */
                if (strlen(oper_tmp))
                {
                    sprintf(Ci.params, "\"%s\"", oper_tmp);
                    PrintLine(pseudcmd, &Ci, aclass, CmdEnt, CmdEnt, state->opt);
                    Ci.params[0] = '\0';
                    Ci.cmd_wrd = 0;
                    Ci.lblname = "";
                    oper_tmp[0] = '\0';
                    cCount = 0;
                    CmdEnt = PCPos - 1; /* We already have the byte */
                }

                if (isprint(x))
                {
                    sprintf(Ci.params, "'%c'", x);
                }
                else
                {
                    sprintf(Ci.params, "$%x", x);
                }

                Ci.cmd_wrd = x;
                PrintLine(pseudcmd, &Ci, aclass, CmdEnt, PCPos, state->opt);
                Ci.lblname = "";
                Ci.params[0] = '\0';
                Ci.cmd_wrd = 0;
                cCount = 0;
                CmdEnt = PCPos;
            }
        }
    } /* end while (nb--) - all chars moved */

    /* Finally clean up any remaining data. */
    if ((Pass == 2) && (strlen(oper_tmp))) /* Clear out any pending string */
    {
        sprintf(Ci.params, "\"%s\"", oper_tmp);
        PrintLine(pseudcmd, &Ci, 'L', CmdEnt, PCPos, state->opt);
        Ci.lblname = "";
        *oper_tmp = '\0';
    }

    CmdEnt = PCPos;
}

/*
 * Insert boundary area
 */
void NsrtBnds(struct data_bounds* bp, struct parse_state* state)
{
    AMode = 0; /* To prevent LblCalc from defining class */
    NowClass = bp->b_class;
    PBytSiz = 1; /* Default to one byte length */

    switch (bp->b_typ)
    {
    case 1: /* Ascii */
        /* Bugfix?  Pc was bp->b_lo...  that setup allowed going past
         * the end if the lower bound was not right. */

        MovASC((bp->b_hi) - PCPos + 1, 'L', state);
        break;       /* bump PC  */
    case 6:          /* Word */
        PBytSiz = 2; /* Takes care of both Word & Long */
        MovBytes(bp, state);
        break;
    case 4:          /* Long */
        PBytSiz = 4; /* Takes care of both Word & Long */
        MovBytes(bp, state);
        break;
    case 2: /* Byte */
    case 5: /* Short */
        MovBytes(bp, state);
        break;
    case 3: /* "C"ode .. not implememted yet */
        break;
    default:
        break;
    }

    NowClass = 0;
}