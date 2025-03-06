/**
 * @file parallel_letter_frequency.cpp
 * @brief Implementation of optimized parallel frequency counter
 */
#include "parallel_letter_frequency.h"

#include <algorithm>
#include <execution>
#include <cctype>
#include <array>

namespace parallel_letter_frequency
{
    constexpr size_t ALPHABET_LENGTH = 26;
    size_t letter_index(char letter);
    char letter_from_index(size_t index);

    /**
     * @brief Internal optimized letter counter using fixed-size array
     * @note Uses 26-element array for O(1) access/merging
     */
    class LetterCounter
    {
    public:
        /// @brief Merges multiple counters into one
        static LetterCounter merge(const std::vector<LetterCounter> &others);
        /// @brief Creates counter from single text fragment
        static LetterCounter from(const std::string_view &text);
        /// @brief Converts to standard map representation
        std::map<char, size_t> as_map() const;

    private:
        /// @brief Accumulates counts from another counter
        void join_to(const LetterCounter &other);
        /// @brief Processes individual characters
        void count_letter(char letter);

        std::array<size_t, ALPHABET_LENGTH> counter{}; ///< a-z counts (index 0 = 'a')
    };

    std::map<char, size_t> frequency(const std::vector<std::string_view> &texts)
    {
        std::vector<LetterCounter> result{texts.size()};

        std::transform(std::execution::par, texts.begin(), texts.end(),
                       result.begin(), LetterCounter::from);

        return LetterCounter::merge(result).as_map();
    }

    LetterCounter LetterCounter::merge(const std::vector<LetterCounter> &others)
    {
        LetterCounter result;

        for (auto other : others)
        {
            result.join_to(other);
        }

        return result;
    }

    LetterCounter LetterCounter::from(const std::string_view &text)
    {
        LetterCounter result;

        for (auto chr : text)
        {
            result.count_letter(chr);
        }

        return result;
    }

    std::map<char, size_t> LetterCounter::as_map() const
    {
        std::map<char, size_t> result;

        for (size_t i = 0; i < ALPHABET_LENGTH; i++)
        {
            if (this->counter[i] > 0)
            {
                result[letter_from_index(i)] = this->counter[i];
            }
        }

        return result;
    }

    void LetterCounter::join_to(const LetterCounter &other)
    {
        for (size_t i = 0; i < other.counter.size(); i++)
        {
            this->counter[i] += other.counter[i];
        }
    }

    void LetterCounter::count_letter(char letter)
    {
        if (isalpha(letter))
        {
            this->counter[letter_index(letter)]++;
        }
    }

    /**
     * @brief Converts character to 0-25 index (case-insensitive)
     * @param letter Must be a-z/A-Z
     * @return 0 for 'a/A', 25 for 'z/Z'
     */
    size_t letter_index(char letter)
    {
        return letter - (isupper(letter) ? 'A' : 'a');
    }

    /**
     * @brief Converts array index to lowercase letter
     * @param index Must be 0-25
     * @return Corresponding lowercase a-z character
     */
    char letter_from_index(size_t index)
    {
        return index + 'a';
    }

}
