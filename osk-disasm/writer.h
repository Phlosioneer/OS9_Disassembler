
#ifndef READER_H
#define READER_H

#include "externc.h"

#ifdef __cplusplus

// This class handles all file reading, to allow integration test hooks.
// It's temporary while I convert the codebase from C to C++.

#include <cstdio>
#include <cstdarg>
#include <string>
#include <sstream>

#ifdef __cplusplus
class Writer;

struct writer_handle {
	Writer* inner;
};
#else
struct writer_handle {
	void* inner;
};
#endif

class Writer {
public:
	Writer();
	~Writer();

	virtual void close() = 0;
	size_t printf(const char* format, ...);
	virtual size_t vprintf(const char* format, va_list args) = 0;
	virtual bool openedSuccessfully() = 0;
	virtual void flush() = 0;

	inline writer_handle* handle() { return _handle; }

private:
	writer_handle* _handle;

	// Because of _handle, need to ensure it is always allocated/freed correctly.
	Writer(Writer const&) = delete;
	Writer& operator=(Writer const&) = delete;
	Writer& operator=(Writer&&) = delete;
};

class FileWriter : public Writer {
public:
	FileWriter(char* filename);
	~FileWriter();

	virtual void close() override;
	virtual size_t vprintf(const char* format, va_list args) override;
	virtual bool openedSuccessfully() override;
	virtual void flush();

private:
	std::FILE* _fp;
};

class StdOutWriter : public Writer {
public:

	virtual void close() override;
	virtual size_t vprintf(const char* format, va_list args) override;
	virtual bool openedSuccessfully() override;
	virtual void flush();
};

class StringWriter : public Writer {
public:
	StringWriter();

	virtual void close() override;
	virtual size_t vprintf(const char* format, va_list args) override;
	virtual bool openedSuccessfully() override;
	virtual void flush();

	inline std::string result() { return _stream.str(); }

private:
	std::ostringstream _stream;
	std::unique_ptr<char[]> _buf;
	size_t _bufSize;
};
#endif



// Creates a new writer.
cfunc struct writer_handle* file_writer_fopen(char* name);
cfunc struct writer_handle* stdout_writer_open(void);

// Deletes the writer.
cfunc void writer_close(struct writer_handle* handle);
cfunc int writer_opened_successfully(struct writer_handle* handle);
cfunc size_t writer_printf(struct writer_handle* handle, const char* format, ...);
cfunc void writer_flush(struct writer_handle* handle);

cglobal struct writer_handle* module_writer;
cglobal struct writer_handle* stdout_writer;

#endif