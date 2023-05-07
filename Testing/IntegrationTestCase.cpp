
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
	commandFilePath = basePath + "commands.json";
	labelFilePath = basePath + "labels.s";

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

	std::ifstream labelFileExists{ labelFilePath };
	if (!labelFileExists.good()) {
		labelFilePath = "";
	}
}

void IntegrationTestCase::run()
{
	StringWriter moduleOutput;
	StringWriter standardOutput;

	auto opt = new options();
	opt->ModFile = inputFilePath;
	if (!commandFilePath.empty()) {
		opt->CmdFileName = commandFilePath;
	}
	else {
		opt->CmdFileName.clear();
	}
	opt->CmdFP = nullptr;
	opt->asmFile = moduleOutput.handle();
	stdout_writer = standardOutput.handle();

	if (!labelFilePath.empty())
	{
		opt->labelFiles.push_back(labelFilePath);
	}
	readModuleFile(opt);
	dopass(1, opt);
	dopass(2, opt);

	opt->asmFile = nullptr;
	stdout_writer = nullptr;

	delete opt;

	std::string temp2 = standardOutput.result();
	//Logger::WriteMessage(temp2.c_str());
	std::istringstream actualStdOut(temp2);
	assertStreamsEqual(expectedStdOutFile, actualStdOut, "Standard Output");

	std::string temp1 = moduleOutput.result();
	//Logger::WriteMessage(temp1.c_str());
	std::istringstream actualOutputFile(temp1);
	assertStreamsEqual(expectedOutputFile, actualOutputFile, "Output File");
}

void assertStreamsEqual(std::istream& expected, std::istream& actual, const char* file)
{
	std::string expectedLine, actualLine;
	int lineNumber = 0;
	while (true)
	{
		bool hasExpectedLine = (bool)std::getline(expected, expectedLine);
		bool hasActualLine = (bool)std::getline(actual, actualLine);

		if (hasExpectedLine && lineNumber == 0 && expectedLine.size() >= 2) {
			auto message = formatMessage("%s: File is encoded with a utf-16 BOM (Byte Order Mark), likely inserted by a redirect `>` from powershell. Re-encode the file as utf-8 or ascii using notepad++.", file);
			auto encoding = expectedLine.substr(0, 2);
			Assert::AreNotEqual(encoding, std::string("\xEF\xBB"), message.get());
			Assert::AreNotEqual(encoding, std::string("\xFE\xFF"), message.get());
			Assert::AreNotEqual(encoding, std::string("\xFF\xFE"), message.get());
		}

		if (hasExpectedLine && hasActualLine) {
			auto message = formatMessage("%s: Mismatch on line %d", file, lineNumber);
			Assert::AreEqual(expectedLine, actualLine, message.get());
		}
		else if (hasExpectedLine) {
			auto message = formatMessage("%s: Expected string '%s' on line %d, found End of File.",
				file, expectedLine.c_str(), lineNumber);
			Assert::Fail(message.get());
		}
		else if (hasActualLine) {
			auto message = formatMessage("%s: Expected End of File, but found '%s' on line %d.",
				file, actualLine.c_str(), lineNumber);
			Assert::Fail(message.get());
		}
		else {
			// Both streams ended.
			break;
		}
		lineNumber += 1;
	}
}