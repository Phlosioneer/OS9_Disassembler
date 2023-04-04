
#include <stdio.h>
#include <errno.h>
#include "disglobs.h"

/* ***************************************************************************** *
 * errexit() - Exit when an error occurs.  Prints a prompt describing the error  *
 * Passed: A brief string describing the nature of the error.  A return is not   *
 *      required in the prompt string; the subroutine provides one.              *
 * ***************************************************************************** */

void errexit(char* pmpt)
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
        errexit("End of file reached prematurely\n");
    }
    else
    {
        errexit("Error reading file...\nAborting");
    }
}