
#include "main_support.h"

#include "cmdfile.h"
#include "dismain.h"
#include "exit.h"
#include "writer.h"

int main(int argc, char** argv)
{

    /* Process command-line options first */
    stdout_writer = stdout_writer_open();

    /*while ((ret = getopt(argc, argv, "abc:d")) != -1)
    {
    }*/
    auto opt = getoptions(argc, argv);

    /* We must have a file to disassemble */
    if (opt->ModFile.empty()) errexit("You must specify a file to disassemble");

    dopass(1, opt.get());
    dopass(2, opt.get());

    writer_close(stdout_writer);

    return 0;
}