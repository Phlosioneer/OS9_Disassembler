#include "CppUnitTest.h"
#include "IntegrationTestCase.h"

#include "main_support.h"


using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace IntegrationTests
{
	TEST_CLASS(Testing)
	{
	public:
		TEST_METHOD(ZeldasAdventureModule)
		{
			IntegrationTestCase test("zeldas adventure");
			PsectName = "cdi_zelda.os9module";
			test.run();
		}

		TEST_METHOD(FunctionRoff)
		{
			IntegrationTestCase test("function_r");

			test.run();
		}
	};
}
