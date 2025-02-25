#include "nth_prime.h"
#include <complex>

namespace nth_prime
{
    const int FIRST_PRIME = 2;
    const int DISTANCE_BETWEEN_ODDS = 2;

    bool is_prime(int value, const std::vector<int> &previous_prime);
    bool is_divisible(int dividend, int divisor);

    int nth(size_t n)
    {
        if (n < 1)
        {
            throw std::domain_error("invalid ordinality");
        }

        std::vector<int> previous_prime{};
        previous_prime.reserve(n);
        previous_prime.push_back(FIRST_PRIME);

        for (int i = FIRST_PRIME + 1; previous_prime.size() < n; i += DISTANCE_BETWEEN_ODDS)
        {
            if (is_prime(i, previous_prime))
            {
                previous_prime.push_back(i);
            }
        }

        return previous_prime.at(n - 1);
    }

    bool is_prime(int value, const std::vector<int> &previous_prime)
    {
        int limit = std::sqrt(value);
        for (auto prime : previous_prime)
        {
            if (prime > limit)
            {
                return true;
            }
            if (is_divisible(value, prime))
            {
                return false;
            }
        }
        return true;
    }

    bool is_divisible(int dividend, int divisor)
    {
        return dividend % divisor == 0;
    }

} // namespace nth_prime
