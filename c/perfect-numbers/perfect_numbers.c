#include "perfect_numbers.h"

long long factors_sum(long long number);
bool is_divisible(long long x, long long y);

kind classify_number(long long number) {
  if (number <= 0) {
    return ERROR;
  }
  long long sum = factors_sum(number);
  if (sum == number) {
    return PERFECT_NUMBER;
  }
  if (sum > number) {
    return ABUNDANT_NUMBER;
  }
  return DEFICIENT_NUMBER;
}

long long factors_sum(long long number) {
  long long sum = 0;
  for (long long i = 1; i < number; i++) {
    if (is_divisible(number, i)) {
      sum += i;
    }
  }
  return sum;
}

bool is_divisible(long long x, long long y) { return x % y == 0; }