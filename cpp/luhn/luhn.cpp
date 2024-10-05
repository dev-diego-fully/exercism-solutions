#include "luhn.h"
#include <cctype>
#include <string>

namespace luhn {

bool has_invalid_chars(std::string number) {
  for (const char c : number) {
    if (!isdigit(c) && c != ' ') {
      return true;
    }
  }

  return false;
}

std::string clean(const std::string to_clean) {
  std::string cleaned{};
  for (const char c : to_clean) {
    if (isdigit(c)) {
      cleaned.push_back(c);
    }
  }
  return cleaned;
}

char luhn_digit(const char digit) {
  const int digit_value = digit - '0';
  int luhn_dig = digit_value * 2;

  if (luhn_dig > 9) {
    luhn_dig -= 9;
  }

  return '0' + luhn_dig;
}

std::string luhn_number(std::string number) {
  std::string luhn = "";
  bool is_even_position = number.length() % 2 == 0;

  for (const char c : number) {
    luhn.push_back(is_even_position ? luhn_digit(c) : c);
    is_even_position = !is_even_position;
  }
  return luhn;
}

int digits_sum(std::string number) {
    int sum = 0;
    for(const char c: number) {
        sum += c - '0';
    }
    return sum;
}

bool valid(const std::string number) {
  if (number.length() <= 1) {
    return false;
  }
  if(!isdigit(number.at(0))) {
    return false;
  }
  if (has_invalid_chars(number)) {
    return false;
  }
  const std::string cleaned = clean(number);
  const int luhn_digits_sum = digits_sum(luhn_number(cleaned));
  return luhn_digits_sum % 10 == 0;
}

} // namespace luhn
