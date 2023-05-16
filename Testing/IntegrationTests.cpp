#include "CppUnitTest.h"
#include "IntegrationTestCase.h"

#include "main_support.h"
#include "reset.h"


using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace IntegrationTests
{
	TEST_CLASS(ModuleIntegrationTests)
	{
		TEST_METHOD(ZeldasAdventureModule)
		{
			reset();
			IntegrationTestCase test("zeldas adventure");
			test.psectName = "cdi_zelda.os9module";
			test.run();
		}

		TEST_METHOD(VSyncModule)
		{
			reset();
			IntegrationTestCase test("cdi_vsync");
			test.psectName = "test.os9";
			test.run();
		}
	};

	TEST_CLASS(RoffIntegrationTests)
	{
	public:
		TEST_METHOD(BpsysFunctionRoff)
		{
			reset();
			IntegrationTestCase test("bpsys function_r");

			test.run();
		}

		TEST_METHOD(BpsysMainRoff)
		{
			reset();
			IntegrationTestCase test("bpsys main_r");

			test.run();
		}

		TEST_METHOD(InitDataZeroCatRoff)
		{
			reset();
			IntegrationTestCase test("init data zerocat_r");
			
			test.run();
		}

		TEST_METHOD(RemoteRoff)
		{
			reset();
			IntegrationTestCase test("remote_r");

			test.run();
		}

		TEST_METHOD(EmptyRoff)
		{
			reset();
			IntegrationTestCase test("empty_r");

			test.run();
		}

		// TODO: Make this a unit test
		TEST_METHOD(PcScaleRoff)
		{
			reset();
			IntegrationTestCase test("pc_scale_r");

			test.run();
		}

		// TODO: Make this a unit test.
		// The first movea.w uses the illegal-but-common size encoding of 0b01,
		// while the second movea.w uses the proper 0b11 encoding.
		TEST_METHOD(MoveaWRoff)
		{
			reset();
			IntegrationTestCase test("movea_w_r");

			test.run();
		}
	};

	TEST_CLASS(StandardLibraryTests)
	{
	public:
		TEST_METHOD(LibraryCLIB)
		{
			const std::vector<std::string> filenames
			{
				"_pkpaths", "_utdummy", "abs_a", "access_a", "alarm_a",
				"asctime_c", "atof_c", "atoi_c", "atol_c", "atou_c",
				"case_c", "cdiv_a", "cfinish_a", "change_a", "chcodes_c",
				"clock_c", "cmul_a", "color_a", "defdrive_c", "dev_a", 
				"dir_a", "direct_c", "errmsg_c", "events_a", "fflush_c",
				"findstr_c", "fopen_c", "fread_c", "frexp_c", "fseek_c",
				"fwrite_c", "getc_c", "getenv_c", "gets_c", "globals_a",
				"id_a", "index_c", "initarg_a", "intercept_a", "io_a",
				"iobinit_c", "ldexp_c", "mem_a", "memchr_c", "memcmp_c",
				"memcpy_c", "memory_c", "memset_a", "misc_a", "mktemp_c",
				"mod_a", "modloadp_c", "os9exec_c", "pfinits_c", "printf_c",
				"process_a", "profdummy_a", "putc_c", "puts_c", "qsort_c",
				"scanf_c", "setjmp_a", "sigmask_a", "ss_stat_a", "stat_a",
				"strass_c", "strings_c", "stringsn_c", "strtod_c", "strtol_c",
				"strtoul_c", "syscommon_a", "system_c", "tidyup_a", "time_a",
				"time_c", "trigs_c"
			};

			for (const auto& name : filenames)
			{
				reset();
				IntegrationTestCase test("library CLIB", name);

				test.run();
			}
		}

		TEST_METHOD(LibrarySYS)
		{
			const std::vector<std::string> filenames
			{
				"io", "module", "oskfuncs", "process", "sysglob"
			};

			for (const auto& name : filenames)
			{
				reset();
				IntegrationTestCase test("library SYS", name);

				test.run();
			}
		}
	};
}
