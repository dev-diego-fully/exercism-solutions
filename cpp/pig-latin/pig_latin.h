#pragma once

#include <string>

namespace pig_latin {

/**
 * @brief Translates an English text to Pig Latin.
 *
 * This function takes a string of English words, where words are separated by spaces,
 * and translates each word according to the rules of Pig Latin.
 *
 * @param text The input text to be translated.
 * @return The translated text in Pig Latin.
 */
std::string translate(const std::string &text);

}  // namespace pig_latin