/**
 * Calculates the prime factors of a given number.
 *
 * This function finds all prime numbers that, when multiplied together,
 * result in the input `value`. It efficiently extracts factors by
 * first handling the prime number 2, then iterating through odd numbers.
 *
 * @param value The number for which to calculate prime factors.
 * @returns An array of prime factors in ascending order.
 */
export function calculatePrimeFactors(value: number): number[] {
  const factors: number[] = [];

  let current = factorate(value, FIRST_PRIME, factors);

  const odds = range(FIRST_PRIME + 1, value, 2);

  for (const candidate of odds) {
    if (current === 1) {
      return factors;
    }
    current = factorate(current, candidate, factors);
  }

  if (current > 1) {
    factors.push(current);
  }

  return factors;
}

/**
 * @var FIRST_PRIME Represents the first prime number, which is 2.
 */
const FIRST_PRIME = 2;

/**
 * Divides a value by a given divisor repeatedly until it's no longer divisible.
 *
 * Each time the `value` is divided, the `divisor` is added to the `output` array.
 * This helper function effectively extracts all occurrences of a specific prime factor.
 *
 * @param value The number to be factored.
 * @param divisor The prime number to test as a factor.
 * @param output The array to which found factors will be pushed.
 * @returns The remaining value after all divisions by the `divisor`.
 */
function factorate(value: number, divisor: number, output: number[]): number {
  let current;

  for (current = value; current % divisor === 0; current /= divisor) {
    output.push(divisor);
  }

  return current;
}

/**
 * A generator function that yields a sequence of numbers within a specified range.
 *
 * It starts from `start`, increments by `step` (defaulting to 1), and continues
 * until `current` is no longer less than `end`.
 *
 * @param start The starting number of the sequence (inclusive).
 * @param end The ending number of the sequence (exclusive).
 * @param step The increment between numbers (defaults to 1).
 * @yields The next number in the sequence.
 */
function* range(start: number, end: number, step: number = 1) {
  for (let current = start; current < end; current += step) {
    yield current;
  }
}