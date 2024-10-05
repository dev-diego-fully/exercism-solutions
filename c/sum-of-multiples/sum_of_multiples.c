#include "sum_of_multiples.h"

bool is_factor_of(unsigned int factor, unsigned int number);
bool has_factor_in(unsigned int number, const unsigned int *factors,
                   size_t number_of_factors);

unsigned int sum(const unsigned int *factors, const size_t number_of_factors,
                 const unsigned int limit) {
  unsigned int factors_sum = 0;
  for (size_t candidate = 1; candidate < limit; candidate++) {
    if (has_factor_in(candidate, factors, number_of_factors)) {
      factors_sum += candidate;
    }
  }
  return factors_sum;
}

bool is_factor_of(unsigned int factor, unsigned int number) {
  if (factor != 0) {
    return number % factor == 0;
  }
  if (number == 0) {
    return true;
  }
  return false;
}

bool has_factor_in(unsigned int number, const unsigned int *factors,
                   size_t number_of_factors) {
  for (size_t i = 0; i < number_of_factors; i++) {
    if (is_factor_of(factors[i], number)) {
      return true;
    }
  }
  return false;
}