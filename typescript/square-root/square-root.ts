/**
 * Calculates the square root of a non-negative number.
 *
 * This function uses an iterative method to find the square root,
 * stopping when the exact value is found or the closest possible representation
 * is achieved, considering the precision limits of the `number` type.
 *
 * @param radicand The non-negative number for which to calculate the square root.
 * @returns The square root of the radicand.
 * @throws RangeError If the radicand is a negative number.
 */
export function squareRoot(radicand: number): number {
  if (radicand < 0) {
    throw new RangeError("Can't find square roots of negative numbers");
  }

  let top = radicand;
  let bot = 0;
  let middle = radicand / 2;

  for (let candidate = middle ** 2; candidate !== radicand; candidate = middle ** 2) {
    if (candidate > radicand) {
      top = middle;

    } else {
      bot = middle;
    }

    middle = average(bot, top);
  }

  return middle;
}

/**
 * Calculates the average of two numbers.
 *
 * @param a The first number.
 * @param b The second number.
 * @returns The average of 'a' and 'b'.
 */
function average(a: number, b: number): number {
  return (a + b) / 2;
}