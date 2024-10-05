#ifndef RESISTOR_COLOR_TRIO_H
#define RESISTOR_COLOR_TRIO_H

#include <math.h>
#include <stdint.h>

typedef enum {
  OHMS = 1,
  KILOOHMS = 1000,
  MEGAOHMS = 1000000,
  GIGAOHMS = 1000000000
} metric_prefix_t;

typedef struct {
  int value;
  metric_prefix_t unit;
} resistor_value_t;

typedef enum {
  BLACK = 0,
  BROWN,
  RED,
  ORANGE,
  YELLOW,
  GREEN,
  BLUE,
  VIOLET,
  GREY,
  WHITE = 9
} resistor_band_t;

resistor_value_t color_code(resistor_band_t colors[]);

#endif
