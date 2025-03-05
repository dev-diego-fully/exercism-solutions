/**
 * @file series.h
 * @brief String slicing utilities for consecutive substrings
 */

#if !defined(SERIES_H)
#define SERIES_H

#include <string>
#include <vector>
#include <stdexcept>

namespace series
{
    /**
     * @brief Generates consecutive substrings of specified length
     * @param str Input string to slice
     * @param slice_length Desired substring length
     * @return Vector of consecutive substrings
     * @throw std::domain_error For invalid slice lengths
     *
     * Example: slice("hello", 2) → {"he", "el", "ll", "lo"}
     */
    std::vector<std::string> slice(const std::string &str, int slice_length);

} // namespace series

#endif // SERIES_H