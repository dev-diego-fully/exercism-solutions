/**
 * @file sublist.h
 * @brief Sublist relationship detection between integer vectors
 */

#pragma once

#include <vector>

namespace sublist
{
    /**
     * @brief Relationship types between two lists
     */
    enum class List_comparison
    {
        equal,     ///< Lists contain identical elements in same order
        sublist,   ///< First list is contiguous subsequence of second
        superlist, ///< Second list is contiguous subsequence of first
        unequal    ///< No subsequence relationship exists
    };

    /**
     * @brief Determines hierarchical relationship between two lists
     * @param list_a First list to compare
     * @param list_b Second list to compare
     * @return Relationship type enum
     *
     * Empty list is considered sublist of any list
     */
    List_comparison sublist(const std::vector<int> &list_a, const std::vector<int> &list_b);

} // namespace sublist