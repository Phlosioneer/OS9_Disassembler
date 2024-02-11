#pragma once

#include "pch.h"

#include <algorithm>

#include "range.h"

namespace _range_helpers
{

// Provides a total ordering of *disjoint* ranges.
/* Commented out until I actually need sorting.
template <typename T>
bool compare_starts_sort_predicate(const Range<T>& a, const Range<T>& b) noexcept
{
    return a.start() < b.start();
}
*/

// For use with std::lower_bound. lower_bound will return an iterator `it` such that
// `(it-1).end() <= b < it.end()`.
//
// If `b` is within a range `it`, this algorithm will always return `it`.
// If `b` is not within a range, this algorithm will always return the next `it`.
//
// Not meant to be used directly.
template <typename T>
bool lower_predicate(const Range<T>& a, const T& b) noexcept
{
    return a.end() <= b;
}

// In a container of Range<T>, if `value` is in a range in the container, return an iterator
// pointing to that range. Otherwise, return the next range above `value`. To check for success,
// the returned iterator must be compared against both `container.end()` and `it->contains(value)`.
template <typename T, typename Container>
inline typename Container::const_iterator find_range_containing(const Container& container, const T& value)
{
    return std::lower_bound(container.begin(), container.end(), value, &lower_predicate<T>);
}

// In a container of Range<T>, returns the first `it` where `it->canMerge(range)` might be true.
template <typename T, typename Container>
inline typename Container::const_iterator find_location_for_range(const Container& container, const Range<T>& range)
{
    auto it = std::lower_bound(container.begin(), container.end(), range.start(), &lower_predicate<T>);
    if (it == container.begin())
    {
        return it;
    }
    auto prevIt = it - 1;
    if (prevIt->end() == range.start())
    {
        return prevIt;
    }
    return it;
}

// In a container of Range<T>, returns the first `it` where `it->canMerge(range)` might be true.
template <typename T, typename Container>
inline typename Container::iterator find_location_for_range(Container& container, const Range<T>& range)
{
    auto it = std::lower_bound(container.begin(), container.end(), range.start(), &lower_predicate<T>);
    if (it == container.begin())
    {
        return it;
    }
    auto prevIt = it - 1;
    if (prevIt->end() == range.start())
    {
        return prevIt;
    }
    return it;
}

} // namespace _range_helpers

template<typename T>
class RangeSet
{   
    static_assert(!std::is_same_v<float, T>, "Float ranges not supported yet");
    static_assert(!std::is_same_v<double, T>, "Double ranges not supported yet");
  private:
    std::vector<Range<T>> ranges{};
    size_t _size = 0;

  public:

    typedef typename std::vector<Range<T>>::iterator range_iterator;
    typedef typename std::vector<Range<T>>::const_iterator const_range_iterator;
    typedef bool (*sort_predicate_t)(const Range<T>&, const Range<T>&);
    typedef bool (*lower_predicate_t)(const Range<T>&, const T&);
    typedef bool (*upper_predicate_t)(const T&, const Range<T>&);

    RangeSet() = default;
    RangeSet(const RangeSet&) = default;
    RangeSet(RangeSet&&) = default;
    RangeSet(std::initializer_list<Range<T>> ranges);
    RangeSet& operator=(const RangeSet&) = default;
    RangeSet& operator=(RangeSet&&) = default;
    RangeSet& operator=(std::initializer_list<Range<T>> ranges);

    inline bool empty() const noexcept
    {
        return _size == 0;
    }

    inline size_t size() const noexcept
    {
        return _size;
    }
    
    inline size_t rangeCount() const noexcept
    {
        return ranges.size();
    }

    inline void clear()
    {
        ranges.clear();
        _size = 0;
    }

    bool contains(T point) const;
    bool contains(Range<T> range) const;
    bool intersects(Range<T> range) const;

    inline void insert(T point)
    {
        if (point == std::numeric_limits<T>::max())
        {
            throw std::runtime_error("Cannot represent max value as a range");
        }
        insert(Range<T>{point, point + 1});
    }
    void insert(const Range<T>& range);
    void insert(std::initializer_list<Range<T>> ranges);

    // Write these when I actually need them.
    //void remove(T point);
    //void remove(Range<T> range);

    inline range_iterator rangeBegin()
    {
        return ranges.begin();
    }
    inline range_iterator rangeEnd()
    {
        return ranges.end();
    }
    inline const_range_iterator crangeBegin() const
    {
        return ranges.cbegin();
    }
    inline const_range_iterator crangeEnd() const
    {
        return ranges.cend();
    }

    friend inline bool operator==(const RangeSet& left, const RangeSet& right)
    {
        return left.ranges == right.ranges;
    }
    
    friend inline bool operator!=(const RangeSet& left, const RangeSet& right)
    {
        return !(left == right);
    }
};

template<typename T>
RangeSet<T>::RangeSet(std::initializer_list<Range<T>> ranges) : RangeSet()
{
    insert(ranges);
}

template<typename T>
RangeSet<T>& RangeSet<T>::operator=(std::initializer_list<Range<T>> ranges)
{
    clear();
    insert(ranges);
    return *this;
}

template<typename T>
void RangeSet<T>::insert(std::initializer_list<Range<T>> ranges)
{
    for (auto& range : ranges)
    {
        insert(range);
    }
}

template <typename T>
bool RangeSet<T>::contains(T point) const
{
    auto it = _range_helpers::find_range_containing(ranges, point);
    return it != ranges.cend() && it->contains(point);
}

template <typename T>
bool RangeSet<T>::contains(Range<T> range) const
{
    auto it = _range_helpers::find_range_containing(ranges, range.start());
    return it != ranges.cend() && it->contains(range);
}

template<typename T>
bool RangeSet<T>::intersects(Range<T> range) const
{
    auto lower = _range_helpers::find_location_for_range(ranges, range);
    if (lower == ranges.cend())
    {
        return false;
    }

    for (auto it = lower; it != ranges.cend() && it->start() < range.end(); it++)
    {
        if (it->intersects(range))
        {
            return true;
        }
    }

    return false;
}

template<typename T>
void RangeSet<T>::insert(const Range<T>& range)
{
    if (range.empty())
    {
        return;
    }

    // `it` is the first range where `canMerge` could possibly return true.
    auto it = _range_helpers::find_location_for_range(ranges, range);
    if (it == ranges.end())
    {
        ranges.push_back(range);
        return;
    }

    // Need to save the range's old size before merging. Calculating the number of actual
    // new elements after a merge is hard. Instead, we treat merges as if we removed them
    // from the set first, then merged, then re-added them to the set.
    size_t removedSize = it->size();
    if (!it->tryMerge(range))
    {
        // It's not part of this range, but it might belong right before it.
        if (range.start() < it->start())
        {
            // No need to check any other merges.
            ranges.insert(it, range);
            _size += range.size();
            return;
        }

        // The range definitely doesn't belong at index `it`, so move to the next slot.
        it += 1;

        // One last chance to avoid insertion: try to merge with the range above.
        if (it != ranges.end())
        {
            removedSize = it->size();
        }
        if (it == ranges.end() || !it->tryMerge(range))
        {
            // Must insert/append, and we don't need to evaluate any other possible merges.
            ranges.insert(it, range);
            _size += range.size();
            return;
        }
    }
    
    // Merged successfully with the range at `it`. Try to merge ranges above until we
    // can't merge anymore.
    auto next = it + 1;
    for (; next != ranges.end(); next++)
    {
        if (!it->tryMerge(*next))
        {
            break;
        }
        removedSize += next->size();
    }

    // Erase all the merged ranges. `next` points to the last range NOT merged, or to
    // `ranges.end()`.
    ranges.erase(it + 1, next);

    // Re-add all affected merges to the size calculation. Note that `it` was not
    // invalidated by the `erase` above, because it's before the first element of
    // the erase range.
    _size += it->size() - removedSize;
}