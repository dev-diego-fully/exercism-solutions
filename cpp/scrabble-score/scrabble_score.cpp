#include "scrabble_score.h"

namespace scrabble_score {

int score(char score);

int score(const std::string &word) {
  int sum = 0;
  for (char c : word) {
    sum += score(tolower(c));
  }

  return sum;
}

int score(char score) {
  switch (score) {
  case 'a':
  case 'e':
  case 'i':
  case 'o':
  case 'u':
  case 'l':
  case 'n':
  case 'r':
  case 's':
  case 't':
    return 1;
  case 'd':
  case 'g':
    return 2;
  case 'b':
  case 'c':
  case 'm':
  case 'p':
    return 3;
  case 'f':
  case 'h':
  case 'v':
  case 'w':
  case 'y':
    return 4;
  case 'k':
    return 5;
  case 'j':
  case 'x':
    return 8;
  case 'q':
  case 'z':
    return 10;
  default:
    return 0;
  }
}

} // namespace scrabble_score
