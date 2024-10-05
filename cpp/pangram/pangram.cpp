#include "pangram.h"


namespace pangram {

const std::string alphabet_letters = "abcdefghijklmnopqrstuvwxyz";

bool is_pangram(const std::string text) {
    std::unordered_set<char> letters;

    for(const char c: text) {
        if(isalpha(c)) {
            letters.insert(tolower(c));
        }
    }

    for(const char c: alphabet_letters) {
        if(letters.count(c) < 1) {
            return false;
        }
    }

    return true;
}

}  // namespace pangram
