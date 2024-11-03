#include "binary.h"

namespace binary {

const int invalid_digit = -1;

int value_of(char digit);
int value_in_binary(int digit, int pos);

int convert(const std::string &binary) {
  const int default_value = 0;

  int result = 0;

  for (size_t i = 0; i < binary.length(); i++) {
    const int digit = value_of(binary[i]);

    if (digit == invalid_digit) {
      return default_value;
    }

    if (digit == 1) {
      result += digit << (binary.length() - 1 - i);
    }
  }

  return result;
}

int value_of(char digit) {
  switch (digit) {

  case '1':
    return 1;
  case '0':
    return 0;

  default:
    return invalid_digit;
  }
}

} // namespace binary
