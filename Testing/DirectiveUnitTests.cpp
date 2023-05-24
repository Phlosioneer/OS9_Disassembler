
#include <sstream>

#include "CppUnitTest.h"
#include "CppUnitTestAssert.h"

#include "writer.h"
#include "rof.h"
#include "dprint.h"
#include "reset.h"
#include "main_support.h"
#include "modtypes.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTests
{
	TEST_CLASS(DirectiveUnitTests)
	{
	public:
		~DirectiveUnitTests()
		{
			opt->asmFile = nullptr;
		}

		std::unique_ptr<StringWriter> moduleOutput = nullptr;
		std::unique_ptr<StringWriter> standardOutput = nullptr;
		std::unique_ptr<options> opt = nullptr;

		TEST_METHOD_INITIALIZE(init)
		{
			reset();
			moduleOutput = std::make_unique<StringWriter>();
			standardOutput = std::make_unique<StringWriter>();
			opt = std::make_unique<options>();
			opt->asmFile = moduleOutput->handle();
			labelManager.clear();

			stdout_writer = standardOutput->handle();
		}

		TEST_METHOD(modulePsectTest)
		{
			opt->IsROF = false;
			opt->psectName = "testName";
			opt->modHeader = std::make_unique<module_header>();
			opt->modHeader->type = MT_PROGRAM;
			opt->modHeader->lang = ML_OBJECT;
			opt->modHeader->attributes = MA_REENT;
			opt->modHeader->revision = 9;
			opt->modHeader->edition = 5;
			opt->modHeader->execOffset = 30;
			opt->modHeader->stackSize = 666;
			opt->modHeader->exceptionOffset = -1;
			labelManager.addLabel(&CODE_SPACE, 30, "entry");

			PrintPsect(opt.get(), true);

			std::string expected = "\nPrgrm set $01\n";
			expected += "Objct set $01\n";
			expected += "ReEnt set $80\n\n";
			expected += " psect testName_a,(Prgrm<<8)|Objct,(ReEnt<<8)|9,5,666,entry\n\n";

			Assert::AreEqual(expected, moduleOutput->result());
		}
	};
}