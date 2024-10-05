#include "raindrops.h"

#define true 1
#define false 0

int is_divisible(int number, int divisor);

int is_divisible(int number, int divisor) {
  if (divisor == 0) {
    return false;
  }
  return number % divisor == 0;
}

void convert(char result[], int drops) {
  const char drop3_sound[] = "Pling";
  const char drop5_sound[] = "Plang";
  const char drop7_sound[] = "Plong";

  if (is_divisible(drops, 3)) {
    strcat(result, drop3_sound);
  }
  if (is_divisible(drops, 5)) {
    strcat(result, drop5_sound);
  }
  if (is_divisible(drops, 7)) {
    strcat(result, drop7_sound);
  }

  if (strlen(result) == 0) {
    sprintf(result, "%d", drops);
  }
}