
#include "reset.h"

#include "cmdfile.h"
#include "disglobs.h"
#include "dismain.h"
#include "dprint.h"
#include "label.h"
#include "main_support.h"
#include "rof.h"

// Reset all global state. Used between tests.
void reset()
{
    delete labelManager;
    labelManager = new LabelManager();

    // cmdfile.c
    memset(LAdds, 0, 33 * sizeof(void*));
    dbounds = nullptr;

    // dismain.c
    if (modHeader)
    {
        module_destroy(modHeader);
    }
    modHeader = nullptr;
    error = 0;
    CodeEnd = 0;

    // dprint.c
    PrevEnt = 0;
    LinNum = 0;

    // main_support.c
    PsectName = nullptr;
    Pass = 0;
    PCPos = 0;
    CmdEnt = 0;
    ExtBegin = 0;

    // rof.c
    refs_data = nullptr;
    refs_idata = nullptr;
    refs_remote = nullptr;
    refs_iremote = nullptr;
    refs_code = nullptr;
    extrns = nullptr;
    codeRefs_sav = nullptr;
}