#pragma once

#include <cctype>
#include <cstddef>
#include <cstdio>
#include <string>
#include <vector>

namespace run_length_encoding {

std::string encode(const std::string &uncoded);
std::string decode(const std::string &encoded);

} // namespace run_length_encoding
