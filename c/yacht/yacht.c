#include "yacht.h"

#include <string.h>

#define FACES 6

const int STRAIGHT_SCORE = 30;
const int YACHT_SCORE = 50;
const int DEFAULT_SCORE = 0;

typedef struct {
  size_t faces[FACES];
} facecounter_t;

void count_faces(const dice_t *roll, facecounter_t *counter);
int score_four_of_a_kind(const dice_t *roll);
int score_straight(const dice_t *roll, category_t straight);
int score_yacht(const dice_t *roll);
int score_full_house(const dice_t *roll);
int score_faces(const dice_t *roll, category_t face);
int roll_sum(const dice_t *roll);

int score(dice_t dice, category_t category) {
  switch (category) {
  case ONES:
  case TWOS:
  case THREES:
  case FOURS:
  case FIVES:
  case SIXES:
    return score_faces(&dice, category);
  case FULL_HOUSE:
    return score_full_house(&dice);
  case FOUR_OF_A_KIND:
    return score_four_of_a_kind(&dice);
  case LITTLE_STRAIGHT:
  case BIG_STRAIGHT:
    return score_straight(&dice, category);
  case CHOICE:
    return roll_sum(&dice);
  case YACHT:
    return score_yacht(&dice);
  default:
    return -1;
  }
}

int score_faces(const dice_t *roll, category_t face) {
  int sum = 0;
  const int face_value = face + 1;

  for (size_t i = 0; i < DICES_COUNT; i++) {
    if (roll->faces[i] == face_value) {
      sum++;
    }
  }

  return sum * (face_value);
}

int score_full_house(const dice_t *roll) {
  const int no_faces = -1;
  int twos = -1, threes = -1;

  facecounter_t counter;
  count_faces(roll, &counter);

  for (size_t i = ONES; i < FACES; i++) {
    switch (counter.faces[i]) {
    case 2:
      twos = i;
      break;
    case 3:
      threes = i;
      break;
    default:
      continue;
    }
  }

  if (twos != no_faces && threes != no_faces) {
    return (twos + 1) * 2 + (threes + 1) * 3;
  }
  return DEFAULT_SCORE;
}

int score_straight(const dice_t *roll, category_t straight) {
  facecounter_t counts;
  count_faces(roll, &counts);

  const size_t start = (straight == LITTLE_STRAIGHT) ? ONES : TWOS;

  for (size_t face = start; face < start + DICES_COUNT; face++) {
    if (counts.faces[face] != 1) {
      return DEFAULT_SCORE;
    }
  }

  return STRAIGHT_SCORE;
}

int score_yacht(const dice_t *roll) {
  int last = roll->faces[0];

  for (size_t i = 1; i < DICES_COUNT; i++) {
    if (last != roll->faces[i]) {
      return DEFAULT_SCORE;
    }
    last = roll->faces[i];
  }

  return YACHT_SCORE;
}

int score_four_of_a_kind(const dice_t *roll) {
  facecounter_t counter;
  count_faces(roll, &counter);

  for (size_t face = ONES; face < FACES; face++) {
    const int face_value = face + 1;
    if (counter.faces[face] >= 4) {
      return face_value * 4;
    }
  }

  return DEFAULT_SCORE;
}

void count_faces(const dice_t *roll, facecounter_t *counter) {
  memset(counter, 0, FACES * sizeof(size_t));
  for (size_t i = 0; i < DICES_COUNT; i++) {
    const int face = roll->faces[i] - 1;
    counter->faces[face]++;
  }
}

int roll_sum(const dice_t *roll) {
  int sum = 0;

  for (size_t i = 0; i < DICES_COUNT; i++) {
    sum += roll->faces[i];
  }

  return sum;
}
