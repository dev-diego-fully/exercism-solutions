#include "clock.h"

typedef struct {
  int hour;
  int minute;
} time_pair_t;

typedef unsigned int time_t;

time_pair_t time_pair_create(int hour, int minute);
time_pair_t clock_to_time_pair(clock_t clock);
time_pair_t time_to_time_pair(time_t time);
time_t time_create(int hour, int minute);

clock_t clock_create(int hour, int minute) {
  const char clock_format[] = "%02d:%02d";
  time_pair_t prepared = time_pair_create(hour, minute);
  clock_t output;
  sprintf(output.text, clock_format, prepared.hour, prepared.minute);
  return output;
}

clock_t clock_add(clock_t clock, int minute_add) {
  const time_pair_t reversed = clock_to_time_pair(clock);
  return clock_create(reversed.hour, reversed.minute + minute_add);
}

clock_t clock_subtract(clock_t clock, int minute_subtract) {
  const time_pair_t reversed = clock_to_time_pair(clock);
  return clock_create(reversed.hour, reversed.minute - minute_subtract);
}

bool clock_is_equal(clock_t a, clock_t b) {
  const time_pair_t time_a = clock_to_time_pair(a),
                    time_b = clock_to_time_pair(b);
  return time_a.hour == time_b.hour && time_a.minute == time_b.minute;
}

time_pair_t clock_to_time_pair(clock_t clock) {
  const char clock_format[] = "%02d:%02d";
  int hour = 0, minute = 0;
  sscanf(clock.text, clock_format, &hour, &minute);
  return time_pair_create(hour, minute);
}

time_t time_create(int hour, int minute) {
  const int minutes_in_hour = 60, hours_in_day = 24;
  const int max_time = minutes_in_hour * hours_in_day;
  const int total_time = (hour * minutes_in_hour + minute) % max_time;

  if (total_time < 0) {
    return max_time + total_time;
  }
  return total_time;
}

time_pair_t time_to_time_pair(time_t time) {
  const int minutes_in_hour = 60;

  return (time_pair_t){.hour = time / minutes_in_hour,
                       .minute = time % minutes_in_hour};
}

time_pair_t time_pair_create(int hour, int minute) {
  return time_to_time_pair(time_create(hour, minute));
}