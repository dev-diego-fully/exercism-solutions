#include "phone_number.h"

#include <regex>
#include <stdexcept>

namespace phone_number {

/**
 * @brief Extracts a valid 10-digit phone number from a raw string.
 *
 * This function uses a regular expression to find and capture the three components
 * of a US-style phone number: area code, exchange code, and subscriber number.
 * It validates the format and content, including ensuring the area code and
 * exchange code do not start with 0 or 1.
 *
 * @param number The raw phone number string.
 * @return A concatenated string of the 10 valid digits.
 * @throws std::domain_error if the number format is invalid or if the number
 * of digits or their values do not meet the criteria.
 */
std::string extract_number(const std::string &number);

/**
 * @brief Returns the cleaned 10-digit phone number.
 * @return The 10-digit number as a string.
 */
std::string phone_number::number() const { return this->inner_number; }

/**
 * @brief Constructs a phone_number object.
 *
 * It uses the `extract_number` helper function to process and validate the
 * input string. The result is stored in the `inner_number` member variable.
 *
 * @param number The raw phone number string.
 * @throws std::domain_error if the number is invalid.
 */
phone_number::phone_number(const std::string &number) {
  this->inner_number = extract_number(number);
}

/**
 * @brief Helper function to validate and clean the phone number string.
 *
 * @param number The raw phone number string.
 * @return A string with only the 10 digits.
 * @throws std::domain_error on validation failure.
 */
std::string extract_number(const std::string &number) {
  std::regex pattern(
      R"(\b(?:\+?1[-\.\s]*)?\(?([2-9]\d{2})\)?[-\.\s]*([2-9]\d{2})[-\.\s]*(\d{4})\b)");
  std::smatch results;

  if (!std::regex_search(number, results, pattern)) {
    throw std::domain_error("");
  }
  const std::string plan_area_code = results[1];
  const std::string exchange_code = results[2];
  const std::string subscriber_number = results[3];

  return plan_area_code + exchange_code + subscriber_number;
}

}  // namespace phone_number