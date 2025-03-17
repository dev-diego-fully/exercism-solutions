/*
 * Provides functions for converting a number's representation from one base to
 * another. The number is given as an array of digits (big-endian order, i.e.
 * most significant first).
 */
#ifndef ALL_YOUR_BASE_H
#define ALL_YOUR_BASE_H

#include <stddef.h>
#include <stdint.h>

/* Maximum allowed size for a number's digit array. */
#define DIGITS_ARRAY_SIZE 64

/*
 * Converts a number from one base to another.
 *
 * digits:       An array containing the digits of the number in the original
 * base. The digits are stored in big-endian order. base:         The original
 * base of the number. new_base:     The target base for conversion.
 * digits_count: The number of digits in the input number.
 *
 * The function overwrites the digits array with the new representation,
 * resetting unused positions to 0. If an error occurs (invalid base or digit,
 * or digits_count is 0), the buffer is reset to 0 and 0 is returned.
 *
 * Returns the number of digits in the new base representation.
 */
size_t rebase(int8_t digits[], uint8_t base, uint8_t new_base,
              size_t digits_count);

#endif
