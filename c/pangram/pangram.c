#include "pangram.h"

bool all(const bool *values, const size_t len);
int letter_index(const char letter);

bool is_pangram(const char *sentence) {
  if (sentence == NULL) {
    return false;
  }
  const size_t alphabet_size = 26;
  const size_t sentence_len = strlen(sentence);
  const int ignorable_char = -1;
  bool letter_appeared[26] = {false};

  for (size_t i = 0; i < sentence_len; i++) {
    const int current_letter_index = letter_index(sentence[i]);
    if (current_letter_index != ignorable_char) {
      letter_appeared[current_letter_index] = true;
    }
  }

  return all(letter_appeared, alphabet_size);
}

bool all(const bool *values, const size_t len) {
  bool result = true;

  for (size_t i = 0; i < len; i++) {
    result &= values[i];
  }

  return result;
}

int letter_index(const char chr) {
  const int low_case_bot = 97, low_case_top = 122;
  const int up_case_bot = 65, up_case_top = 90;
  const int no_letter = -1;

  int code = chr;

  if (up_case_bot <= code && code <= up_case_top) {
    return code - up_case_bot;
  }
  if (low_case_bot <= code && code <= low_case_top) {
    return code - low_case_bot;
  }
  return no_letter;
}