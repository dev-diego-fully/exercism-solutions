#include "resistor_color.h"

int color_code(resistor_band_t color) { return color; }

resistor_band_t *colors() {
  const int color_number = 10;
  const unsigned long colors_size = sizeof(resistor_band_t) * color_number;
  resistor_band_t *colors = (resistor_band_t *)malloc(colors_size);

  for (int i = 0; i < color_number; i++) {
    colors[i] = i;
  }

  return colors;
}