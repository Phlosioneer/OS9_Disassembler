#pragma once

#include "CppUnitTest.h"

#include <memory>

#include "range.h"
#include "range_set.h"

std::unique_ptr<wchar_t[]> formatMessage(const char* format, ...);

template<>
std::wstring Microsoft::VisualStudio::CppUnitTestFramework::ToString(const Range<uint32_t>& value)
{
	std::wostringstream buffer;
	buffer << '(' << value.start() << ", " << value.end() << ']';
	return buffer.str();
}

template<>
std::wstring Microsoft::VisualStudio::CppUnitTestFramework::ToString(const Range<uint8_t>& value)
{
	std::wostringstream buffer;
	buffer << '(' << static_cast<uint32_t>(value.start()) << ", ";
	buffer << static_cast<uint32_t>(value.end()) << ']';
	return buffer.str();
}

template<>
std::wstring Microsoft::VisualStudio::CppUnitTestFramework::ToString(const Range<int8_t>& value)
{
	std::wostringstream buffer;
	buffer << '(' << static_cast<int32_t>(value.start()) << ", ";
	buffer << static_cast<int32_t>(value.end()) << ']';
	return buffer.str();
}

template<>
std::wstring Microsoft::VisualStudio::CppUnitTestFramework::ToString(const RangeSet<uint32_t>& value)
{
	std::wostringstream buffer;
	buffer << '{';
	for (auto it = value.crangeBegin(); it != value.crangeEnd(); it++)
	{
		if (it != value.crangeBegin()) {
			buffer << ", ";
		}
		buffer << Microsoft::VisualStudio::CppUnitTestFramework::ToString(*it);
	}
	buffer << '}';
	return buffer.str();
}