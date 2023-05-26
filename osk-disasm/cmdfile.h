
#ifndef CMDFILE_H
#define CMDFILE_H

#include "pch.h"

#include "size.h"

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
    DataRegion(Range range, OperandSize size);

    const Range range;
    const OperandSize size;
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
