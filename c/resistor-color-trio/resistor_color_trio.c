#include "resistor_color_trio.h"
#include <stdint.h>


resistor_value_t resistor_value_t_create(int64_t resistance_value);

resistor_value_t color_code(resistor_band_t colors[]) {
  const int64_t resistance_value =
      (colors[0] * 10 + colors[1]) * pow(10, colors[2]);
  return resistor_value_t_create(resistance_value);
}

resistor_value_t resistor_value_t_create(int64_t resistance_value) {
  if (resistance_value < 1.0e3) {
    return (resistor_value_t){.unit = OHMS, .value = resistance_value};
  }
  if (resistance_value < 1.0e6) {
    return (resistor_value_t){.unit = KILOOHMS,
                              .value = resistance_value / 1.0e3};
  }
  if (resistance_value < 1.0e9) {
    return (resistor_value_t){.unit = MEGAOHMS,
                              .value = resistance_value / 1.0e6};
  }
  return (resistor_value_t){.unit = GIGAOHMS,
                            .value = resistance_value / 1.0e9};
}