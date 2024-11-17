#include "yacht.h"

namespace yacht {

using dice_rolls = std::vector<short>;

const short dice_face_numbers = 6;
const short dice_on_roll = 5;

bool has_category(const std::string &category);
short calculate_faces(const dice_rolls &dices, short face);
short calculate_full_house(const dice_rolls &dices);
short calculate_four_of_a_kind(const dice_rolls &dices);
short calculate_straight(const dice_rolls &dices, bool is_big);
short calculate_choice(const dice_rolls &dices);
short calculate_yacht(const dice_rolls &dices);
short face_count(const dice_rolls &dices, short face);

const std::map<std::string, std::function<short(const dice_rolls &)>> modes = {
    {"ones", std::bind(calculate_faces, std::placeholders::_1, 1)},
    {"twos", std::bind(calculate_faces, std::placeholders::_1, 2)},
    {"threes", std::bind(calculate_faces, std::placeholders::_1, 3)},
    {"fours", std::bind(calculate_faces, std::placeholders::_1, 4)},
    {"fives", std::bind(calculate_faces, std::placeholders::_1, 5)},
    {"sixes", std::bind(calculate_faces, std::placeholders::_1, 6)},
    {"full house", calculate_full_house},
    {"four of a kind", calculate_four_of_a_kind},
    {"little straight",
     std::bind(calculate_straight, std::placeholders::_1, false)},
    {"big straight",
     std::bind(calculate_straight, std::placeholders::_1, true)},
    {"choice", calculate_choice},
    {"yacht", calculate_yacht}};

short score(const dice_rolls &dices, const std::string &category) {
  const short invalid_as_category = -1;

  if (has_category(category)) {
    return modes.at(category)(dices);
  }

  return invalid_as_category;
}

bool has_category(const std::string &category) {
  return modes.find(category) != modes.end();
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
