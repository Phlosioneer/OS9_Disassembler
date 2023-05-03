/* ************************************************************************ *
 * def68def.c -                                                             *
 *                                                                          *
 * ************************************************************************ *
 *                                                                          *
 * This file is from Motorola's FBug system and is public domain.           *
 *                                                                          *
 * ************************************************************************ */

#include "dismain.h"
#include "userdef.h"

/* ********************************************* */
/* ROUTINE: TABLEMATCH							 */
/* ********************************************* */

const OPSTRUCTURE* tablematch(int opword, const OPSTRUCTURE* entry)
{
    /*extern OPSTRUCTURE syntax1[];*/
    int Bmatch;
    int j, b, c;

    Bmatch = 1;

    for (j = 15; j > 3; j--)
    {
        if (entry->opwordstr[j] != 'x')
        {
            b = (entry->opwordstr[j] == '1' && !(opword & 0x0001));
            c = (entry->opwordstr[j] == '0' && (opword & 0x0001));

            if (b || c)
            {
                Bmatch = 0; /* MATCH FLAG IS SET TO FALSE */
                break;
            }
        }

        opword = opword >> 1;
    }

    if (Bmatch == 0)
    {
        error = TRUE;
    }

    return entry;
}
