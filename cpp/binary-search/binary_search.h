/**
 * @file binary_search.h
 * @brief Binary search algorithm implementation for sorted vectors.
 */
#if !defined(BINARY_SEARCH_H)
#define BINARY_SEARCH_H

#include <vector>
#include <stdexcept>

namespace binary_search
{
    /**
     * @brief Finds element in sorted vector using binary search.
     * @tparam T Type of elements supporting comparison operators
     * @param list Sorted vector to search through
     * @param element Element to locate
     * @return Index of found element
     * @throw std::domain_error When element not found
     *
     * Requires the input vector to be sorted in ascending order.
     */
    template <typename T>
    size_t find(const std::vector<T> &list, T element)
    {
        int bot_limit = 0;
        int top_limit = list.size() - 1;

        while (bot_limit <= top_limit)
        {
            int middle_index = (top_limit + bot_limit) / 2;
            T current = list.at(middle_index);

            if (current == element)
                return middle_index;

            else if (current > element)
                top_limit = middle_index - 1;

            else
                bot_limit = middle_index + 1;
        }

        throw std::domain_error("element not find");
    }

} // namespace binary_search

#endif // BINARY_SEARCH_H