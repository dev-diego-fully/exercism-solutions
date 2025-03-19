#include "atbash_cipher.h"

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Range at which atbash cipher separators are inserted.
const size_t ATBASH_JUMP = 5;
// Default separator for atbash cipher character blocks.
const char ATBASH_SEPARATOR = ' ';

// Encrypts a given character according to the atbash cipher.
char encode_char(char chr);
// Decrypts a character according to the atbash cipher.
char decode_char(char chr);
// Allocates and returns the appropriate space to hold the encrypted version of
// the given string.
char *string_for_encode(const char *input);
// Allocates and returns a space appropriate to hold the decrypted version of
// the given string.
char *string_for_decode(const char *input);
// Returns the number of characters in the given string that satisfy the
// condition (returns true) given by the given function.
size_t count(const char *str, int (*predicate)(int));

char *atbash_encode(const char *input) {
  if (!input) {
    return NULL;
  }

  char *encoded = string_for_encode(input);

  if (!encoded) {
    return NULL;
  }

  size_t encoded_length = 0;

  for (size_t i = 0; input[i] != '\0'; i++) {
    const char current = input[i];
    if (!isalnum(current)) {
      continue;
    }
    if (encoded_length % (ATBASH_JUMP + 1) == ATBASH_JUMP) {
      encoded[encoded_length++] = ATBASH_SEPARATOR;
    }
    encoded[encoded_length++] = encode_char(input[i]);
  }
  return encoded;
}

char *atbash_decode(const char *input) {
  if (!input) {
    return NULL;
  }

  char *decoded = string_for_decode(input);

  if (!decoded) {
    return NULL;
  }

  size_t decoded_length = 0;

  for (size_t i = 0; input[i] != '\0'; i++) {
    const char current = input[i];
    if (isalnum(current)) {
      decoded[decoded_length++] = decode_char(current);
    }
  }

  return decoded;
}

char encode_char(char chr) {
  if (isalpha(chr)) {
    return 'z' - (tolower(chr) - 'a');
  }
  return chr;
}

char decode_char(char chr) {
  if (isalpha(chr)) {
    return 'a' - (chr - 'z');
  }
  return chr;
}

char *string_for_encode(const char *input) {
  size_t counting = count(input, isalnum);
  size_t size = counting + counting / ATBASH_JUMP + 1;
  return calloc(size, sizeof(char));
}

char *string_for_decode(const char *input) {
  return calloc(count(input, isalnum) + 1, sizeof(char));
}

size_t count(const char *str, int (*predicate)(int)) {
  size_t count = 0;

  for (size_t i = 0; str[i] != '\0'; i++) {
    if (predicate(str[i])) {
      count++;
    }
  }

  return count;
}
