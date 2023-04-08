#include "CppUnitTest.h"
#include "IntegrationTestCase.h"

#include "main_support.h"
#include "reset.h"


using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace IntegrationTests
{
	TEST_CLASS(Testing)
	{
	public:
		TEST_METHOD(ZeldasAdventureModule)
		{
			reset();
			IntegrationTestCase test("zeldas adventure");
			PsectName = "cdi_zelda.os9module";
			test.run();
		}

		TEST_METHOD(FunctionRoff)
		{
			reset();
			IntegrationTestCase test("function_r");

			test.run();
		}
	};
}
