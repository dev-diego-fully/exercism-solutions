#include "two_fer.h"

namespace two_fer {

std::string two_fer(std::string name) {
  const std::string pre = "One for ", pos = ", one for me.";
  return pre + name + pos;
}

} // namespace two_fer
