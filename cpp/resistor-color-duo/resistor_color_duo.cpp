#include "resistor_color_duo.h"


namespace resistor_color_duo {

const std::vector<std::string> resistor_colors{
    "black", "brown", "red",    "orange", "yellow",
    "green", "blue",  "violet", "grey",   "white"
};

int value(const std::string color) {
  const int invalid_color = -1;

  for (size_t i = 0; i < resistor_colors.size(); i++) {
    if (resistor_colors[i] == color) {
      return i;
    }
  }

  return invalid_color;
}

int value(const std::vector<std::string> color_duo) {
  const int color_one_value = value(color_duo.at(0)) * 10;
  const int color_two_value = value(color_duo.at(1));

  return color_one_value + color_two_value;
}

} // namespace resistor_color_duo
