/* ************************************************************************ *
 * def68def.c -                                                             *
 *                                                                          *
 * ************************************************************************ *
 *                                                                          *
 * This file is from Motorola's FBug system and is public domain.           *
 *                                                                          *
 * ************************************************************************ */

#include "pch.h"

#include "def68def.h"

#include "dismain.h"
#include "userdef.h"

/* ********************************************* */
/* ROUTINE: TABLEMATCH							 */
/* ********************************************* */

const OPSTRUCTURE* tablematch(int opword, const OPSTRUCTURE* entry)
{
    int j, b, c;

    for (j = 15; j > 3; j--)
    {
        if (entry->opwordstr[j] != 'x')
        {
            b = (entry->opwordstr[j] == '1' && !(opword & 0x0001));
            c = (entry->opwordstr[j] == '0' && (opword & 0x0001));

            if (b || c)
            {
                return nullptr;
            }
        }

        opword = opword >> 1;
    }

    return entry;
}
