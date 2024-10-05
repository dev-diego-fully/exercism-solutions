#include "dnd_character.h"

namespace dnd_character {

int d6() {
  const int faces = 6;
  return std::rand() % faces + 1;
}

int ability() {
  const int array_len = 4;
  std::array<int, array_len> dices = {d6(), d6(), d6(), d6()};

  std::sort(dices.begin(), dices.end());

  int sum = 0;

  for (int i = 0; i < array_len - 1; i++) {
    sum += dices.at(array_len - 1 - i);
  }

  return sum;
}

int modifier(const int attribute_value) {
  return attribute_value / 2 - 5;
}

} // namespace dnd_character
