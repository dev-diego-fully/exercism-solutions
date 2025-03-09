#include "square_root.h"

// Calculate the square of the passed value
double square(double value);
// Calculate the intermediate value between lower and upper
double middle_of(double lower, double upper);

/*-Publics Implementations-*/

// Calculates the square root of the passed number from an iterative binary
// search.
double square_root(double number) {
  double lower = 1;
  double upper = number;
  double middle, candidate;

  do {
    middle = middle_of(lower, upper);
    candidate = square(middle);

    if (candidate > number) {
      upper = middle;
    } else {
      lower = middle;
    }

  } while (candidate != number);

  return middle;
}

/*-------------------------*/

/*-Privates Implementations-*/

double square(double value) { return value * value; }

double middle_of(double lower, double upper) { return (upper + lower) / 2; }

/*-------------------------*/