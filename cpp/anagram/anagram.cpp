/**
 * @file anagram.cpp
 * @brief Implementation of anagram detection logic
 */
#include "anagram.h"

namespace anagram
{

    // Helper function prototypes
    /// @brief Converts string to lowercase
    std::string string_to_lower(std::string str);
    /// @brief Sorts string characters alphabetically
    std::string string_sort(std::string str);

    // Method implementations use documentation from header
    std::unordered_set<std::string> anagram::matches(std::unordered_set<std::string> candidates) const
    {
        std::unordered_set<std::string> matches;

        for (auto &&candidate : candidates)
        {
            if (this->is_anagram(candidate))
            {
                matches.insert(candidate);
            }
        }

        return matches;
    }

    anagram::anagram(std::string word)
    {
        this->_word = word;
        this->lowered = string_to_lower(word);
        this->normalized = string_sort(this->lowered);
    }

    /// @internal
    /// Performs case folding and sorted comparison
    bool anagram::is_anagram(const std::string &candidate) const
    {
        auto lowered_candidate = string_to_lower(candidate);
        if (lowered_candidate == this->lowered)
        {
            return false;
        }
        return string_sort(lowered_candidate) == this->normalized;
    }

    std::string anagram::word() const
    {
        return this->_word;
    }

    std::string string_to_lower(std::string str)
    {
        std::transform(str.begin(), str.end(), str.begin(), ::tolower);
        return str;
    }

    std::string string_sort(std::string str)
    {
        std::sort(str.begin(), str.end());
        return str;
    }

} // namespace anagram
