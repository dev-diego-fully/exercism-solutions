#include "darts.h"
#include <math.h>

double distance_from_center(float x, float y);

double distance_from_center(float x, float y) { return sqrt(x * x + y * y); }

int score(coordinate_t point) {
  const int inner_radius = 1, middle_radius = 5, outer_radius = 10;
  const int inner_score = 10, middle_score = 5, outer_score = 1,
            out_of_target_score = 0;

  const double distance = distance_from_center(point.x, point.y);

  if (distance <= inner_radius) {
    return inner_score;
  }

  if (distance <= middle_radius) {
    return middle_score;
  }

  if (distance <= outer_radius) {
    return outer_score;
  }

  return out_of_target_score;
}