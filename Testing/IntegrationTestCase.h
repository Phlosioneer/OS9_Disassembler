#pragma once

#include <string>
#include <fstream>

extern const std::string TEST_CASE_PATH;

class IntegrationTestCase {
public:
	IntegrationTestCase(std::string caseName);
	IntegrationTestCase(std::string folderName, std::string fileName);

	const std::string caseName;
	const std::string folderName;
	const std::string fileName;
	const std::string basePath;

	std::string expectedAsmOutputFilePath;
	std::string expectedStdOutputFilePath;
	// Looks for both "labels.s" and "fileName_labels.s"
	std::string labelFilePath;
	// Looks for "fileName.r", "fileName.os9", and "fileName.module"
	std::string inputFilePath;
	// Looks for "commands.json" and "filename_commands.json"
	std::string commandFilePath;
	// Blank by default
	std::string psectName;
	std::string actualAsmOutputFilePath;
	std::string actualStdOutputFilePath;

	void run();
};

void assertStreamsEqual(std::istream& expected, std::istream& actual, const std::string& prefix);