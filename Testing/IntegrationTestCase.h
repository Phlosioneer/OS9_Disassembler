#pragma once

#include <string>
#include <fstream>

extern const std::string TEST_CASE_PATH;

class IntegrationTestCase {
public:
	IntegrationTestCase(std::string caseName);

	const std::string caseName;
	const std::string basePath;
	const std::string expectedOutputFilePath;
	const std::string expectedStdOutFilePath;
	std::string inputFilePath;
	std::string commandFilePath;
	std::ifstream expectedOutputFile;
	std::ifstream expectedStdOutFile;

	void run();
};

void assertStreamsEqual(std::istream& expected, std::istream& actual, const char* file);