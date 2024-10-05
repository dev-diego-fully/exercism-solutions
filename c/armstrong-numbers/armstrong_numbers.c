#include "armstrong_numbers.h"

typedef struct {
  size_t length;
  unsigned short *digits;
} number_digits_t;

void number_digits_t_destroy(number_digits_t destroied);
number_digits_t digits_from(int num);
int digits_count(int number);

bool is_armstrong_number(int candidate) {
  number_digits_t digits = digits_from(candidate);
  int armstrong_sum = 0;
  for (size_t i = 0; i < digits.length; i++) {
    armstrong_sum += pow(digits.digits[i], digits.length);
  }
  number_digits_t_destroy(digits);
  return armstrong_sum == candidate;
}

number_digits_t digits_from(int num) {
  number_digits_t num_digits = {.length = digits_count(num)};
  num_digits.digits =
      (unsigned short *)calloc(sizeof(unsigned short), num_digits.length);
  for (size_t i = 0; i < num_digits.length; i++) {
    num_digits.digits[num_digits.length - 1 - i] = num % 10;
    num /= 10;
  }
  return num_digits;
}

int digits_count(int number) {
  if (number < 10) {
    return 1;
  }
  return log10(number) + 1;
}

void number_digits_t_destroy(number_digits_t digits) { free(digits.digits); }