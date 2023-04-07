#pragma once

#include <memory>

std::unique_ptr<wchar_t[]> formatMessage(const char* format, ...);
