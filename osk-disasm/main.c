
#include "main_support.h"

#include "exit.h"
#include "dismain.h"
#include "writer.h"
#include "cmdfile.h"

int main(int argc, char** argv)
{

    /* Process command-line options first */
    stdout_writer = stdout_writer_open();

    /*while ((ret = getopt(argc, argv, "abc:d")) != -1)
    {
    }*/
    struct options* opt = getoptions(argc, argv);

    /* We must have a file to disassemble */
    if (opt->ModFile == NULL)
        errexit("You must specify a file to disassemble");

    /*ModFile = argv[1];*/
    Pass = 1;
    dopass(1, opt);
    Pass = 2;
    dopass(Pass, opt);

    writer_close(stdout_writer);
    options_destroy(opt);

    return 0;
}