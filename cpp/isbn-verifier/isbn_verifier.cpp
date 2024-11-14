#include "isbn_verifier.h"

namespace isbn_verifier {

std::vector<short> parse_isbn_string(const std::string &isbn);
int calculate_isbn(const std::vector<short> &isbn);
bool has_valid_digits_position(const std::vector<short> &isbn);
short parse_isbn_digit(char isbn_digit);

const short invalid_digit = -1;
const short ignorable_digit = -2;
const int isbn_size = 10;
const int x_digit_value = 10;

bool is_valid(const std::string &isbn) {
  std::vector<short> parsed = parse_isbn_string(isbn);

  if (parsed.size() != isbn_size) {
    return false;
  }

  if (!has_valid_digits_position(parsed)) {
    return false;
  }

  return calculate_isbn(parsed) == 0;
}

int calculate_isbn(const std::vector<short> &isbn) {
  const int isbn_mod = 11;

  int value = 0;

  for (size_t i = 0; i < isbn_size; i++) {
    value += (isbn_size - i) * isbn.at(i);
  }

  return value % isbn_mod;
}

std::vector<short> parse_isbn_string(const std::string &isbn) {
  std::vector<short> digits;

  for (size_t i = 0; i < isbn.size(); i++) {
    const int digit = parse_isbn_digit(isbn.at(i));
    if (digit == invalid_digit) {
      return {};
    }
    if (digit != ignorable_digit) {
      digits.push_back(digit);
    }
  }

  return digits;
}

bool has_valid_digits_position(const std::vector<short> &isbn) {
  for (size_t i = 0; i < isbn.size() - 1; i++) {
    if (isbn[i] == x_digit_value) {
      return false;
    }
  }
  return true;
}

short parse_isbn_digit(char isbn_digit) {
  if (isbn_digit == '-') {
    return ignorable_digit;
  }
  if (isbn_digit >= '0' && isbn_digit <= '9') {
    return isbn_digit - '0';
  }
  if (isbn_digit == 'X') {
    return x_digit_value;
  }
  return invalid_digit;
}

} // namespace isbn_verifier