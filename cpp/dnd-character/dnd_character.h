#pragma once

#include <algorithm>
#include <array>
#include <cstdlib>

namespace dnd_character {

int ability();

int modifier(const int attribute_value);

struct Character {
  int strength = ability();
  int dexterity = ability();
  int constitution = ability();
  int intelligence = ability();
  int wisdom = ability();
  int charisma = ability();
  int hitpoints = 10 + modifier(constitution);
};

} // namespace dnd_character
