
#include <sstream>

#include "CppUnitTest.h"

#include "command_items.h"
#include "main_support.h"
#include "dprint.h"
#include "writer.h"
#include "reset.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTests
{
	TEST_CLASS(DPrintUnitTests)
	{
	public:
		/*
		TEST_METHOD(DoAsciiBlockTest)
		{
			reset();

			cmd_items* ci = new cmd_items{};
			const char testBuffer[7] = "Hello!";
			WrtSrc = FALSE;
			IsUnformatted = TRUE;

			StringWriter writer;
			stdout_writer = writer.handle();
			
			const int ret = DoAsciiBlock(ci, testBuffer, 7, 'L');

			//Assert::AreEqual(ci->mnem, "dc.b");
			//Assert::AreEqual(ci->params, "\"Hello!\",0");
			/*std::istringstream output(writer.result());
			std::istringstream 
			std::string actualLine;
			bool hasActualLine = std::getline(output, actualLine);

			Assert::AreEqual(" 00000 0000            dc.b   \"Hello!\"   \n", output.c_str(), L"Wrong output");
			Assert::AreEqual(ret, 7, L"PC advanced by wrong amount");
			* /

			delete ci;
			ci = nullptr;
		}
		*/
	};
}
