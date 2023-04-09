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
			PsectName = "cdi_zelda.os9module";
			test.run();
		}

		TEST_METHOD(VSyncModule)
		{
			reset();
			IntegrationTestCase test("cdi_vsync");
			PsectName = "test.os9";

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
	};
}
