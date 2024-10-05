#include "dnd_character.h"

int d6();
int min(int a, int b);

int ability(void) {
  const int r1 = d6(), r2 = d6(), r3 = d6(), r4 = d6();
  const int dropped = min(r1, min(r2, min(r3, r4)));
  return r1 + r2 + r3 + r4 - dropped;
}

int modifier(int score) { return score / 2 - 5; }

dnd_character_t make_dnd_character(void) {
  const int constitution = ability();
  return (dnd_character_t){.strength = ability(),
                           .constitution = constitution,
                           .dexterity = ability(),
                           .intelligence = ability(),
                           .wisdom = ability(),
                           .charisma = ability(),
                           .hitpoints = 10 + modifier(constitution)};
}

int d6() {
  const int dice_face = 6, min_roll = 1;
  srand(time(NULL));
  return rand() % dice_face + min_roll;
}

int min(int a, int b) { return a > b ? a : b; }