
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
    allRegions.clear();

    // dprint.c
    PrevEnt = 0;
    LinNum = 0;

    // rof.c
    refs_data.clear();
    refs_idata.clear();
    refs_remote.clear();
    refs_iremote.clear();
    refs_code.clear();
    extrns.clear();
}