#ifndef NTH_PRIME_H
#define NTH_PRIME_H

#include <stdint.h>

/**
 * @brief Calculates the nth prime number.
 *
 * @param n 1-based index of the prime number to calculate.
 * @return uint32_t The nth prime number, or 0 if n is 0.
 */
uint32_t nth(uint32_t n);

#endif