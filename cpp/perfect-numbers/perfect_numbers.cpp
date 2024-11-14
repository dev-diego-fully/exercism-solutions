#include "perfect_numbers.h"


namespace perfect_numbers {

int aliquote_sum(int number);
bool is_divisible(int number, int divisor);

classification classify(int num) {
  const int aliquote_sum_ = aliquote_sum(num);

  if (aliquote_sum_ < num) {
    return classification::deficient;
  }
  if (aliquote_sum_ > num) {
    return classification::abundant;
  }
  return classification::perfect;
}

int aliquote_sum(int num) {
  if (num <= 0) {
    throw std::domain_error("Negative numbers are not allowed.");
  }

  int sum = 0;

  for (int candidate = 1; candidate < num; candidate++) {
    if (is_divisible(num, candidate)) {
      sum += candidate;
    }
  }

  return sum;
}

bool is_divisible(int num, int divisor) { return num % divisor == 0; }

} // namespace perfect_numbers
