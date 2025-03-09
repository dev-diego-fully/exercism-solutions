#include "square_root.h"

// Function that actually performs the recursion
double do_square_root(double lower, double upper, double number);
// Calculate the square of the passed value
double square(double value);
// Calculate the intermediate value between lower and upper
double middle_of(double upper, double lower);

/**Publics implementations**/

double square_root(double number) {
  const double initial_lower = 1;
  const double initial_upper = number;

  return do_square_root(initial_lower, initial_upper, number);
}

/**Privates implementations*/

double do_square_root(double lower, double upper, double number) {
  const double middle = middle_of(lower, upper);
  const double candidate = square(middle);

  if (candidate == number) {
    return middle;
  }
  if (candidate > number) {
    return do_square_root(lower, middle, number);
  }
  return do_square_root(middle, upper, number);
}

double square(double value) { return value * value; }

double middle_of(double lower, double upper) { return (upper + lower) / 2; }