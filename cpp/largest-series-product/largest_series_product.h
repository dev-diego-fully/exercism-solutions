#pragma once

#include <cstdint>
#include <string>

namespace largest_series_product {

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
uint64_t largest_product(const std::string &number, int64_t span);

}  // namespace largest_series_product