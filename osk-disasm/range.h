
#pragma once

// Note: A zero-length range (a, a] is considered to be between `a-1` and `a`. That means
// the _end part of the range matters more than the _start part.
template<typename T>
class Range
{
  private:
    T _start;
    T _end;


  public:
    inline Range() noexcept : Range(0, 0)
    {
    }

    inline Range(T _start, T _end) noexcept
        : _start(std::min(_start, _end)), _end(std::max(_start, _end))
    {
    }

    Range(const Range&) = default;
    Range(Range&&) = default;
    Range& operator=(const Range&) = default;
    Range& operator=(Range&&) = default;

    inline T size() const noexcept
    {
        return _end - _start;
    }

    inline bool empty() const noexcept
    {
        return _end == _start;
    }

    inline T start() const noexcept
    {
        return _start;
    }

    inline T end() const noexcept
    {
        return _end;
    }

    inline bool contains(T point) const noexcept
    {
        return _start <= point && point < _end;
    }

    // A zero length range is considered adjacent to any range that contains either
    // _start or _start+1, but not both.
    bool adjacent(const Range& other) const noexcept;

    // A zero length range is only considered to be intersecting another range
    // if that range contains BOTH _start AND _start+1.
    bool intersects(const Range& other) const noexcept;
    
    // TODO: Improve the efficiency of this. There is redundant code in `intersects`.
    inline bool canMerge(const Range& other) const noexcept
    {
        return adjacent(other) || intersects(other);
    }

    bool tryMerge(const Range& other) noexcept;
    inline Range& merge(const Range& other)
    {
        if (!tryMerge(other))
        {
            throw std::runtime_error("Cannot merge disjoint ranges");
        }
        return *this;
    }

    Range tryUnion(const Range& other, bool& success) const noexcept;
    inline Range doUnion(const Range& other) const
    {
        bool success = false;
        Range ret = tryUnion(other, success);
        if (!success)
        {
            throw std::runtime_error("Cannot form union of disjoint ranges");
        }
        return ret;
    }

    Range tryInnerRange(const Range& other, bool& success) const noexcept;
    inline Range innerRange(const Range& other) const
    {
        bool success = false;
        Range ret = tryInnerRange(other, success);
        if (!success)
        {
            throw std::runtime_error("Cannot for inner range of intersects ranges");
        }
        return ret;
    }
    Range outerRange(const Range& other) const noexcept;

    template<typename T2>
    bool operator==(const Range<T2>& other) const noexcept;
};

template<typename T>
bool Range<T>::adjacent(const Range& other) const noexcept
{
    return other._start == _end || other._end == _start;
}

template <typename T>
bool Range<T>::intersects(const Range& other) const noexcept
{
    if (empty())
    {
        return other.contains(_end) && other._start < _end;
    }
    if (other.empty())
    {
        return contains(other._end) && _start < other._end;
    }

    return contains(other._start) || (other.contains(_start));
}

template <typename T>
bool Range<T>::tryMerge(const Range& other) noexcept
{
    if (intersects(other) || adjacent(other))
    {
        _start = std::min(_start, other._start);
        _end = std::max(_end, other._end);
        return true;
    }
    return false;
}

template <typename T>
Range<T> Range<T>::tryUnion(const Range& other, bool& success) const noexcept
{
    if (intersects(other) || adjacent(other))
    {
        success = true;
        return Range(std::min(_start, other._start), std::max(_end, other._end));
    }
    else
    {
        success = false;
        return Range();
    }
}

template <typename T>
Range<T> Range<T>::tryInnerRange(const Range& other, bool& success) const noexcept
{
    T lowestEnd = std::min(_end, other._end);
    T highestStart = std::max(_start, other._start);
    if (lowestEnd <= highestStart)
    {
        success = true;
        return Range(lowestEnd, highestStart);
    }
    else
    {
        success = false;
        return Range();
    }
}

template <typename T>
Range<T> Range<T>::outerRange(const Range& other) const noexcept
{
    return Range(std::min(_start, other._start), std::max(_end, other._end));
}

template <typename T>
template <typename T2>
inline bool Range<T>::operator==(const Range<T2>& other) const noexcept
{
    return _start == other._start && _end == other._end;
}

typedef Range<uint32_t> Range32;