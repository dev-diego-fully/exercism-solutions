#include "queen_attack.h"

#include <stdexcept>

namespace queen_attack {

chess_board::chess_board(const coord &white, const coord &black) {
  if (!valid_position(white) || !valid_position(black)) {
    throw std::domain_error(
        "Invalid Position: Queens are outside the board boundaries.");
  }
  if (white == black) {
    throw std::domain_error(
        "Invalid Position: The two queens cannot occupy the same space.");
  }
  this->_white = white;
  this->_black = black;
}

coord chess_board::white() const { return this->_white; }

coord chess_board::black() const { return this->_black; }

bool chess_board::can_attack() const {
  return this->same_column() || this->same_row() || this->same_diagonal();
}

bool chess_board::same_column() const {
  return this->_white.first == this->_black.first;
}

bool chess_board::same_row() const {
  return this->_white.second == this->_black.second;
}

bool chess_board::same_diagonal() const {
  return this->delta_column() == this->delta_row();
}

bool chess_board::valid_position(const coord &position) {
  if (position.first < BOARD_START || position.first > BOARD_END) {
    return false;
  }
  if (position.second < BOARD_START || position.second > BOARD_END) {
    return false;
  }
  return true;
}

int chess_board::delta_column() const {
  return std::abs(this->_white.first - this->_black.first);
}

int chess_board::delta_row() const {
  return std::abs(this->_white.second - this->_black.second);
}

}  // namespace queen_attack
