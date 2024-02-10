
#ifndef CMDFILE_H
#define CMDFILE_H

#include "pch.h"

#include "size.h"
#include "range.h"

class DataRegion
{
  public:
    DataRegion(Range<size_t> range, OperandSize size);

    const Range<size_t> range;
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
