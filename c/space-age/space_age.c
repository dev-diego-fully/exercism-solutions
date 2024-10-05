#include "space_age.h"

const float orbital_period[8] = {0.2408467, 0.61519726, 1.0,       1.8808158,
                                 11.862615, 29.447498,  84.016846, 164.79132};
const float seconds_in_earth_year = 365 * 24 * 60 * 60;

float seconds_to_earth_year(int64_t seconds);

float seconds_to_earth_year(int64_t seconds) {
  return seconds / seconds_in_earth_year;
}

float age(planet_t planet, int64_t seconds) {
  if (planet < MERCURY || planet > NEPTUNE) {
    return -1;
  }
  return seconds_to_earth_year(seconds) / orbital_period[planet];
}