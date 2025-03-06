#include "parallel_letter_frequency.h"

namespace parallel_letter_frequency
{

    std::map<char, size_t> letter_frequency_merge(const std::vector<std::map<char, size_t>> &frequencies);
    std::map<char, size_t> letter_frequency(const std::string_view &text);

    std::map<char, size_t> frequency(const std::vector<std::string_view> &texts)
    {
        std::map<char, size_t> letter_counts{};
        std::vector<std::map<char, size_t>> result{texts.size()};

        std::transform(std::execution::par, texts.begin(), texts.end(), result.begin(), letter_frequency);

        return letter_frequency_merge(result);
    }

    std::map<char, size_t> letter_frequency(const std::string_view &text)
    {
        std::map<char, size_t> letter_counts{};

        for (auto character : text)
        {
            if (isalpha(character))
            {
                letter_counts[tolower(character)]++;
            }
        }

        return letter_counts;
    }

    std::map<char, size_t> letter_frequency_merge(const std::vector<std::map<char, size_t>> &frequencies)
    {
        std::map<char, size_t> result;

        for (auto counter : frequencies)
        {
            for (auto pair : counter)
            {
                result[pair.first] += pair.second;
            }
        }

        return result;
    }

}
