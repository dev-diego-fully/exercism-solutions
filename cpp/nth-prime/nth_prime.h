/**
 * @file nth_prime.h
 * @brief Provides a function to compute the n-th prime number.
 *
 * This header declares a function to determine the n-th prime number
 * using an optimized prime generation approach.
 */

#if !defined(NTH_PRIME_H)
#define NTH_PRIME_H

#include <stdexcept>
#include <vector>
#include <cmath>

namespace nth_prime
{

    /**
     * @brief Computes the n-th prime number.
     * 
     * @param n The position of the prime number to find (1-based index).
     * @return The n-th prime number.
     * @throws std::domain_error if n is less than 1.
     */
    int nth(size_t n);

} // namespace nth_prime

#endif // NTH_PRIME_H
