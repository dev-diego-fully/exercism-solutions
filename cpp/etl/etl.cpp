#include "etl.h"

namespace etl {

std::map<char, int> transform(const std::map<int, std::vector<char>> &old) {

  std::map<char, int> transformed;

  for (std::pair<int, std::vector<char>> a : old) {

    const int score = a.first;
    const std::vector<char> &letters = a.second;

    for (char letter : letters) {
      transformed[tolower(letter)] = score;
    }
  }

  return transformed;
}

} // namespace etl
