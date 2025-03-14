#include "rotational_cipher.h"

#include <ctype.h>
#include <stdlib.h>
#include <string.h>

char rotate_char(char chr, int shift_key);
char rotate_upper(char upper, int shift_key);
char rotate_lower(char lower, int shift_key);
int rotate_letter(int letter_index, int shift_key);

// Returns a version of the given string encrypted using Caesar's cipher.
char *rotate(const char *text, int shift_key) {
  if (!text) {
    return NULL;
  }

  const size_t len = strlen(text);
  char *output = calloc(len + 1, sizeof(char));

  if (!output) {
    return NULL;
  }

  for (size_t i = 0; i < len; i++) {
    output[i] = rotate_char(text[i], shift_key);
  }

  return output;
}

// Rotates the character given by the rotation key if it is a letter. Preserves
// case.
char rotate_char(char chr, int shift_key) {
  if (isupper(chr)) {
    return rotate_upper(chr, shift_key);
  }
  if (islower(chr)) {
    return rotate_lower(chr, shift_key);
  }
  return chr;
}

// Rotates the given lowercase letter according to the shift key. Preserves
// case.
char rotate_lower(char lower, int shift_key) {
  return 'a' + rotate_letter(lower - 'a', shift_key);
}

// Rotates the given uppercase letter according to the shift key. Preserves
// case.
char rotate_upper(char upper, int shift_key) {
  return 'A' + rotate_letter(upper - 'A', shift_key);
}

// Given the index of a letter and the shift key, returns the new index of the
// equivalent letter after its rotation.
int rotate_letter(int letter_index, int shift_key) {
  static const int alphabet_size = 26;
  return (letter_index + shift_key) % alphabet_size;
}