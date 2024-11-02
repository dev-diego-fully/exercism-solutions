#include "hamming.h"

namespace hamming {

int compute(const std::string a, const std::string b) {
  if (a.length() != b.length()) {
    throw std::domain_error("It is not possible to compute the hamming "
                            "distance for strings of different sizes.");
  }
  int distance = 0;
  for (size_t i = 0; i < a.length(); i++) {
    if (a.at(i) != b.at(i)) {
      distance++;
    }
  }
  return distance;
}

} // namespace hamming
