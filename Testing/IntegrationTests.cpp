#include "CppUnitTest.h"
#include "IntegrationTestCase.h"

#include "main_support.h"
#include "reset.h"

#define INIT_LIBRARY_FIELD(libFolderStr) const char* _libname = libFolderStr;
#define LIBRARY_TEST_METHOD(fileName) \
	TEST_METHOD(TestFile_ ## fileName) { \
		reset(); \
		IntegrationTestCase test(_libname, #fileName); \
		test.run(); \
	}

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

		// Test all the myriad ways that external and internal references
		// can be combined in expressions.
		TEST_METHOD(RefTestsRoff)
		{
			reset();
			IntegrationTestCase test("reftests_r");

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

	TEST_CLASS(CStandardLibraryTests)
	{
	public:

		INIT_LIBRARY_FIELD("library CLIB");

		LIBRARY_TEST_METHOD(_pkpaths);
		LIBRARY_TEST_METHOD(_utdummy);
		LIBRARY_TEST_METHOD(abs_a);
		LIBRARY_TEST_METHOD(access_a);
		LIBRARY_TEST_METHOD(alarm_a);
		LIBRARY_TEST_METHOD(asctime_c);
		LIBRARY_TEST_METHOD(atof_c);
		LIBRARY_TEST_METHOD(atoi_c);
		LIBRARY_TEST_METHOD(atol_c);
		LIBRARY_TEST_METHOD(atou_c);
		LIBRARY_TEST_METHOD(case_c);
		LIBRARY_TEST_METHOD(cdiv_a);
		LIBRARY_TEST_METHOD(cfinish_a);
		LIBRARY_TEST_METHOD(change_a);
		LIBRARY_TEST_METHOD(chcodes_c);
		LIBRARY_TEST_METHOD(clock_c);
		LIBRARY_TEST_METHOD(cmul_a);
		LIBRARY_TEST_METHOD(color_a);
		LIBRARY_TEST_METHOD(defdrive_c);
		LIBRARY_TEST_METHOD(dev_a);
		LIBRARY_TEST_METHOD(dir_a);
		LIBRARY_TEST_METHOD(direct_c);
		LIBRARY_TEST_METHOD(errmsg_c);
		LIBRARY_TEST_METHOD(events_a);
		LIBRARY_TEST_METHOD(fflush_c);
		LIBRARY_TEST_METHOD(findstr_c);
		LIBRARY_TEST_METHOD(fopen_c);
		LIBRARY_TEST_METHOD(fread_c);
		LIBRARY_TEST_METHOD(frexp_c);
		LIBRARY_TEST_METHOD(fseek_c);
		LIBRARY_TEST_METHOD(fwrite_c);
		LIBRARY_TEST_METHOD(getc_c);
		LIBRARY_TEST_METHOD(getenv_c);
		LIBRARY_TEST_METHOD(gets_c);
		LIBRARY_TEST_METHOD(globals_a);
		LIBRARY_TEST_METHOD(id_a);
		LIBRARY_TEST_METHOD(index_c);
		LIBRARY_TEST_METHOD(initarg_a);
		LIBRARY_TEST_METHOD(intercept_a);
		LIBRARY_TEST_METHOD(io_a);
		LIBRARY_TEST_METHOD(iobinit_c);
		LIBRARY_TEST_METHOD(ldexp_c);
		LIBRARY_TEST_METHOD(mem_a);
		LIBRARY_TEST_METHOD(memchr_c);
		LIBRARY_TEST_METHOD(memcmp_c);
		LIBRARY_TEST_METHOD(memcpy_c);
		LIBRARY_TEST_METHOD(memory_c);
		LIBRARY_TEST_METHOD(memset_a);
		LIBRARY_TEST_METHOD(misc_a);
		LIBRARY_TEST_METHOD(mktemp_c);
		LIBRARY_TEST_METHOD(mod_a);
		LIBRARY_TEST_METHOD(modloadp_c);
		LIBRARY_TEST_METHOD(os9exec_c);
		LIBRARY_TEST_METHOD(pfinits_c);
		LIBRARY_TEST_METHOD(printf_c);
		LIBRARY_TEST_METHOD(process_a);
		LIBRARY_TEST_METHOD(profdummy_a);
		LIBRARY_TEST_METHOD(putc_c);
		LIBRARY_TEST_METHOD(puts_c);
		LIBRARY_TEST_METHOD(qsort_c);
		LIBRARY_TEST_METHOD(scanf_c);
		LIBRARY_TEST_METHOD(setjmp_a);
		LIBRARY_TEST_METHOD(sigmask_a);
		LIBRARY_TEST_METHOD(ss_stat_a);
		LIBRARY_TEST_METHOD(stat_a);
		LIBRARY_TEST_METHOD(strass_c);
		LIBRARY_TEST_METHOD(strings_c);
		LIBRARY_TEST_METHOD(stringsn_c);
		LIBRARY_TEST_METHOD(strtod_c);
		LIBRARY_TEST_METHOD(strtol_c);
		LIBRARY_TEST_METHOD(strtoul_c);
		LIBRARY_TEST_METHOD(syscommon_a);
		LIBRARY_TEST_METHOD(system_c);
		LIBRARY_TEST_METHOD(tidyup_a);
		LIBRARY_TEST_METHOD(time_a);
		LIBRARY_TEST_METHOD(time_c);
		LIBRARY_TEST_METHOD(trigs_c);
	};

	TEST_CLASS(SystemLibraryTests)
	{
	public:
		INIT_LIBRARY_FIELD("library SYS");

		LIBRARY_TEST_METHOD(io);
		LIBRARY_TEST_METHOD(module);
		LIBRARY_TEST_METHOD(oskfuncs);
		LIBRARY_TEST_METHOD(process);
		LIBRARY_TEST_METHOD(sysglob);
	};
}
