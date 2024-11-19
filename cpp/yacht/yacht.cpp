#include "yacht.h"

namespace yacht {

// Declarations
using dices_roll = std::array<short, 5>;
using score_calculator = std::function<short(const dices_roll &)>;

std::optional<score_calculator> score_for(const std::string &category);
short score_for_face_categories(const dices_roll &dices, short face);
short score_for_straight(const dices_roll &dices, bool is_big);
short score_for_four_of_a_kind(const dices_roll &dices);
short score_for_fullhouse(const dices_roll &dices);
short score_for_yacht(const dices_roll &dices);
short score_for_choice(const dices_roll &dices);
bool is_rolls_equals(const dices_roll &roll_a, const dices_roll &roll_b);

// Publics
short score(const dices_roll &dices, const std::string &category) {
  dices_roll sorted = dices;
  std::sort(sorted.begin(), sorted.end());
  auto calculator = score_for(category);
  return calculator ? (*calculator)(sorted) : -1;
}

// Privates
const short no_score = 0;

short score_for_face_categories(const dices_roll &dices, short face) {
  return face * std::count(dices.begin(), dices.end(), face);
}

short score_for_fullhouse(const dices_roll &dices) {
  const short a = dices[0], b = dices[4];
  if (a == b) {
    return no_score;
  }
  if (is_rolls_equals(dices, {a, a, a, b, b})) {
    return 3 * a + 2 * b;
  }
  if (is_rolls_equals(dices, {a, a, b, b, b})) {
    return 2 * a + 3 * b;
  }
  return no_score;
}

short score_for_straight(const dices_roll &dices, bool is_big) {
  const short straight_score = 30;
  dices_roll straight;
  if (is_big) {
    straight = {2, 3, 4, 5, 6};
  } else {
    straight = {1, 2, 3, 4, 5};
  }
  return is_rolls_equals(dices, straight) ? straight_score : no_score;
}

short score_for_four_of_a_kind(const dices_roll &dices) {
  const short a = dices[0], b = dices[4];
  if (is_rolls_equals(dices, {a, a, a, a, b})) {
    return 4 * a;
  }
  if (is_rolls_equals(dices, {a, b, b, b, b})) {
    return 4 * b;
  }
  return no_score;
}

short score_for_yacht(const dices_roll &dices) {
  const short yacht_score = 50;
  const short a = dices[0];
  if (is_rolls_equals(dices, {a, a, a, a, a})) {
    return yacht_score;
  }
  return no_score;
}

short score_for_choice(const dices_roll &dices) {
  return std::accumulate(dices.begin(), dices.end(), no_score);
}

bool is_rolls_equals(const dices_roll &roll_a, const dices_roll &roll_b) {
  return std::equal(roll_a.begin(), roll_a.end(), roll_b.begin());
}

const std::unordered_map<std::string, score_calculator> score_calculator_map = {
    {"ones",
     [](const dices_roll &dices) {
       return score_for_face_categories(dices, 1);
     }},
    {"twos",
     [](const dices_roll &dices) {
       return score_for_face_categories(dices, 2);
     }},
    {"threes",
     [](const dices_roll &dices) {
       return score_for_face_categories(dices, 3);
     }},
    {"fours",
     [](const dices_roll &dices) {
       return score_for_face_categories(dices, 4);
     }},
    {"fives",
     [](const dices_roll &dices) {
       return score_for_face_categories(dices, 5);
     }},
    {"sixes",
     [](const dices_roll &dices) {
       return score_for_face_categories(dices, 6);
     }},
    {"little straight",
     [](const dices_roll &dices) { return score_for_straight(dices, false); }},
    {"big straight",
     [](const dices_roll &dices) { return score_for_straight(dices, true); }},
    {"full house", score_for_fullhouse},
    {"four of a kind", score_for_four_of_a_kind},
    {"yacht", score_for_yacht},
    {"choice", score_for_choice}};

std::optional<score_calculator> score_for(const std::string &category) {
  if (score_calculator_map.find(category) != score_calculator_map.end()) {
    return score_calculator_map.at(category);
  }
  return std::nullopt;
}

} // namespace yacht
