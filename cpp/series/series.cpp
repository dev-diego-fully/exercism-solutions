/**
 * @file series.cpp
 * @brief Implementation of string slicing operations
 */
#include "series.h"

namespace series
{

    /**
     * @copydoc slice()
     *
     * Implementation details:
     * - Uses sliding window approach
     * - Validates length constraints first
     */
    std::vector<std::string> slice(const std::string &str, int slice_length)
    {
        if (slice_length <= 0)
        {
            throw std::domain_error("slices cannot be shorter than 1");
        }
        if ((size_t)slice_length > str.length())
        {
            throw std::domain_error("slices cannot be longer than the original string");
        }

        std::vector<std::string> result;
        const size_t limit = str.length() - slice_length;

        for (size_t current = 0; current <= limit; current++)
        {
            result.push_back(str.substr(current, slice_length));
        }

        return result;
    }

} // namespace series
