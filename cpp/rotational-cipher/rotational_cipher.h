#pragma once

#include <cstddef>
#include <string>

namespace rotational_cipher {

std::string rotate(std::string msg, unsigned int rotations);

}  // namespace rotational_cipher
