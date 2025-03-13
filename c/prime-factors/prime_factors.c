#include "prime_factors.h"
#include <math.h>
#include <stdbool.h>

uint64_t factorate(uint64_t value, uint64_t divisor, uint64_t *factors,
                   size_t *factors_count);
bool stop(uint64_t current, uint64_t limit, size_t count);

// Factor all prime numbers of a given number, storing the factors in the passed
// buffer.
size_t find_factors(uint64_t n, uint64_t factors[static MAXFACTORS]) {
  const uint64_t limit = n > 3 ? (uint64_t)ceil(sqrt(n)) : n;
  uint64_t current = n;
  size_t factors_count = 0;

  for (uint64_t i = 2; !stop(i, limit, factors_count); i += 1 + i >= 3) {
    current = factorate(current, i, factors, &factors_count);
  }

  if (current != 1 && factors_count < MAXFACTORS) {
    factors[factors_count++] = current;
  }

  return factors_count;
}

// Factors the given number by the given divisor, storing the factors in the
// given array.
// Returns the remaining value of the factorization.
uint64_t factorate(uint64_t value, uint64_t divisor, uint64_t *factors,
                   size_t *factors_count) {
  uint64_t current = value;

  while (current % divisor == 0 && *factors_count < MAXFACTORS) {
    factors[*factors_count] = divisor;
    *factors_count = *factors_count + 1;
    current /= divisor;
  }

  return current;
}

// Checks whether the factorization process of a number has reached its end.
bool stop(uint64_t current, uint64_t limit, size_t count) {
  return current <= 1 || current > limit || count >= MAXFACTORS;
}
