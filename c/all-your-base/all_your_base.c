#include "all_your_base.h"

#include <math.h>
#include <stdbool.h>
#include <string.h>

#define MIN(a, b) (a <= b ? a : b)

int64_t value_of(const int8_t digits[], int8_t base, size_t digits_count);
size_t value_to_base(int64_t value, int8_t base, int8_t buffer[],
                     size_t buffer_size);
int64_t digit_value(int8_t digit, int8_t base, size_t position);
size_t length_in_base(int64_t value, int8_t base);
bool check_number_base(int8_t digits[], size_t digits_count, int8_t base);

size_t rebase(int8_t digits[], uint8_t base, uint8_t new_base,
              size_t digits_count) {
  if (base < 2 || new_base < 2 || digits_count < 1 ||
      !check_number_base(digits, digits_count, base)) {
    memset(digits, 0, DIGITS_ARRAY_SIZE);
    return 0;
  }
  int64_t value = value_of(digits, base, digits_count);
  return value_to_base(value, new_base, digits, DIGITS_ARRAY_SIZE);
}

/*
 * Converts an integer value to its representation in a specified base.
 *
 * value:       The integer value to convert.
 * new_base:    The target base for the conversion.
 * buffer:      Array where the resulting digits will be stored (big-endian
 * order). buffer_size: The size of the buffer.
 *
 * The function resets the buffer before writing the result.
 * Returns the number of digits needed to represent the value in the new base.
 */
size_t value_to_base(int64_t value, int8_t new_base, int8_t buffer[],
                     size_t buffer_size) {
  const size_t new_digits_count = length_in_base(value, new_base);

  memset(buffer, 0, buffer_size);

  int64_t remaining_value = value;
  for (size_t i = MIN(new_digits_count, buffer_size); i > 0; i--) {
    buffer[i - 1] = remaining_value % new_base;
    remaining_value /= new_base;
  }

  return new_digits_count;
}

/*
 * Computes the integer value represented by the given digits in the specified
 * base.
 *
 * digits:       Array of digits (big-endian order).
 * base:         The base in which the number is represented.
 * digits_count: The number of digits provided.
 *
 * Returns the computed integer value.
 */
int64_t value_of(const int8_t digits[], int8_t base, size_t digits_count) {
  int64_t value = 0;
  size_t limit = MIN(digits_count, DIGITS_ARRAY_SIZE);

  for (size_t i = 0; i < limit; i++) {
    const size_t position = limit - i - 1;
    value += digit_value(digits[i], base, position);
  }

  return value;
}

/*
 * Returns the contribution of a single digit, given its position and base.
 *
 * digit:    The digit value.
 * base:     The base of the number.
 * position: The digit's position (0 for least significant digit).
 *
 * Returns the product of the digit and (base^position).
 */
int64_t digit_value(int8_t digit, int8_t base, size_t position) {
  return digit * (int64_t)pow(base, position);
}

/*
 * Determines how many digits are needed to represent a value in the given base.
 *
 * value: The value to represent.
 * base:  The target base.
 *
 * Returns the count of digits required.
 */
size_t length_in_base(int64_t value, int8_t base) {
  if (value == 0) {
    return 1;
  }
  return floor(log(value) / log(base)) + 1;
}

/*
 * Verifies that all digits in the provided array are valid for the specified
 * base.
 *
 * digits:       Array containing the digits.
 * digits_count: The number of digits in the array.
 * base:         The base to validate against.
 *
 * Returns true if every digit is in the range [0, base - 1]; false otherwise.
 */
bool check_number_base(int8_t digits[], size_t digits_count, int8_t base) {
  for (size_t i = 0; i < digits_count; i++) {
    if (digits[i] < 0 || digits[i] >= base) {
      return false;
    }
  }
  return true;
}
