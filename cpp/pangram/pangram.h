#if !defined(PANGRAM_H)
#define PANGRAM_H

#include <string>
#include <unordered_set>


namespace pangram {

bool is_pangram(const std::string text);

}  // namespace pangram

#endif // PANGRAM_H