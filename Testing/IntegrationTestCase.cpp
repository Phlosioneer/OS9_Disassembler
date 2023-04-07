
#include "IntegrationTestCase.h"
#include "CppUnitTest.h"

#include <iostream>
#include <fstream>
#include <sstream>
#include <stdlib.h>

#include "main_support.h"
#include "disglobs.h"
#include "dismain.h"
#include "writer.h"
#include "cmdfile.h"

#include "util.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

// Tests are run from "$(SolutionDir)/x64/Debug".
const std::string TEST_CASE_PATH("../../Testing/testCases/");

IntegrationTestCase::IntegrationTestCase(std::string caseName)
	: caseName(caseName), basePath(TEST_CASE_PATH + caseName + "/"),
	expectedOutputFilePath(basePath + "expected.s"),
	expectedStdOutFilePath(basePath + "expectedStdout.txt"),
	expectedOutputFile(expectedOutputFilePath),
	expectedStdOutFile(expectedStdOutFilePath)
{
	inputFilePath = basePath + "test.module";
	commandFilePath = basePath + "commands.txt";

	std::ifstream moduleExists{ inputFilePath };
	if (!moduleExists.good()) {
		// Try test.r
		inputFilePath = basePath + "test.r";
		moduleExists.open(inputFilePath);
		if (!moduleExists.good()) {
			// Try test.os9
			inputFilePath = basePath + "test.os9";
			moduleExists.open(inputFilePath);
			if (!moduleExists.good()) {
				throw std::exception("File not found. Checked test.module, test.r, test.os9");
			}
		}
	}

	std::ifstream commandFileExits{ commandFilePath };
	if (!commandFileExits.good()) {
		commandFilePath = "";
	}
}

void IntegrationTestCase::run()
{
	StringWriter moduleOutput;
	StringWriter standardOutput;

	// TODO: The three files are copied by going to properties, setting content to YES,
	// and setting the other field to "copy file". This is an awful sysem but it works
	// for now.
	//ModFile = "cdi_zelda.os9module";

	// This is safe, the code never modifies the variable.
	// The only reason it can't be const is because it's global.
	ModFile = (char*)inputFilePath.c_str();
	if (!commandFilePath.empty()) {
		CmdFP = fopen(commandFilePath.c_str(), BINREAD);
	}
	else {
		CmdFP = nullptr;
	}
	module_writer = moduleOutput.handle();
	stdout_writer = standardOutput.handle();
	WrtSrc = 1;

	do_cmd_file();

	Pass = 1;
	dopass(1);
	Pass = 2;
	dopass(Pass);

	module_writer = nullptr;
	stdout_writer = nullptr;

	if (CmdFP) {
		fclose(CmdFP);
	}
	fclose(ModFP);

	//std::ifstream expectedFile;
	//expectedFile.open("../../Testing/testCases/zeldas adventure/expected.s");
	std::istringstream actualStream(moduleOutput.result());
	std::string expectedLine, actualLine;
	int lineNumber = 0;
	while (true)
	{
		bool hasExpectedLine = (bool)std::getline(expectedOutputFile, expectedLine);
		bool hasActualLine = (bool)std::getline(actualStream, actualLine);
		if (hasExpectedLine && hasActualLine) {
			auto message = formatMessage("Mismatch on line %d", lineNumber);
			Assert::AreEqual(expectedLine, actualLine, message.get());
		}
		else if (hasExpectedLine) {
			auto message = formatMessage("Expected string '%s' on line %d, found End of File.", expectedLine.c_str(), lineNumber);
			Assert::Fail(message.get());
		}
		else if (hasActualLine) {
			auto message = formatMessage("Expected End of File, but found '%s' on line %d.", actualLine.c_str(), lineNumber);
			Assert::Fail(message.get());
		}
		else {
			// Both streams ended.
			break;
		}
		lineNumber += 1;
	}
}