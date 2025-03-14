// Provides the implementation of rational numbers, as well as support for their
// operations.
#ifndef RATIONAL_NUMBERS_H
#define RATIONAL_NUMBERS_H

typedef struct {
  long numerator;
  long denominator;
} rational_t;

// Returns the sum of the two given rational numbers
rational_t add(rational_t r1, rational_t r2);

// Returns the subtraction of the two given rational numbers
rational_t subtract(rational_t r1, rational_t r2);

// Returns the multiplication of the two given rational numbers
rational_t multiply(rational_t r1, rational_t r2);

// Returns the division of the two given rational numbers
rational_t divide(rational_t r1, rational_t r2);

// Returns the absolute value of the given rational number
rational_t absolute(rational_t value);

// Returns the irreducible fraction of the given rational number
rational_t reduce(rational_t value);

// Returns the given real number raised to the given rational number
double exp_real(long real, rational_t rat);

// Returns the given rational number raised to the power of the given real
// number
rational_t exp_rational(rational_t rat, long real);

#endif
