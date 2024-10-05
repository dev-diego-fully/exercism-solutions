#if !defined(SIEVE_H)
#define SIEVE_H

#include <vector>
#include <algorithm>
#include <cstddef>


namespace sieve {

std::vector<int> primes(const unsigned int limit);

}  // namespace sieve

#endif // SIEVE_H