#ifndef PERFECT_NUMBERS_H
#define PERFECT_NUMBERS_H

#include <stdbool.h>

typedef enum {
  ERROR = -1,
  PERFECT_NUMBER = 1,
  ABUNDANT_NUMBER = 2,
  DEFICIENT_NUMBER = 3,
} kind;

kind classify_number(long long number);

#endif
