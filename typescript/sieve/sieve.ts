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
export function primes(limit: number): number[] {
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