/**
 * @file sublist.cpp
 * @brief Implementation of sublist relationship detection
 */

#include "sublist.h"

namespace sublist
{

    /**
     * @brief Checks if sub is contiguous subsequence of super
     * @param sub Potential subsequence
     * @param super Potential containing list
     * @return True if sub appears in super consecutively and in order
     */
    bool is_sublist(const std::vector<int> &sub, const std::vector<int> &super);

    List_comparison sublist(const std::vector<int> &list_a, const std::vector<int> &list_b)
    {
        bool is_a_sub_b = is_sublist(list_a, list_b);
        bool is_b_sub_a = is_sublist(list_b, list_a);

        if (is_a_sub_b && is_b_sub_a)
            return List_comparison::equal;

        if (is_a_sub_b)
            return List_comparison::sublist;

        if (is_b_sub_a)
            return List_comparison::superlist;

        return List_comparison::unequal;
    }

    bool is_sublist(const std::vector<int> &sub, const std::vector<int> &super)
    {
        if (sub.size() > super.size())
        {
            return false;
        }

        const auto super_slice_limit = super.end() - sub.size();

        for (auto super_slice_start = super.begin(); super_slice_start <= super_slice_limit; super_slice_start++)
        {
            const auto super_slice_end = super_slice_start + sub.size();
            if (std::equal(super_slice_start, super_slice_end, sub.begin(), sub.end()))
            {
                return true;
            }
        }

        return false;
    }

} // namespace sublist
