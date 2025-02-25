/**
 * @file nth_prime.cpp
 * @brief Implements the logic to compute the n-th prime number.
 *
 * This source file contains the implementation of the nth_prime::nth function,
 * which calculates the n-th prime number using an optimized prime generation method.
 * It also includes helper functions and the NumberMarker class used for marking multiples
 * in a given range for prime detection.
 */
#include "nth_prime.h"

namespace nth_prime
{
    /**
     * @brief Computes the prime numbers in a given range, starting from the smallest.
     *
     * This function identifies the prime numbers between the current limits,
     * using previously identified primes to mark non-primes in the range.
     *
     * @param current_primes The list of previously identified primes.
     * @param current_index The index of the last prime found, used to extend the search range.
     * @return A vector of newly found primes.
     */
    std::vector<int> next_primes(const std::vector<int> &current_primes, size_t current_index);
    /**
     * @brief Computes the upper limit of a range based on the prime at a given index.
     *
     * The limit is calculated as the square of the prime at the specified index.
     *
     * @param primes The list of primes.
     * @param index The index of the prime used to compute the limit.
     * @return The computed limit.
     */
    int get_limit(const std::vector<int> &primes, size_t index);

    /**
     * @brief Helper class to mark non-prime numbers in a specified range.
     *
     * This class marks multiples of known primes in a given range and provides
     * functionality to extract numbers that are not marked as multiples.
     */
    class NumberMarker
    {
    private:
        int range_start, range_end;
        std::vector<bool> marks;

    public:
        /**
         * @brief Constructs a NumberMarker for a given range.
         *
         * Initializes a vector of boolean values to mark multiples of primes
         * within the specified range.
         *
         * @param range_start The starting value of the range.
         * @param range_end The ending value of the range.
         * @throws std::domain_error if the start of the range is greater than the end.
         */
        NumberMarker(int range_start, int range_end)
        {
            if (range_start > range_end)
            {
                throw std::domain_error("invalid range initialization");
            }
            this->range_start = range_start;
            this->range_end = range_end;
            this->marks = std::vector<bool>((size_t)(range_end - range_start));
        }

        /**
         * @brief Returns the size of the range.
         *
         * @return The size of the range.
         */
        size_t size()
        {
            return this->range_end - this->range_start;
        }

        /**
         * @brief Marks multiples of a given factor within the range.
         *
         * Marks all multiples of the specified factor as non-prime within the range.
         *
         * @param factor The number whose multiples are to be marked.
         * @return The count of multiples marked.
         */
        size_t mark_multiplies(int factor)
        {
            const size_t base_module = range_start % factor;
            const size_t multiplies_start = base_module == 0 ? 0 : factor - base_module;
            const size_t limit = this->size();
            size_t count = 0;

            for (size_t i = multiplies_start; i < limit; i += factor)
            {
                marks[i] = true;
                count++;
            }

            return count;
        }

        /**
         * @brief Returns a list of numbers that are not marked as multiples.
         *
         * These numbers are considered prime within the specified range.
         *
         * @return A vector of numbers that are not marked as multiples.
         */
        std::vector<int> get_non_markeds()
        {
            const size_t limit = this->size();
            std::vector<int> non_markeds;

            for (size_t i = 0; i < limit; i++)
            {
                if (!this->marks.at(i))
                {
                    non_markeds.push_back(range_start + i);
                }
            }

            return non_markeds;
        }
    };

    int nth(size_t n)
    {
        if (n < 1)
        {
            throw std::domain_error("invalid ordinality");
        }

        std::vector<int> primes;
        primes.reserve(n);
        primes.push_back(2);
        primes.push_back(3);

        for (size_t i = 1; primes.size() < n; i++)
        {
            auto new_primes = next_primes(primes, i);
            primes.insert(primes.end(), new_primes.begin(), new_primes.end());
        }

        return primes.at(n - 1);
    }

    std::vector<int> next_primes(const std::vector<int> &current_primes, size_t current_index)
    {
        const int bot = get_limit(current_primes, current_index - 1) + 1;
        const int top = get_limit(current_primes, current_index);

        NumberMarker rejected_as_primes(bot, top);

        for (size_t i = 0; i <= current_index; i++)
        {
            rejected_as_primes.mark_multiplies(current_primes.at(i));
        }

        return rejected_as_primes.get_non_markeds();
    }

    int get_limit(const std::vector<int> &primes, size_t index)
    {
        return std::pow(primes.at(index), 2);
    }

} // namespace nth_prime
