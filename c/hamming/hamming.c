#include "hamming.h"

int compute(const char *lhs, const char *rhs) {
  const size_t first_len = strlen(lhs);
  if (first_len != strlen(rhs)) {
    return -1;
  }
  int distance = 0;
  for (size_t i = 0; i < first_len; i++) {
    if (lhs[i] != rhs[i]) {
      distance++;
    }
  }
  return distance;
}