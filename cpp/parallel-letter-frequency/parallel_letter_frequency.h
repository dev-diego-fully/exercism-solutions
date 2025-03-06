#if !defined(PARALLEL_LETTER_FREQUENCY_H)
#define PARALLEL_LETTER_FREQUENCY_H

#include <map>
#include <string_view>
#include <vector>
#include <algorithm>
#include <execution>
#include <cctype>
#include <utility>

namespace parallel_letter_frequency
{

    std::map<char, size_t> frequency(const std::vector<std::string_view> &text);

}

#endif
