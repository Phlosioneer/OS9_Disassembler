
#ifndef READER_H
#define READER_H

#include <sstream>
#include <stdexcept>
#include <vector>

class BigEndianStream
{
  public:
    inline BigEndianStream(std::vector<char>&& buffer)
        : buffer(std::move(buffer)), _position(0), _prevPosition(SIZE_MAX), _eof(false)
    {
    }

    /* When designing this class, at first I used >> overloads. But it was too
     * hard to keep track of what statements were advancing 2 bytes, and which were
     * advancing 4 bytes. So I switched to a more explicit method.
     */

    template <class T>
    BigEndianStream& readInto(T& value) = delete;

    template <class T>
    T read()
    {
        T ret;
        readInto(ret);
        return ret;
    }

    template <class T>
    inline void readVec(std::vector<T>& outBuffer, size_t length)
    {
        auto tempPrevPos = _position;
        for (size_t i = 0; i < length && !_eof; i++)
        {
            outBuffer.push_back(read<T>());
        }
        _prevPosition = tempPrevPos;
    }

    inline void readRaw(char* outBuffer, size_t length)
    {
        _prevPosition = _position;
        auto end = std::min(buffer.cend(), buffer.cbegin() + (_position + length));
        std::copy(buffer.cbegin() + _position, end, outBuffer);
        _position += length;
    }

    inline void readRaw(std::vector<char>& outVec, size_t length)
    {
        outVec.clear();
        outVec.reserve(buffer.size());
        _prevPosition = _position;
        auto end = std::min(buffer.cend(), buffer.cbegin() + (_position + length));
        std::copy(buffer.cbegin() + _position, end, outVec.begin());
    }

    inline BigEndianStream fork(size_t newStreamSize)
    {
        auto end = std::min(buffer.cend(), buffer.cbegin() + (_position + newStreamSize));
        auto subvec = std::vector<char>(buffer.cbegin() + _position, end);
        return BigEndianStream(std::move(subvec));
    }

    inline operator bool() const
    {
        return _eof;
    }

    inline void seekRelative(int amount)
    {
        _prevPosition = _position;
        if (amount < 0 && abs(amount) > _position)
        {
            _position = 0;
        }
        else
        {
            _position += amount;
        }
        _eof = false;
    }

    inline void seekAbsolute(size_t position)
    {
        _prevPosition = _position;
        _position = position;
        _eof = false;
    }

    inline void reset()
    {
        _position = 0;
        _prevPosition = SIZE_MAX;
        _eof = false;
    }

    inline void undo()
    {
        if (_prevPosition == SIZE_MAX) throw std::runtime_error("Nothing to undo");
        _position = _prevPosition;
        _prevPosition = SIZE_MAX;
        _eof = false;
    }

    inline size_t size() const
    {
        return _position >= buffer.size() ? 0 : buffer.size() - _position;
    }

    inline size_t position() const
    {
        return _position;
    }

    inline bool eof() const
    {
        return _eof;
    }

  private:
    std::vector<char> buffer;
    size_t _position;
    size_t _prevPosition;

    // This is set when trying to read from an empty stream. Out of bounds values
    // are treated as 0.
    bool _eof;

    inline void next_b(uint8_t& value)
    {
        if (_position >= buffer.size())
        {
            _eof = true;
            value = 0;
        }
        else
        {
            value = buffer.at(_position);
            _position++;
        }
    }

    inline void next_w(uint16_t& value)
    {
        uint8_t upper, lower;
        next_b(upper);
        next_b(lower);
        value = ((uint16_t)upper << 8) | lower;
    }

    inline void next_l(uint32_t& value)
    {
        uint16_t upper, lower;
        next_w(upper);
        next_w(lower);
        value = ((uint32_t)upper << 16) | lower;
    }

    // Called before every read operation.
    inline void startRead()
    {
        if (_eof) throw std::runtime_error("Unhandled stream EOF error");
        _prevPosition = _position;
    }

    // Called after every read operation.
    inline void endRead()
    {
    }

  public:
#pragma region readInto specializations
    template <>
    BigEndianStream& readInto<char>(char& value)
    {
        startRead();
        next_b(reinterpret_cast<uint8_t&>(value));
        endRead();
        return *this;
    }

    template <>
    BigEndianStream& readInto<int8_t>(int8_t& value)
    {
        startRead();
        next_b(reinterpret_cast<uint8_t&>(value));
        endRead();
        return *this;
    }

    template <>
    BigEndianStream& readInto<uint8_t>(uint8_t& value)
    {
        startRead();
        next_b(value);
        endRead();
        return *this;
    }

    template <>
    BigEndianStream& readInto<int16_t>(int16_t& value)
    {
        startRead();
        next_w(reinterpret_cast<uint16_t&>(value));
        endRead();
        return *this;
    }

    template <>
    BigEndianStream& readInto<uint16_t>(uint16_t& value)
    {
        startRead();
        next_w(value);
        endRead();
        return *this;
    }

    template <>
    BigEndianStream& readInto<int32_t>(int32_t& value)
    {
        startRead();
        next_l(reinterpret_cast<uint32_t&>(value));
        endRead();
        return *this;
    }

    template <>
    BigEndianStream& readInto<uint32_t>(uint32_t& value)
    {
        startRead();
        next_l(value);
        endRead();
        return *this;
    }

    template <>
    BigEndianStream& readInto<std::string>(std::string& value)
    {
        startRead();
        uint8_t b;
        std::ostringstream stream;
        next_b(b);
        while (!_eof && b != 0)
        {
            stream << (char)b;
            next_b(b);
        }
        value = stream.str();
        endRead();
        return *this;
    }

    template <>
    BigEndianStream& readInto<bool>(bool& value)
    {
        auto temp = read<uint8_t>();
        value = temp != 0;
    }

#pragma endregion
};

#endif // READER_H