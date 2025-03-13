#ifndef PRIME_FACTORS_H
#define PRIME_FACTORS_H

#include <stddef.h>
#include <stdint.h>

#define MAXFACTORS 10

// Factors the given number by the given divisor, storing the factors in the
// given array.
// Returns the remaining value of the factorization.
size_t find_factors(uint64_t n, uint64_t factors[static MAXFACTORS]);

#endif