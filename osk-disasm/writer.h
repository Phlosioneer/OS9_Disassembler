
#ifndef WRITER_H
#define WRITER_H

#include "pch.h"

class Writer;

struct writer_handle
{
    Writer* inner;
};

#ifdef __cplusplus

// This class handles all file reading, to allow integration test hooks.
// It's temporary while I convert the codebase from C to C++.

#include <cstdarg>
#include <cstdio>

class Writer
{
  public:
    Writer();
    virtual ~Writer();

    virtual void close() = 0;
    size_t printf(const char* format, ...);
    virtual size_t vprintf(const char* format, va_list args) = 0;
    virtual bool openedSuccessfully() = 0;
    virtual void flush() = 0;
    virtual void write(const std::string& s);

    inline writer_handle* handle()
    {
        return _handle;
    }

  private:
    writer_handle* _handle;

    // Because of _handle, need to ensure it is always allocated/freed correctly.
    Writer(Writer const&) = delete;
    Writer& operator=(Writer const&) = delete;
    Writer& operator=(Writer&&) = delete;
};

class FileWriter : public Writer
{
  public:
    FileWriter(const char* filename);
    virtual ~FileWriter();

    virtual void close() override;
    virtual size_t vprintf(const char* format, va_list args) override;
    virtual bool openedSuccessfully() override;
    virtual void flush() override;

  private:
    std::FILE* _fp;
};

class StdOutWriter : public Writer
{
  public:
    virtual void close() override;
    virtual size_t vprintf(const char* format, va_list args) override;
    virtual bool openedSuccessfully() override;
    virtual void flush() override;
};

class StringWriter : public Writer
{
  public:
    StringWriter();
    virtual ~StringWriter() = default;

    virtual void close() override;
    virtual size_t vprintf(const char* format, va_list args) override;
    virtual bool openedSuccessfully() override;
    virtual void flush() override;
    virtual void write(const std::string& s) override;

    inline std::string result()
    {
        return _stream.str();
    }

  private:
    std::ostringstream _stream;
    std::unique_ptr<char[]> _buf;
    size_t _bufSize;
};
#endif

// Creates a new writer.
struct writer_handle* file_writer_fopen(const char* name);
struct writer_handle* stdout_writer_open(void);

// Deletes the writer.
void writer_close(struct writer_handle* handle);
int writer_opened_successfully(struct writer_handle* handle);
size_t writer_printf(struct writer_handle* handle, const char* format, ...);
void writer_flush(struct writer_handle* handle);

// extern struct writer_handle* module_writer;
extern struct writer_handle* stdout_writer;

#endif // WRITER_H