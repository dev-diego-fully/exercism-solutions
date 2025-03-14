#ifndef YACHT_H
#define YACHT_H

#define DICES_COUNT 5

typedef enum {
  ONES,
  TWOS,
  THREES,
  FOURS,
  FIVES,
  SIXES,
  FULL_HOUSE,
  FOUR_OF_A_KIND,
  LITTLE_STRAIGHT,
  BIG_STRAIGHT,
  CHOICE,
  YACHT
} category_t;

typedef struct {
  int faces[DICES_COUNT];
} dice_t;

int score(dice_t dice, category_t category);

#endif
