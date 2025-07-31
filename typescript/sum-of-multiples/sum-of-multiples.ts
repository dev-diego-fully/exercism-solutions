/**
 * Calculates the sum of all unique multiples of a set of divisors up to a given value (exclusive).
 *
 * This function iterates through numbers from 0 up to `value` and checks if each number
 * is a multiple of any of the provided `divisors`. It then sums all the unique
 * numbers that meet this condition.
 *
 * @param divisors An array of numbers to use as divisors.
 * @param value The upper limit (exclusive) for checking multiples.
 * @returns The sum of all unique multiples found.
 *
 * @example
 * sum([3, 5], 10);      // Returns 23 (3, 5, 6, 9)
 * sum([7, 13, 17], 20); // Returns 51 (7, 13, 14, 17)
 * sum([4, 6], 15);      // Returns 30 (4, 6, 8, 12)
 */
export function sum(divisors: number[], value: number): number {
  return Array
    .from(range(value))
    .filter(v => hasDivisors(v, divisors))
    .reduce((prev, cur) => prev + cur, 0);
}

/**
 * Checks if a given number has any divisors from a list of candidates.
 *
 * @param value The number to check for divisibility.
 * @param candidates An array of potential divisors.
 * @returns `true` if `value` is divisible by at least one number in `candidates`, `false` otherwise.
 */
function hasDivisors(value: number, candidates: number[]): boolean {
  return candidates.some(candidate => value % candidate === 0);
}

/**
 * A generator function that yields a sequence of numbers from 0 up to `top` (exclusive).
 *
 * @param top The upper limit (exclusive) of the sequence.
 * @yields The next number in the sequence.
 */
function* range(top: number): Generator<number, void, void> {
  for (let i = 0; i < top; i++) {
    yield i;
  }
}