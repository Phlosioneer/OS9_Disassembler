
#include "pch.h"

#include "exit.h"

#include <errno.h>

#include "main_support.h"

/*
 * Exit when an error occurs.  Prints a prompt describing the error
 * Passed: A brief string describing the nature of the error.  A return is not
 *      required in the prompt string; the subroutine provides one.
 */
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
    // exit(errno ? errno : 1);
    throw std::runtime_error(pmpt);
}

/*
 * Exit on File Read error...
 */
void filereadexit()
{
    errexit("Error reading file...\nAborting");
}