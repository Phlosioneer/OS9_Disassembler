
#include "pch.h"

#include "references.h"

#include "address_space.h"

const refmap ReferenceManager::dummyEmptyRefmap{};

ReferenceManager refManager{};


RelocatedReference::RelocatedReference(RoffReferenceInfo refInfo, uint32_t offset) : info(refInfo), offset(offset)
{
}

/*
 * Add the initialization data to the Labels Ref. On entry, the file pointer is
 * positioned to the begin of the initialized data list for this particular vsect.
 */
void ReferenceManager::addInitialLabels(AddrSpaceHandle space, BigEndianStream* Module)
{
    uint32_t refVal;

    // Note: creates a ref space, if it doesn't exist already.
    for (auto& vec : refsBySpace[space])
    {
        for (auto& ref : vec.second)
        {
            if (!ref.isExternal())
            {
                Module->seekAbsolute(ref.offset);

                switch (ref.info.opSize())
                {
                case OperandSize::Byte:
                    refVal = Module->read<uint8_t>();
                    break;
                case OperandSize::Word:
                    refVal = Module->read<uint16_t>();
                    break;
                case OperandSize::Long:
                    refVal = Module->read<uint32_t>();
                    break;
                default:
                    throw std::runtime_error("Unreachable");
                }
                ref.setLabel(labelManager.addLabel(ref.space, refVal));
            }
        }
    }
}


/*
 * Returns the Destination reference for the reference.
 * Passed: The Type byte from the reference.
 * Returns: The Class Letter for the entry.
 */
AddrSpaceHandle RoffReferenceInfo::space() const
{
    /* We'll tie up additional classes for data/bss as follows
     * D for data
     * _ for init data
     * G for remote
     * H for remote init
     *
     */

    switch (scope)
    {
    case ReferenceScope::REFGLBL:
        switch (type & 0x100)
        {
        case 0:                  /* NOT common */
            switch (type & 0x04) /* Docs are backward? They say 0x01 */
            {
            case 0:                  /* Data */
                switch (type & 0x01) /* Docs are backward? They say 0x02 */
                {
                case 0:                  /* Uninit */
                    switch (type & 0x02) /* Docs are backward? They say 0x04 */
                    {
                    case 0:
                        // return 'D';
                        return &UNINIT_DATA_SPACE;
                    default:
                        // return 'G';
                        return &UNINIT_REMOTE_SPACE;
                    }
                default:                 /* Init */
                    switch (type & 0x02) /* Docs are backward? They say 0x04 */
                    {
                    case 0:
                        // return '_';
                        return &INIT_DATA_SPACE;
                    default:
                        // return 'H';
                        return &INIT_REMOTE_SPACE;
                    }
                }
            default: /* Code or Equ */
                /* FIXME: Based on the above backwards columns, I think this should be `type & 0x1`.
                 * For now, it's using 0x02 as documented.
                 */
                switch (type & 0x02)
                {
                case 0: /* code */
                    // return 'L';
                    return &CODE_SPACE;
                default: /* equ */
                    // return 'L';
                    return &EQUATE_SPACE;
                }
            }
        default: /* common */
            /* FIXME: This appears to be a typo. */
            switch (type & 0x20)
            {
            case 0: /* NOT Remote */
                /* These are WRONG! but for now, we'll use them */
                return &UNINIT_DATA_SPACE;
            default:
                return &INIT_DATA_SPACE;
            }
        }

        break;

    case ReferenceScope::REFXTRN:
    case ReferenceScope::REFLOCAL:
        switch (type & 0x200)
        {
        case 0: /* NOT remote */
            switch (type & 0x20)
            {
            case 0: /* data */
                return &INIT_DATA_SPACE;
            default: /* code */
                return &CODE_SPACE;
            }
        default:
            switch (type & 0x20)
            {
            case 0: /* Remote */
                return &INIT_REMOTE_SPACE;
            default: /* debug (undocumented) */
                return &DEBUG_SPACE;
            }
        }
    }

    // return 'L'; /* Should never get to here, but for safety's sake */
    throw std::runtime_error("Unknown address space");
}

/*
 * Get entries for given reference, either external or local.
 * Passed:  name (or blank for locals)
 *          count - number of entries to process
 *          1 if external, 0 if local
 */
void parseRefSection(const std::string& vname, size_t count, ReferenceScope ref_typ, BigEndianStream* code_buf,
                     BigEndianStream* Module)
{
    RelocatedReference* prevRef = NULL;
    AddrSpaceHandle space;
    uint16_t _ty;
    uint32_t _ofst;

    for (; count > 0; count--)
    {
        _ty = Module->read<uint16_t>();
        _ofst = Module->read<uint32_t>();

        RoffReferenceInfo info{_ty, ref_typ};

        /* Add to externs table */
        space = info.space();
        if (!space) throw std::runtime_error("Unexpected class: nullptr");
        if (*space == DEBUG_SPACE)
        {
            // Skip Debug refs
            continue;
        }

        RelocatedReference new_ref(info, _ofst);

        if (new_ref.isExternal())
        {
            new_ref.setName(vname);
        }
        else
        {
            register int dstVal;
            code_buf->seekAbsolute(new_ref.offset);

            RoffReferenceInfo globalInfo{_ty, ReferenceScope::REFGLBL};
            new_ref.space = globalInfo.space();

            if ((ref_typ == ReferenceScope::REFLOCAL) && (*space == CODE_SPACE))
            {
                switch (new_ref.info.opSize())
                {
                case OperandSize::Byte:
                    dstVal = code_buf->read<uint8_t>();
                    break;
                case OperandSize::Word:
                    dstVal = code_buf->read<uint16_t>();
                    break;
                case OperandSize::Long:
                    dstVal = code_buf->read<uint32_t>();
                    break;
                default:
                    throw std::runtime_error("Unexpected size");
                }
                new_ref.setLabel(labelManager.addLabel(new_ref.space, dstVal));
            }
            else
            {
                // These are local refs; they indicate a label's value should be subbed
                // into the expression. DoDataBlock should handle this automatically for
                // data references by just existing in the refmap. Not sure about code references?

                // TODO: Lookup the value in the specified location, and ensure there
                // is a label for it. Maybe add a tag to the label to force it to appear
                // for that particular address?
            }
        }

        refManager.insert(space, std::move(new_ref));
    }
}

const std::vector<RelocatedReference>* ReferenceManager::find_extrn(AddrSpaceHandle space, uint32_t adrs) const
{
    auto refmap = refsBySpace.find(space);
    if (refmap == refsBySpace.cend())
    {
        return nullptr;
    }

    auto it = refmap->second.find(adrs);
    if (it == refmap->second.cend())
    {
        return nullptr;
    }

    return &it->second;
}

void ReferenceManager::insert(AddrSpaceHandle space, RelocatedReference&& move_ref)
{
    // This will create a refmap if the space is absent, then create a vector for the
    // address if that's absent.
    refsBySpace[space][move_ref.offset].emplace_back(move_ref);
}

void ReferenceManager::clear()
{
    refsBySpace.clear();
}

OperandSize maxSizeOfRefs(const std::vector<RelocatedReference>& refs)
{
    OperandSize max = OperandSize::Byte;
    for (const RelocatedReference& ref : refs)
    {
        max = OperandSizes::max(max, ref.info.opSize());
    }
    return max;
}