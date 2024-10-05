#include "grains.h"
#include <math.h>

uint64_t square(uint8_t index) { return powf(2, index - 1); }

uint64_t total(void) {
  const uint8_t max_chess_index = 65;
  uint64_t sum = 0;

  for (uint8_t i = 0; i < max_chess_index; i++) {
    sum += square(i);
  }

  return sum;
}