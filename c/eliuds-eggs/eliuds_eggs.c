#include "eliuds_eggs.h"

int egg_count(int eggs) {
  int count = 0;
  while (eggs > 0) {
    count += eggs % 2;
    eggs = eggs / 2;
  }
  return count;
}