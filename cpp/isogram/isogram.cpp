#include "isogram.h"

namespace isogram {

bool is_isogram(const std::string &input) {
  std::map<char, bool> already_appeared;

  for (char c : input) {
    if (!isalpha(c)) {
      continue;
    }

    const char current = tolower(c);

    if (already_appeared[current]) {
      return false;
    }

    already_appeared[current] = true;
  }

  return true;
}
} // namespace isogram
