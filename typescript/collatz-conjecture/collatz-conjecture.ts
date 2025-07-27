/**
 * Calculates the number of steps required to reach 1 using the Collatz conjecture.
 *
 * This function applies the Collatz rules: if the number is even, divide it by 2;
 * if it's odd, multiply by 3 and add 1. It counts how many steps it takes to
 * transform the initial `count` down to 1.
 *
 * @param count The starting positive integer for the Collatz sequence.
 * @returns The number of steps to reach 1.
 * @throws RangeError If the input `count` is not a positive integer.
 */
export function steps(count: number): number {
  if (count <= 0 || !Number.isInteger(count)) {
    throw new RangeError('Only positive integers are allowed');
  }

  let steps = 0;

  for (let current = count; current !== 1; current = collatz(current)) {
    steps++;
  }

  return steps;
}

/**
 * Applies a single step of the Collatz conjecture to a given number.
 *
 * If the number is even, it is divided by 2. If it is odd, it is multiplied by 3 and 1 is added.
 * This is a helper function for the `steps` calculation.
 *
 * @param value The number to apply the Collatz rule to.
 * @returns The result after one Collatz step.
 */
function collatz(value: number): number {
  if (value % 2 === 0) {
    return value / 2;
  }
  return 3 * value + 1;
}