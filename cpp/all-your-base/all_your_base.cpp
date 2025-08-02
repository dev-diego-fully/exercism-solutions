#include "all_your_base.h"

#include <algorithm>
#include <cmath>
#include <stdexcept>

namespace all_your_base {

/**
 * @typedef value_t
 * @brief Represents the decimal value of a number, used for intermediate conversions.
 */
using value_t = uint64_t;

/**
 * @brief Converts a number from a given base to its decimal value.
 *
 * @param base The base of the number.
 * @param number The number represented as a vector of digits.
 * @return The decimal value of the number.
 */
value_t get_value(base_t base, const number_t &number);
/**
 * @brief Converts a decimal value to a number in a specified base.
 *
 * @param value The decimal value to convert.
 * @param base The target base.
 * @return A vector of digits representing the number in the target base.
 */
number_t value_to_base(value_t value, base_t base);
/**
 * @brief Calculates the decimal value of a single digit at a specific position.
 *
 * @param digit The digit value.
 * @param base The base of the number.
 * @param position The position of the digit (right to left, starting from 0).
 * @return The decimal value of the digit at the given position.
 */
value_t value_of_digit(digit_t digit, base_t base, size_t position);
/**
 * @brief Validates if a number's digits are correct for its base.
 *
 * Checks if every digit in the number is less than its base.
 *
 * @param base The base of the number.
 * @param number The number as a vector of digits.
 * @return `true` if the number is valid, `false` otherwise.
 */
bool is_valid_number(base_t base, const number_t &number);

/**
 * @var MIN_BASE The minimum valid base for conversions.
 */
const base_t MIN_BASE = 2;

/**
 * @brief Converts a number from one base to another.
 *
 * This function first converts the input number to a decimal value, then converts
 * that decimal value to the output base. It includes extensive validation for
 * the bases and the input digits.
 *
 * @param input_base The base of the input number. Must be >= 2.
 * @param input A vector of digits representing the number in `input_base`.
 * @param output_base The desired base for the output number. Must be >= 2.
 * @return A vector of digits representing the converted number in `output_base`.
 * @throws std::invalid_argument If an input base or output base is less than 2,
 * or if any digit in the input number is not valid for the input base.
 */
number_t convert(base_t input_base, const number_t &input, base_t output_base) {
  if (input_base < MIN_BASE || output_base < MIN_BASE) {
    throw std::invalid_argument("");
  }
  if (!is_valid_number(input_base, input)) {
    throw std::invalid_argument("");
  }
  if (input_base == output_base) {
    return input;
  }
  const value_t value = get_value(input_base, input);
  return value_to_base(value, output_base);
}

/**
 * @brief Converts a number from a given base to its decimal value.
 *
 * It processes the digits of the number from right to left, multiplying each
 * digit by the corresponding power of the base and summing the results.
 *
 * @param base The base of the number.
 * @param number The number represented as a vector of digits.
 * @return The decimal value of the number.
 */
value_t get_value(base_t base, const number_t &number) {
  value_t value = 0;

  for (size_t digit_count = 0; digit_count < number.size(); digit_count++) {
    const size_t index = number.size() - digit_count - 1;
    value += value_of_digit(number[index], base, digit_count);
  }

  return value;
}

/**
 * @brief Calculates the decimal value of a single digit at a specific position.
 *
 * @param digit The digit value.
 * @param base The base of the number.
 * @param position The position of the digit (right to left, starting from 0).
 * @return The decimal value of the digit at the given position.
 */
value_t value_of_digit(digit_t digit, base_t base, size_t position) {
  return digit * std::pow(base, position);
}

/**
 * @brief Converts a decimal value to a number in a specified base.
 *
 * It uses the repeated division method, storing the remainders as digits.
 * The resulting digits are reversed to form the correct number.
 *
 * @param value The decimal value to convert.
 * @param base The target base.
 * @return A vector of digits representing the number in the target base.
 */
number_t value_to_base(value_t value, base_t base) {
  number_t result;

  for (value_t current = value; current > 0; current /= base) {
    result.push_back(current % base);
  }

  std::reverse(result.begin(), result.end());

  return result;
}

/**
 * @brief Validates if a number's digits are correct for its base.
 *
 * Checks if every digit in the number is less than its base.
 *
 * @param base The base of the number.
 * @param number The number as a vector of digits.
 * @return `true` if the number is valid, `false` otherwise.
 */
bool is_valid_number(base_t base, const number_t &number) {
  return std::all_of(number.begin(), number.end(),
                     [base](digit_t digit) { return digit < base; });
}

}  // namespace all_your_base