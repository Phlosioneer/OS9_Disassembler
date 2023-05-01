/* ******************************************************************** *
 *                                                                      *
 * This file came from Motorola's FBug program and is in the public     *
 * domain.                                                              *
 *                                                                      *
 * ******************************************************************** */

#ifndef USERDEF_H
#define USERDEF_H
#include "targetsys.h"

typedef struct
{
    char* size;
} SIZETYPES;

typedef struct
{
    char* condition;
} CONDITIONALS;

typedef struct
{
    int allowableEA;
} EAALLOWED_TYPE;

struct opst
{
    char* name;
    short sizestr; /* sizefield[size]   */
    short source;  /* EAtype[source]    */
    short dest;    /* EAtype[source]    */
    char* opwordstr;
    short sizestartbit;
    short sizeendbit;
    int cpulvl;
    int id;
    int (*opfunc)(struct cmd_items*, int, const struct opst*, struct parse_state*);
};

typedef struct opst OPSTRUCTURE;

typedef struct
{
    char* name;
    short sizestr; /* sizefield[size]   */
    short source;  /* EAtype[source]    */
    short dest;    /* EAtype[source]    */
    int id;
} COPROCSTRUCTURE;

#endif
