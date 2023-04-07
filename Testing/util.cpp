
#include "util.h"

#include <cstdarg>
#include <cstdlib>

std::unique_ptr<wchar_t[]> formatMessage(const char* format, ...)
{
	va_list args, args_copy;
	va_start(args, format);
	va_copy(args_copy, args);

	// Compute the needed size, using normal-char-sized sprintf. The
	// swprintf function does not compute the needed size like snprintf
	// does.
	size_t size = vsnprintf(nullptr, 0, format, args_copy);
	size += 1;

	// Allocate a large enough buffer, and do the formatting.
	std::unique_ptr<char[]> buffer{ new char[size + 1] };
	vsnprintf(buffer.get(), size, format, args);

	// Ensure the string is null-terminated.
	buffer[size] = '\0';

	// Allocate a large enough wide-char string.
	std::unique_ptr<wchar_t[]> ret{ new wchar_t[size + 1] };

	// Convert the normal string to a wide string.
	size_t out_wcharsCopied;
	mbstowcs_s(&out_wcharsCopied, ret.get(), size + 1, buffer.get(), size + 1);

	va_end(args);

	return ret;
}