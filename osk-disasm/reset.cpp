
#include "reset.h"

#include "cmdfile.h"
#include "label.h"
#include "dismain.h"
#include "disglobs.h"
#include "main_support.h"
#include "rof.h"
#include "dprint.h"

// Reset all global state. Used between tests.
void reset()
{
	delete labelManager;
	labelManager = new LabelManager();

	// cmdfile.c
	CmdFileName = nullptr;
	CmdFP = nullptr;
	DoingCmds = 0;
	memset(LAdds, 0, 33 * sizeof(void*));
	dbounds = nullptr;

	// dismain.c
	LblFilz = 0;
	memset(LblFNam, 0, MAX_LBFIL * sizeof(void*));
	error = 0;
	CodeEnd = 0;

	// dprint.c
	PrevEnt = 0;
	LinNum = 0;
	PgWidth = 80;

	// main_support.c
	PsectName = nullptr;
	cpu = 0;
	PrintAllCode = 0;
	Pass = 0;
	ModFile = nullptr;
	ModFP = nullptr;
	PCPos = 0;
	CmdEnt = 0;
	ExtBegin = 0;
	DefDir = nullptr;

	// rof.c
	refs_data = nullptr;
	refs_idata = nullptr;
	refs_remote = nullptr;
	refs_iremote = nullptr;
	refs_code = nullptr;
	extrns = nullptr;
	codeRefs_sav = nullptr;
	IsROF = FALSE;
}