
#include "writer.h"
#include "exit.h"
#include <cstdarg>

//writer_handle* module_writer = nullptr;
writer_handle* stdout_writer = nullptr;

Writer::Writer() : _handle(new writer_handle{ this }) {}

Writer::~Writer()
{
	delete _handle;
}

size_t Writer::printf(const char* format, ...)
{
	va_list args;
	va_start(args, format);

	size_t ret = this->vprintf(format, args);

	va_end(args);
	return ret;
}

FileWriter::FileWriter(char* filename)
{
	_fp = fopen(filename, "wb");
}

FileWriter::~FileWriter()
{
	if (_fp)
	{
		fclose(_fp);
		_fp = nullptr;
	}
}

void FileWriter::close()
{
	if (_fp)
	{
		fflush(_fp);
		fclose(_fp);
		_fp = nullptr;
	}
}

size_t FileWriter::vprintf(const char* format, va_list args)
{
	return std::vfprintf(_fp, format, args);
}

bool FileWriter::openedSuccessfully()
{
	return _fp != nullptr;
}

void FileWriter::flush()
{
	fflush(_fp);
}

void StdOutWriter::close() {}

size_t StdOutWriter::vprintf(const char* format, va_list args)
{
	return std::vprintf(format, args);
}

bool StdOutWriter::openedSuccessfully()
{
	return true;
}

void StdOutWriter::flush()
{
	fflush(stdout);
}

StringWriter::StringWriter() : _bufSize(0), _buf(nullptr) {}

void StringWriter::close() {}

size_t StringWriter::vprintf(const char* format, va_list args)
{
	// Code loosely based on https://stackoverflow.com/a/26221725

	size_t length = std::vsnprintf(nullptr, 0, format, args);
	if (length == 0)
	{
		errexit("Error while getting size of printf");
	}

	if (length + 1 > _bufSize) {
		_bufSize = length + 1;
		std::unique_ptr<char[]> newbuf(new char[_bufSize]);
		_buf.swap(newbuf);
	}
	
	
	std::vsnprintf(_buf.get(), _bufSize, format, args);
	_buf[length] = '\0';

	_stream << _buf;
	
	return length;
}

bool StringWriter::openedSuccessfully()
{
	return true;
}

void StringWriter::flush() {}

extern "C" {
	
	writer_handle* file_writer_fopen(char* name) {
		FileWriter* ret = new FileWriter(name);
		return ret->handle();
	}

	writer_handle* stdout_writer_open(void) {
		StdOutWriter* ret = new StdOutWriter();
		return ret->handle();
	}

	void writer_close(writer_handle* handle) {
		handle->inner->close();
		delete handle->inner;
	}

	int writer_opened_successfully(writer_handle* handle) {
		return (int)handle->inner->openedSuccessfully();
	}

	size_t writer_printf(writer_handle* handle, const char* format, ...) {
		va_list args;
		va_start(args, format);

		size_t ret = handle->inner->vprintf(format, args);

		va_end(args);
		return ret;
	}

	void writer_flush(writer_handle* handle) {
		handle->inner->flush();
	}
}
