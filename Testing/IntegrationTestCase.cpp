
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

#define REGEN_TEST_CASES false

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

// Tests are run from "$(SolutionDir)/x64/Debug".
const std::string TEST_CASE_PATH("../../Testing/testCases/");

IntegrationTestCase::IntegrationTestCase(std::string caseName)
	: IntegrationTestCase(caseName, "test")
{
}

IntegrationTestCase::IntegrationTestCase(std::string folderName, std::string fileName)
	: caseName(folderName + "::" + fileName),
	folderName(folderName),
	fileName(fileName),
	basePath(TEST_CASE_PATH + folderName + "/"),
	expectedAsmOutputFilePath(basePath + fileName + ".expected.s"),
	expectedStdOutputFilePath(basePath + fileName + ".expected.txt"),
	labelFilePath(basePath + fileName + ".labels.s"),
	inputFilePath(basePath + fileName + ".r"),
	commandFilePath(basePath + fileName + ".commands.json"),
	actualAsmOutputFilePath(basePath + fileName + ".actual.s"),
	actualStdOutputFilePath(basePath + fileName + ".actual.txt"),
	extraErrorsFilePath(basePath + fileName + ".errors.txt"),
	psectName()
{
	std::ifstream moduleExists{ inputFilePath };
	if (!moduleExists.good()) {
		// Try test.module
		inputFilePath = basePath + fileName + ".module";
		moduleExists.open(inputFilePath);
		if (!moduleExists.good()) {
			// Try test.os9
			inputFilePath = basePath + fileName + ".os9";
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
	opt->psectName = psectName;
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

	std::string prefix = "[" + caseName + "] ";

	std::string standardOutputString = standardOutput.result();
	std::string asmOutputString = moduleOutput.result();

	// Write the actual files.
	try {
		std::ofstream actualStdOutputFile(actualStdOutputFilePath);
		if (actualStdOutputFile.good())
		{
			actualStdOutputFile << standardOutputString;
		}
		std::ofstream actualAsmOutputFile(actualAsmOutputFilePath);
		if (actualAsmOutputFile.good())
		{
			actualAsmOutputFile << asmOutputString;
		}
		auto message = prefix + "Actual test output written successfully.\n";
		Logger::WriteMessage(message.c_str());
	}
	catch (std::exception e) {
		std::ostringstream messageBuffer;
		messageBuffer << prefix << "Error while writing .actual files: "
			<< e.what() << "\n";
		auto message = messageBuffer.str();
		Logger::WriteMessage(message.c_str());
	}

	// Check stdout first. It's much easier to track down errors by PC address.
	// Scoped to auto-close the ifstream.
	{
		std::ifstream expectedStdOutputFile(expectedStdOutputFilePath);
		if (expectedStdOutputFile.good() && !REGEN_TEST_CASES)
		{
			//Logger::WriteMessage(temp2.c_str());
			std::istringstream actualStdOut(standardOutputString);
			assertStreamsEqual(expectedStdOutputFile, actualStdOut, prefix + "Standard Output");
			expectedStdOutputFile.close();
		}
		else
		{
			auto message = prefix + "Unable to locate " + expectedStdOutputFilePath + "; generating it.\n";
			Logger::WriteMessage(message.c_str());
			expectedStdOutputFile.close();
			std::ofstream newFile(expectedStdOutputFilePath);
			newFile << standardOutputString;
		}
	}

	// Then check assembly output.
	// Scoped to auto-close the ifstream.
	{
		std::ifstream expectedAsmOutputFile(expectedAsmOutputFilePath);
		if (expectedAsmOutputFile.good() && !REGEN_TEST_CASES)
		{
			//Logger::WriteMessage(temp1.c_str());
			std::istringstream actualOutputFile(asmOutputString);
			assertStreamsEqual(expectedAsmOutputFile, actualOutputFile, prefix + "Output File");
			expectedAsmOutputFile.close();
		}
		else
		{
			auto message = prefix + "Unable to locate" + expectedAsmOutputFilePath + "; generating it.\n";
			Logger::WriteMessage(message.c_str());
			expectedAsmOutputFile.close();
			std::ofstream newFile(expectedAsmOutputFilePath);
			newFile << asmOutputString;
		}
	}
}

void IntegrationTestCase::assertStreamsEqual(std::istream& expected, std::istream& actual, const std::string& prefix)
{
	std::string expectedLine, actualLine;
	int lineNumber = 0;
	std::vector<std::wstring> errors;
	while (true)
	{
		bool hasExpectedLine = (bool)std::getline(expected, expectedLine);
		bool hasActualLine = (bool)std::getline(actual, actualLine);

		if (hasExpectedLine && lineNumber == 0 && expectedLine.size() >= 2) {
			auto message = formatMessage("%s: File is encoded with a utf-16 BOM (Byte Order Mark), likely inserted by a redirect `>` from powershell. Re-encode the file as utf-8 or ascii using notepad++.", prefix);
			auto encoding = expectedLine.substr(0, 2);
			Assert::AreNotEqual(encoding, std::string("\xEF\xBB"), message.get());
			Assert::AreNotEqual(encoding, std::string("\xFE\xFF"), message.get());
			Assert::AreNotEqual(encoding, std::string("\xFF\xFE"), message.get());
		}

		if (hasExpectedLine && hasActualLine) {
			if (expectedLine != actualLine)
			{
				std::wostringstream messageBuf;
				messageBuf << prefix.c_str() << ": Mismatch on line " << lineNumber;
				messageBuf << "\nExpected:<" << expectedLine.c_str();
				messageBuf << "\nActual:  <" << actualLine.c_str();
				errors.push_back(messageBuf.str());
			}
		}
		else if (hasExpectedLine) {
			std::wostringstream messageBuf;
			messageBuf << prefix.c_str() << ": Expected string \"" << expectedLine.c_str();
			messageBuf << "\" on line " << lineNumber << ", but found End of File.";
			errors.push_back(messageBuf.str());

			// Stop looking for more errors.
			break;
		}
		else if (hasActualLine) {
			std::wostringstream messageBuf;
			messageBuf << prefix.c_str() << ": Expected End of File, but found \"";
			messageBuf << actualLine.c_str() << "\" on line " << lineNumber << ".";
			errors.push_back(messageBuf.str());

			// Stop looking for more errors.
			break;
		}
		else {
			// Both streams ended.
			break;
		}
		lineNumber += 1;
	}

	if (!errors.empty())
	{
		std::wofstream extraErrorFile(extraErrorsFilePath);
		bool writtenSuccessfully = true;
		if (extraErrorFile.good())
		{
			for (auto message : errors)
			{
				if (extraErrorFile.good()) {
					extraErrorFile << message << '\n';
				}
				else {
					Logger::WriteMessage(L"Error while writing extra errors to error file.");
					writtenSuccessfully = false;
					break;
				}
			}
		}
		else
		{
			Logger::WriteMessage(L"Error while opening/creating error file");
			writtenSuccessfully = false;
		}

		std::wostringstream mainMessageBuf;
		mainMessageBuf << errors[0];
		if (writtenSuccessfully)
		{
			mainMessageBuf << "\n...And " << (errors.size() - 1) << " other errors written to ";
			mainMessageBuf << extraErrorsFilePath.c_str();
		}
		else
		{
			mainMessageBuf << "\n...And " << (errors.size() - 1) << " other errors. Could not write them to a file.";
		}
		auto mainMessage = mainMessageBuf.str();
		Assert::Fail(mainMessage.c_str());
	}
}