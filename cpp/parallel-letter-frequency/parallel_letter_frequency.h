/**
 * @file parallel_letter_frequency.h
 * @brief Parallel letter frequency counter with optimized storage
 */

#if !defined(PARALLEL_LETTER_FREQUENCY_H)
#define PARALLEL_LETTER_FREQUENCY_H

#include <map>
#include <string_view>
#include <vector>

namespace parallel_letter_frequency
{
    /**
     * @brief Calculates combined letter frequencies using parallel processing
     * @param texts Collection of text fragments to analyze
     * @return Sorted map with lowercase a-z counts (only presents letters with count > 0)
     *
     * Features:
     * - Case-insensitive counting (a-z only)
     * - Parallel text processing
     * - Optimized array-based storage during counting
     */
    std::map<char, size_t> frequency(const std::vector<std::string_view> &texts);

} // namespace parallel_letter_frequency

#endif