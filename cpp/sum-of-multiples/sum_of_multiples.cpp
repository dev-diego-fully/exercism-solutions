#include "sum_of_multiples.h"

namespace sum_of_multiples {

bool has_divisor_in(int num, std::vector<int> divisors);
bool is_divisible(int num, int divisor);

int to(std::vector<int> divisors, int limit) {
  int sum = 0;
  for (int i = 0; i < limit; i++) {
    if (has_divisor_in(i, divisors)) {
      sum += i;
    }
  }
  return sum;
}

bool has_divisor_in(int num, std::vector<int> divisors) {
  for (size_t i = 0; i < divisors.size(); i++) {
    if (is_divisible(num, divisors[i])) {
      return true;
    }
  }
  return false;
}

bool is_divisible(int num, int divisor) { return num % divisor == 0; }

} // namespace sum_of_multiples
