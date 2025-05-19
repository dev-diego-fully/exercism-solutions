#include "word_count.h"

#include <algorithm>
#include <regex>

namespace word_count {

std::string normalize(const std::string &str);
std::string to_lowercase(const std::string &str);

// Standard word separators. They are all replaced in the normalization
// process.
const std::regex SEPARATOR_PATTERN(R"(\s|[^a-zA-Z\d\'])");

// Pattern to find words in a NORMALIZED string.
const std::regex WORD_PATTERN(R"(\b[a-zA-Z\d]+\'?[a-zA-Z\d]*\b)");

std::map<std::string, int> words(const std::string &phrase) {
  const std::string normalized = normalize(phrase);

  std::map<std::string, int> counts;

  auto words = std::sregex_iterator(phrase.begin(), phrase.end(), WORD_PATTERN);
  auto end = std::sregex_iterator();

  for (auto words_it = words; words_it != end; words_it++) {
    counts[to_lowercase(words_it->str())]++;
  }

  return counts;
}

// Replace all separators in the data string with standard whitespace,
// making the word parsing process easier.
// Does not modify the original string.
std::string normalize(const std::string &str) {
  return std::regex_replace(str, SEPARATOR_PATTERN, " ");
}

// Returns a copy of the given string, with all characters converted to
// lowercase.
std::string to_lowercase(const std::string &str) {
  std::string lowered = str;

  std::transform(str.begin(), str.end(), lowered.begin(),
                 [](unsigned char c) { return std::tolower(c); });

  return lowered;
}

}  // namespace word_count
