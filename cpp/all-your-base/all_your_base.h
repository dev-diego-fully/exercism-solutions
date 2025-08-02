#pragma once

#include <vector>

namespace all_your_base {

/**
 * @typedef digit_t
 * @brief Represents a single digit in a number.
 */
using digit_t = unsigned int;
/**
 * @typedef number_t
 * @brief Represents a number as a vector of digits, where each element is a digit_t.
 */
using number_t = std::vector<digit_t>;
/**
 * @typedef base_t
 * @brief Represents a number base, typically an unsigned short.
 */
using base_t = unsigned short;

/**
 * @brief Converts a number from one base to another.
 *
 * This function converts a number represented by a vector of digits from an input base
 * to an output base. It handles a variety of base systems and validates the input
 * to ensure correct operation.
 *
 * @param input_base The base of the input number. Must be >= 2.
 * @param input A vector of digits representing the number in `input_base`.
 * @param output_base The desired base for the output number. Must be >= 2.
 * @return A vector of digits representing the converted number in `output_base`.
 * @throws std::invalid_argument If an input base or output base is less than 2,
 * or if any digit in the input number is not valid for the input base.
 */
number_t convert(base_t input_base, const number_t &input, base_t output_base);

}  // namespace all_your_base