#pragma once

#include <map>
#include <string>

namespace word_count {

// Returns a count of each word found in the given string. This function is
// case insensitive and will consider any case variation of the word as
// the same word.
std::map<std::string, int> words(const std::string &phrase);

}
