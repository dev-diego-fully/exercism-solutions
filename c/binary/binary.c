#include "binary.h"

int convert(const char *input);
int bit_from(const char chr);
int bit_value(const int bit, const int pos);

int convert(const char *input) {
  if (input == NULL) {
    return INVALID;
  }
  const size_t input_len = strlen(input);
  int binary = 0;

  for (size_t i = 0; i < input_len; i++) {
    const int bit = bit_from(input[i]);
    if (bit == INVALID) {
      return INVALID;
    }
    const int bit_pos = input_len - 1 - i;
    binary += bit_value(bit, bit_pos);
  }

  return binary;
}

int bit_from(const char chr) {
  switch (chr) {
  case '0':
    return 0;
  case '1':
    return 1;
  default:
    return INVALID;
  }
}

int bit_value(const int bit, const int pos) { return bit << pos; }