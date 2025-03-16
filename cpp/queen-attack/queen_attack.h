/**
 * Provides classes and methods to check whether two enemy queens can attack
 * each other in their current position on a chessboard.
 */
#if !defined(QUEEN_ATTACK_H)
#define QUEEN_ATTACK_H

#include <utility>

namespace queen_attack {

using coord = std::pair<int, int>;

// Represents a board with two queens on top. Provides methods to check whether
// or not the two queens can attack each other.
class chess_board {
 public:
  /**
   * Initializes the board by positioning the two queens (white and black), as
   * long as their positions are valid. Throws a std::domain_error if their
   * positions are invalid (they are outside the board limits or the two queens
   * occupy the same position).
   */
  chess_board(const coord &white, const coord &black);
  /**
   * Returns the position of the white queen.
   */
  coord white() const;
  /**
  Returns the position of the black queen.
   */
  coord black() const;
  /**
   * Check and return whether it is possible for the two queens to attack each
   * other or not.
   */
  bool can_attack() const;

 private:
  // white queen position
  coord _white;
  // black queen position
  coord _black;

  /**
   * Checks if the given position for one of the two queens is within the limits
   * of the board.
   */
  static bool valid_position(const coord &position);

  /**
   * Checks and returns whether both queens are in the same column.
   */
  bool same_column() const;
  /**
   * Checks and returns if both queens are in the same row
   */
  bool same_row() const;
  /**
   * Checks and returns whether the two queens are on the same diagonal.
   */
  bool same_diagonal() const;

  /**
   * Calculates and returns how many columns apart the two queens are.
   */
  int delta_column() const;
  /**
   * Calculate and return how many lines apart the two queens are.
   */
  int delta_row() const;

  // Lowest index for a row or column.
  static const int BOARD_START = 0;
  // Largest index for a row or column.
  static const int BOARD_END = 7;
};

}  // namespace queen_attack

#endif  // QUEEN_ATTACK_H