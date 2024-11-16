#include "run_length_encoding.h"

namespace run_length_encoding {

using char_count = std::pair<char, unsigned int>;
using char_counter = std::vector<char_count>;

char_counter raw_to_counter(const std::string &input);
char_counter encoded_to_counter(const std::string &input);

std::string encode_char_count(const char_count &pair);
std::string decode_char_count(const char_count &pair);

std::string encode(const std::string &uncoded) {
  const char_counter counter = raw_to_counter(uncoded);
  std::string encoded = "";

  for (size_t i = 0; i < counter.size(); i++) {
    encoded += encode_char_count(counter[i]);
  }

  return encoded;
}

std::string decode(const std::string &encoded) {
  const char_counter counter = encoded_to_counter(encoded);
  std::string decoded;

  for (char_count c : counter) {
    decoded += decode_char_count(c);
  }

  return decoded;
}

char_counter raw_to_counter(const std::string &input) {
  std::vector<char_count> stack;

  for (size_t i = 0; i < input.length(); i++) {
    const char current = input[i];

    if (!stack.empty() && stack.back().first == current) {
      stack.back().second++;
    } else {
      stack.push_back({input[i], 1});
    }
  }

  return stack;
}

char_counter encoded_to_counter(const std::string &encoded) {
  if (encoded.empty()) {
    return {};
  }

  char_counter counter;

  int count = 0;

  for (size_t i = 0; i < encoded.length(); i++) {
    char c = encoded.at(i);

    if (!isdigit(c)) {
      counter.push_back({c, count == 0 ? 1 : count});
      count = 0;
    } else {
      count *= 10;
      count += c - '0';
    }
  }

  return counter;
}

std::string encode_char_count(const char_count &pair) {
  std::string encoded{pair.first};
  if (pair.second > 1) {
    return std::to_string(pair.second) + encoded;
  }
  return encoded;
}

std::string decode_char_count(const char_count &pair) {
  return std::string(pair.second, pair.first);
}

} // namespace run_length_encoding