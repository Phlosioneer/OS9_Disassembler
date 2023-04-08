
#include "main_support.h"

#include "exit.h"
#include "dismain.h"
#include "writer.h"

int main(int argc, char** argv)
{

    /* Process command-line options first */
    stdout_writer = stdout_writer_open();

    /*while ((ret = getopt(argc, argv, "abc:d")) != -1)
    {
    }*/
    getoptions(argc, argv);

    /* We must have a file to disassemble */
    if (ModFile == NULL)
        errexit("You must specify a file to disassemble");

    /*ModFile = argv[1];*/
    Pass = 1;
    dopass(1);
    Pass = 2;
    dopass(Pass);

    writer_close(stdout_writer);
    if (module_writer)
    {
        writer_close(module_writer);
    }

    return 0;
}