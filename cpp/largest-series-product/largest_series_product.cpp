#include "largest_series_product.h"

#include <algorithm>
#include <cstddef>
#include <stdexcept>

namespace largest_series_product {

/**
 * @brief Checks if a string contains only digit characters.
 *
 * @param number The string to check.
 * @return `true` if the string contains only digits, `false` otherwise.
 */
bool is_number(const std::string &number);
/**
 * @brief Calculates the product of all digits in a given string.
 *
 * @param number The string of digits.
 * @return The product of the digits.
 */
uint64_t digits_product(const std::string &number);

/**
 * @brief Finds the largest product of a contiguous series of digits in a number string.
 *
 * This function calculates the product of all contiguous series of a specified length
 * and returns the maximum product found. It validates the input string and span,
 * throwing an exception if they are invalid.
 *
 * @param number The string of digits to analyze.
 * @param span The length of the contiguous series.
 * @return The largest product of a series of digits of the given length.
 * @throws std::domain_error if `span` is negative, greater than the string's length,
 * or if the input string contains non-digit characters.
 */
uint64_t largest_product(const std::string &number, int64_t span) {
  if (span < 0) {
    throw std::domain_error("span must be positive");
  }
  if (static_cast<int64_t>(number.length()) < span) {
    throw std::domain_error("span cannot be greater than string");
  }
  if (!is_number(number)) {
    throw std::domain_error(
        "The provided string is not a valid number because it contains "
        "non-digit characters.");
  }
  const size_t limit = number.length() - static_cast<size_t>(span) + 1;
  uint64_t max = 0;

  for (size_t i = 0; i < limit; i++) {
    max = std::max(max, digits_product(number.substr(i, span)));
  }

  return max;
}

/**
 * @brief Checks if a string contains only digit characters.
 *
 * @param number The string to check.
 * @return `true` if the string contains only digits, `false` otherwise.
 */
bool is_number(const std::string &number) {
  return std::all_of(number.begin(), number.end(),
                     [](char chr) { return std::isdigit(chr); });
}

/**
 * @brief Calculates the product of all digits in a given string.
 *
 * @param number The string of digits.
 * @return The product of the digits.
 */
uint64_t digits_product(const std::string &number) {
  uint64_t product = 1;

  for (const char chr : number) {
    product *= (chr - '0');
  }

  return product;
}

}  // namespace largest_series_product