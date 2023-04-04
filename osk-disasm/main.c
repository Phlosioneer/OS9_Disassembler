
#include "main_support.h"
#include "disglobs.h"
#include "exit.h"
#include "dismain.h"

int main(int argc, char** argv)
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
    dopass(argc, argv, 1);
    Pass = 2;
    dopass(argc, argv, Pass);

    return 0;
}