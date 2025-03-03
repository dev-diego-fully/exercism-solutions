/**
 * @file anagram.h
 * @brief Anagram detection and processing utilities
 */

#if !defined(ANAGRAM_H)
#define ANAGRAM_H

#include <string>
#include <unordered_set>
#include <algorithm>

namespace anagram
{
    /**
     * @brief Detects anagrams for a given base word
     *
     * Performs case-insensitive comparisons and excludes identical words
     */
    class anagram
    {
    public:
        /**
         * @brief Create anagram detector for specific word
         * @param word Base word for anagram detection
         */
        anagram(std::string word);

        /**
         * @brief Find valid anagrams in candidate set
         * @param candidates Words to check for anagram matches
         * @return Set of valid anagrams (excluding original word)
         */
        std::unordered_set<std::string> matches(std::unordered_set<std::string> candidates) const;

        /// @brief Get original base word
        std::string word() const;

    private:
        std::string _word;      ///< Original input word
        std::string lowered;    ///< Lowercase version for comparison
        std::string normalized; ///< Sorted characters for quick matching

        /// @brief Core anagram validation check
        bool is_anagram(const std::string &candidate) const;
    };

} // namespace anagram

#endif // ANAGRAM_H