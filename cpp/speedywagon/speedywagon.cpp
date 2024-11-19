#include "speedywagon.h"

namespace speedywagon {

// Enter your code below:
bool connection_check(pillar_men_sensor *sensor) { return sensor != nullptr; }

int activity_counter(pillar_men_sensor *sensors, int sensors_count) {
  pillar_men_sensor *current = sensors;

  int counter = 0;
  for (int i = 0; i < sensors_count; i++) {
    if (connection_check(current)) {
      counter += current->activity;
    }
    current += 1;
  }

  return counter;
}

bool alarm_control(pillar_men_sensor *sensor) {
  return connection_check(sensor) && sensor->activity > 0;
}

bool uv_alarm(pillar_men_sensor *sensor) {
  if (!connection_check(sensor)) {
    return false;
  }
  return uv_light_heuristic(&sensor->data) > sensor->activity;
}

// Please don't change the interface of the uv_light_heuristic function
int uv_light_heuristic(std::vector<int> *data_array) {
  double avg{};
  for (auto element : *data_array) {
    avg += element;
  }
  avg /= data_array->size();
  int uv_index{};
  for (auto element : *data_array) {
    if (element > avg)
      ++uv_index;
  }
  return uv_index;
}

} // namespace speedywagon
