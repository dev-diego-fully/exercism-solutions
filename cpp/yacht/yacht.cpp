#include "yacht.h"

namespace yacht {

using dice_rolls = std::vector<short>;

const short dice_face_numbers = 6;
const short dice_on_roll = 5;

short face_count(const dice_rolls &dices, short face);
short calculate_faces(const dice_rolls &dices, short face);
short calculate_full_house(const dice_rolls &dices);
short calculate_four_of_a_kind(const dice_rolls &dices);
short calculate_straight(const dice_rolls &dices, bool is_big);
short calculate_choice(const dice_rolls &dices);
short calculate_yacht(const dice_rolls &dices);

short score(const dice_rolls &dices, const std::string &category) {
  if (category == "ones") {
    return calculate_faces(dices, 1);
  }
  if (category == "twos") {
    return calculate_faces(dices, 2);
  }
  if (category == "threes") {
    return calculate_faces(dices, 3);
  }
  if (category == "fours") {
    return calculate_faces(dices, 4);
  }
  if (category == "fives") {
    return calculate_faces(dices, 5);
  }
  if (category == "sixes") {
    return calculate_faces(dices, 6);
  }
  if (category == "full house") {
    return calculate_full_house(dices);
  }
  if (category == "four of a kind") {
    return calculate_four_of_a_kind(dices);
  }
  if (category == "little straight") {
    return calculate_straight(dices, false);
  }
  if (category == "big straight") {
    return calculate_straight(dices, true);
  }
  if (category == "choice") {
    return calculate_choice(dices);
  }
  if (category == "yacht") {
    return calculate_yacht(dices);
  }
  return -1;
}

short calculate_faces(const dice_rolls &dices, short face) {
  return face * face_count(dices, face);
}

short calculate_full_house(const dice_rolls &dices) {
  short face_with_three_rolls = 0;
  short face_with_two_rolls = 0;

  for (short face = 1; face <= dice_face_numbers; face++) {
    short count = face_count(dices, face);
    if (count == 2) {
      face_with_two_rolls = face;
    }
    if (count == 3) {
      face_with_three_rolls = face;
    }
  }

  if (face_with_three_rolls == 0 || face_with_two_rolls == 0) {
    return 0;
  }

  return 3 * face_with_three_rolls + 2 * face_with_two_rolls;
}

short calculate_four_of_a_kind(const dice_rolls &dices) {
  const short no_score = 0;

  for (short face = 1; face <= dice_face_numbers; face++) {
    if (face_count(dices, face) >= 4) {
      return 4 * face;
    }
  }

  return no_score;
}

short calculate_straight(const dice_rolls &dices, bool is_big) {
  const short scores = 30, no_score = 0;
  const short start_face = 1 + is_big;
  const short end_face = (dice_face_numbers - 1) + is_big;

  for (short face = start_face; face <= end_face; face++) {
    if (face_count(dices, face) < 1) {
      return no_score;
    }
  }

  return scores;
}

short calculate_choice(const dice_rolls &dices) {
  short sum = 0;

  for (short roll : dices) {
    sum += roll;
  }

  return sum;
}

short calculate_yacht(const dice_rolls &dices) {
  const short yacht_score = 50, no_score = 0;
  for (short face = 1; face <= dice_face_numbers; face++) {
    if (face_count(dices, face) == 5) {
      return yacht_score;
    }
  }
  return no_score;
}

short face_count(const dice_rolls &dices, short face) {
  short sum = 0;

  for (short roll : dices) {
    if (roll == face) {
      sum++;
    }
  }

  return sum;
}

} // namespace yacht
