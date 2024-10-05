#include "luhn.h"

bool is_digit(char digit);
unsigned short digit_value(char digit);
unsigned short double_of(unsigned short digit);

bool luhn(const char *num) {
  const size_t len = strlen(num);
  size_t sum = 0;
  size_t current_luhn_len = 0;
  for (size_t i = 0; i < len; i++) {
    const int index = len - 1 - i;
    if (num[index] == ' ') {
      continue;
    }
    if (!is_digit(num[index])) {
      return false;
    }
    const unsigned short digit = digit_value(num[index]);
    sum += current_luhn_len % 2 == 1 ? double_of(digit) : digit;
    current_luhn_len++;
  }
  return current_luhn_len > 1 && sum % 10 == 0;
}

bool is_digit(char digit) {
  const char zero = 48, nine = 57;
  return zero <= digit && digit <= nine;
}

unsigned short digit_value(char digit) {
  const char zero = 48;
  const short not_a_digit = 10;
  if (is_digit(digit)) {
    return digit - zero;
  }
  return not_a_digit;
}

unsigned short double_of(unsigned short digit) {
  unsigned short doubled = digit * 2;
  return doubled > 9 ? doubled - 9 : doubled;
}