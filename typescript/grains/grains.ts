/**
 * Calculates the number of grains of wheat on a specific square of a chessboard
 * according to the problem of Wheat and Chessboard.
 *
 * This function determines the number of grains on a given `square` where
 * each square has double the grains of the previous one, starting with 1 grain on the first square.
 * It uses BigInt to handle potentially very large numbers of grains.
 *
 * @param square The square number (1 to 64) on the chessboard.
 * @returns The number of grains of wheat on the specified square as a BigInt.
 * @throws RangeError If the `square` is not an integer between 1 and 64, inclusive.
 */
export const square = (square: number): bigint => {
  if (square < 1 || square > 64 || !Number.isInteger(square)) {
    throw new RangeError(`Square ${square} outside the bounds of a chessboard`);
  }

  return 2n ** BigInt(square - 1);
};

/**
 * Calculates the total number of grains of wheat on all 64 squares of a chessboard.
 *
 * This sum represents (2^64) - 1, which is a very large number, hence the use of BigInt.
 *
 * @returns The total number of grains on the entire chessboard as a BigInt.
 */
export const total = (): bigint => 2n ** 64n - 1n;