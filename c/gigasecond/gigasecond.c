#include "gigasecond.h"

void gigasecond(time_t input, char *output, size_t size) {
  const int giga = 1.0e9;
  const char format[] = "%Y-%m-%d %H:%M:%S";

  const time_t result = input + giga;
  struct tm *utc_time = gmtime(&result);

  strftime(output, size, format, utc_time);
}