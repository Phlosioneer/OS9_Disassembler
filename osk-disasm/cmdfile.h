
#ifndef CMDFILE_H
#define CMDFILE_H

#include <stdio.h>
#include <vector>

class Range
{
  public:
    Range(size_t start, size_t end);

    inline bool contains(size_t address) const
    {
        return address >= start && address < end;
    }

    const size_t start;
    const size_t end;
};

class DataRegion
{
  public:
    enum class DataSize
    {
        String,
        Bytes,
        Words,
        Longs
    };

    DataRegion(Range range, DataSize type);

    static size_t asByteSize(DataSize size);

    inline size_t size() const
    {
        return DataRegion::asByteSize(type);
    }

    const Range range;
    const DataSize type;
};

class RegionManager
{
  public:
    RegionManager();

    inline void addDataRegion(const DataRegion& region)
    {
        _dataRegions.push_back(region);
    }

    inline void clear()
    {
        _dataRegions.clear();
    }

    const DataRegion* classHere(size_t address) const;

  private:
    std::vector<DataRegion> _dataRegions;
};

void do_cmd_file(struct options* opt);

extern RegionManager allRegions;

#endif
