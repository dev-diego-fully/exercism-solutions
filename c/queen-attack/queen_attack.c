#include "queen_attack.h"

bool is_out_of_board(position_t queen_position);
bool shares_position(position_t queen_1, position_t queen_2);
bool shares_column(position_t queen_1, position_t queen_2);
bool shares_row(position_t queen_1, position_t queen_2);
bool shares_diagonal(position_t queen_1, position_t queen_2);

attack_status_t can_attack(position_t queen_1, position_t queen_2) {
  if (is_out_of_board(queen_1) || is_out_of_board(queen_2)) {
    return INVALID_POSITION;
  }
  if (shares_position(queen_1, queen_2)) {
    return INVALID_POSITION;
  }
  if (shares_row(queen_1, queen_2)) {
    return CAN_ATTACK;
  }
  if (shares_column(queen_1, queen_2)) {
    return CAN_ATTACK;
  }
  if (shares_diagonal(queen_1, queen_2)) {
    return CAN_ATTACK;
  }
  return CAN_NOT_ATTACK;
}

bool is_out_of_board(position_t queen_position) {
  return queen_position.column >= 8 || queen_position.row >= 8;
}

bool shares_position(position_t queen_1, position_t queen_2) {
  return shares_column(queen_1, queen_2) && shares_row(queen_1, queen_2);
}

bool shares_column(position_t queen_1, position_t queen_2) {
  return queen_1.column == queen_2.column;
}

bool shares_row(position_t queen_1, position_t queen_2) {
  return queen_1.row == queen_2.row;
}

bool shares_diagonal(position_t queen_1, position_t queen_2) {
  return abs(queen_2.column - queen_1.column) == abs(queen_2.row - queen_1.row);
}
