#pragma once

#include <string>

namespace phone_number {

/**
 * @class phone_number
 * @brief Represents a phone number, cleaning and validating its format.
 *
 * This class takes a string representing a phone number, extracts the 10 digits
 * and validates them according to specific rules, such as the area code and exchange code
 * not starting with 0 or 1. If the number is invalid, it throws a std::domain_error.
 */
class phone_number {
 public:
  /**
   * @brief Constructs a phone_number object from a string.
   * @param number The raw phone number string, which can contain formatting.
   * @throws std::domain_error if the number is invalid.
   */
  phone_number(const std::string &number);
  
  /**
   * @brief Returns the 10-digit cleaned phone number.
   * @return A string containing only the 10 digits of the phone number.
   */
  std::string number() const;

 private:
  std::string inner_number;
};

}  // namespace phone_number