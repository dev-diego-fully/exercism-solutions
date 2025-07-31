/**
 * Finds the nth prime number.
 *
 * This function calculates an upper estimate for the nth prime, then generates
 * all primes up to that estimate using the Sieve of Eratosthenes, and finally
 * returns the nth prime from the generated list.
 *
 * @param n The position of the prime number to find (e.g., 1 for the first prime, 2 for the second).
 * @returns The nth prime number.
 * @throws RangeError If `n` is less than 1 or not an integer.
 *
 * @example
 * nth(1); // Returns 2 (the first prime)
 * nth(6); // Returns 13 (the sixth prime)
 */
export function nth(n: number): number {
  if (n < 1 || !Number.isInteger(n)) {
    throw new RangeError("Prime is not possible");
  }
  return primes(upperEstimateNth(n))[n - 1];
}

/**
 * Estimates an upper bound for the value of the nth prime number.
 *
 * This function uses different formulas based on the value of `n` to provide
 * a sufficiently large limit for the Sieve of Eratosthenes to ensure the nth
 * prime is included in the generated list.
 *
 * @param n The position of the prime number for which to estimate the upper bound.
 * @returns An estimated upper limit for the nth prime.
 */
function upperEstimateNth(n: number): number {
  if (n < 6) {
    return 2 * (n + 1) + 1;
  }

  const logN = Math.log(n);

  return Math.ceil(n * (logN + Math.log(logN)));
}

/**
 * Generates a list of prime numbers up to a specified limit using the Sieve of Eratosthenes algorithm.
 *
 * This function efficiently finds all prime numbers within a given range by iteratively
 * marking multiples of prime numbers as non-prime.
 *
 * @param limit The upper bound (inclusive) for finding prime numbers.
 * @returns An array of prime numbers up to the `limit`.
 *
 * @example
 * primes(10); // Returns [2, 3, 5, 7]
 * primes(20); // Returns [2, 3, 5, 7, 11, 13, 17, 19]
 */
function primes(limit: number): number[] {
  const marker = createMarker(limit);

  for (let current = 0; current <= limit; current++) {
    if (marker[current]) {
      markMultiples(marker, current);
    }
  }

  return getMarkeds(marker);
}

/**
 * Initializes a boolean array (marker) for the Sieve of Eratosthenes.
 *
 * All elements are initially set to `true`, representing potential primes.
 * `0` and `1` are explicitly marked as `false` because they are not prime.
 *
 * @param limit The size of the marker array, corresponding to the upper limit for prime checking.
 * @returns A boolean array where `true` indicates a potential prime number.
 */
function createMarker(limit: number): boolean[] {
  const marker = new Array(limit + 1).fill(true);

  marker[0] = false;
  marker[1] = false;

  return marker;
}

/**
 * Marks multiples of a given divisor as non-prime in the marker array.
 *
 * This function starts marking from the square of the divisor, as smaller
 * multiples would have already been marked by smaller prime factors.
 *
 * @param marker The boolean array representing potential primes.
 * @param divisor The number whose multiples need to be marked.
 * @returns The modified marker array.
 */
function markMultiples(marker: boolean[], divisor: number): boolean[] {
  for (let i = divisor ** 2; i < marker.length; i += divisor) {
    marker[i] = false;
  }
  return marker;
}

/**
 * Extracts the prime numbers from the marker array.
 *
 * It iterates through the marker array and collects the indices where the value is `true`
 * (indicating a prime number).
 *
 * @param marker The boolean array with `true` at prime indices.
 * @returns An array containing all the prime numbers found.
 */
function getMarkeds(marker: boolean[]): number[] {
  const markeds = [];

  for (let i = 0; i < marker.length; i++) {
    if (marker[i]) {
      markeds.push(i);
    }
  }

  return markeds;
}