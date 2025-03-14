#include "rational_numbers.h"
#include <math.h>
#include <stdbool.h>

long max(long a, long b);
bool is_divisible(long a, long b);
long long_abs(long num);
long long_pow(long a, long b);

// Returns the sum of the two given rational numbers
rational_t add(rational_t r1, rational_t r2) {
  rational_t sum;
  sum.numerator = r1.numerator * r2.denominator + r2.numerator * r1.denominator;
  sum.denominator = r1.denominator * r2.denominator;

  return reduce(sum);
}

// Returns the subtraction of the two given rational numbers
rational_t subtract(rational_t r1, rational_t r2) {
  rational_t subtraction;
  subtraction.numerator =
      r1.numerator * r2.denominator - r2.numerator * r1.denominator;
  subtraction.denominator = r1.denominator * r2.denominator;

  return reduce(subtraction);
}

// Returns the multiplication of the two given rational numbers
rational_t multiply(rational_t r1, rational_t r2) {
  rational_t multiplication;
  multiplication.numerator = r1.numerator * r2.numerator;
  multiplication.denominator = r1.denominator * r2.denominator;

  return reduce(multiplication);
}

// Returns the division of the two given rational numbers
rational_t divide(rational_t r1, rational_t r2) {
  rational_t division;
  division.numerator = r1.numerator * r2.denominator;
  division.denominator = r1.denominator * r2.numerator;

  return reduce(division);
}

// Returns the absolute value of the given rational number
rational_t absolute(rational_t value) {
  rational_t absolute;
  absolute.numerator = long_abs(value.numerator);
  absolute.denominator = long_abs(value.denominator);

  return reduce(absolute);
}

// Returns the irreducible fraction of the given rational number
rational_t reduce(rational_t value) {
  rational_t reduction = value;
  long limit = long_abs(max(reduction.denominator, reduction.numerator));

  for (long i = 2; i <= limit; i += 1 + i >= 3) {
    while (is_divisible(reduction.numerator, i) &&
           is_divisible(reduction.denominator, i)) {
      reduction.numerator /= i;
      reduction.denominator /= i;
    }
  }

  if (reduction.denominator < 0) {
    reduction.numerator *= -1;
    reduction.denominator *= -1;
  }

  return reduction;
}

// Returns the given real number raised to the given rational number
double exp_real(long real, rational_t rat) {
  return pow(real, (double)(rat.numerator) / rat.denominator);
}

// Returns the given rational number raised to the power of the given real
// number
rational_t exp_rational(rational_t rat, long real) {
  rational_t exponation;

  if (real == 0) {
    exponation.numerator = 1;
    exponation.denominator = 1;
  } else if (real > 0) {
    exponation.numerator = long_pow(rat.numerator, real);
    exponation.denominator = long_pow(rat.denominator, real);
  } else {
    const long modreal = long_abs(real);
    exponation.numerator = long_pow(rat.denominator, modreal);
    exponation.denominator = long_pow(rat.numerator, modreal);
  }

  return reduce(exponation);
}

// Returns the larger value between the two given numbers
long max(long a, long b) { return a > b ? a : b; }
// Returns whether a is divisible by b
bool is_divisible(long a, long b) { return a % b == 0; }
// Returns the absolute value of the given long
long long_abs(long num) { return num >= 0 ? num : -num; }
// Returns the result of a raised to the power of b.
long long_pow(long a, long b) { return (long)pow(a, b); }