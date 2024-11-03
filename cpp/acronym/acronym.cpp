#include "acronym.h"

namespace acronym {

std::string clean(const std::string &input);
std::vector<std::string> split(const std::string &input);

std::string acronym(const std::string &phrase) {
  const std::vector<std::string> words = split(clean(phrase));
  std::string result;

  for (const std::string &word : words) {
    if (word.length() > 0) {
      result += std::toupper(word.at(0));
    }
  }

  return result;
}

std::string clean(const std::string &input) {
  const std::regex pattern("[^a-zA-Z\\s\\']");
  const std::string place_holder = " ";
  return std::regex_replace(input, pattern, place_holder);
}

std::vector<std::string> split(const std::string &input) {
  const int dismatch = -1;
  std::vector<std::string> words;
  std::regex pattern("\\s+");

  std::sregex_token_iterator iterator(input.begin(), input.end(), pattern,
                                      dismatch);
  std::sregex_token_iterator end;

  while (iterator != end) {
    words.push_back(*iterator);
    iterator++;
  }

  return words;
}

} // namespace acronym
