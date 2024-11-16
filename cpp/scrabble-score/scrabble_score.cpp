#include "scrabble_score.h"

namespace scrabble_score {

int score(char letter);
bool contains(const std::string &list, char searched);

int score(const std::string &word) {
  int sum = 0;

  for (char c : word) {
    sum += score(tolower(c));
  }

  return sum;
}

const std::vector<std::pair<std::string, int>> scores = {
    {"aeioulnrst", 1}, {"dg", 2}, {"bcmp", 3}, {"fhvwy", 4},
    {"k", 5},          {"jx", 8}, {"qz", 10}};

int score(char letter) {
  for (std::pair<std::string, int> pair : scores) {
    const std::string &list = pair.first;
    int score = pair.second;
    if (contains(list, letter)) {
      return score;
    }
  }

  return 0;
}

bool contains(const std::string &list, const char searched) {
  for (char c : list) {
    if (c == searched) {
      return true;
    }
  }
  return false;
}

} // namespace scrabble_score
