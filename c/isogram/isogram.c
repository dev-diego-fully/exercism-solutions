#include "isogram.h"

int letter_index(const char chr);

bool is_isogram(const char phrase[]) {
  if (phrase == NULL) {
    return false;
  }
  const int ignorable_char = -1;
  const size_t phrase_len = strlen(phrase);
  bool letter_appeared[26] = {false};

  for (size_t i = 0; i < phrase_len; i++) {
    const int current_letter_index = letter_index(phrase[i]);
    if (current_letter_index == ignorable_char) {
      continue;
    }
    if (letter_appeared[current_letter_index]) {
      return false;
    }
    letter_appeared[current_letter_index] = true;
  }

  return true;
}

int letter_index(const char chr) {
  const int low_case_bot = 97, low_case_top = 122;
  const int up_case_bot = 65, up_case_top = 90;
  const int no_letter = -1;

  int code = chr;

  if (low_case_bot <= code && code <= low_case_top) {
    return code - low_case_bot;
  }
  if (up_case_bot <= code && code <= up_case_top) {
    return code - up_case_bot;
  }
  return no_letter;
}