#include "anagram.h"

#include <ctype.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Simplify writing struct candidates
typedef struct candidates candidates_t;
// Simplify writing struct candidate
typedef struct candidate candidate_t;

// Stores pre-processed subject data, simplifying function signatures
typedef struct {
  size_t len;
  char *lowered;
  char *normalized;
} subject_t;

bool is_anagram(const char *word, subject_t subject);
char *to_lower(char *str, size_t len);
char *sort(char *str, size_t len);
subject_t new_subject(const char *str, size_t len, char *lowered,
                      char *normalized);
void swap(char *str, size_t a, size_t b);

// Determines if any of the words in candidate are anagrams
// for subject. Contents of candidate structures may be modified.
void find_anagrams(const char *subject, struct candidates *candidates) {
  const size_t subject_len = strlen(subject);
  char lowered_space[subject_len + 1], normalized_space[subject_len + 1];
  subject_t pack =
      new_subject(subject, subject_len, lowered_space, normalized_space);

  for (size_t i = 0; i < candidates->count; i++) {
    candidate_t *current = &candidates->candidate[i];
    current->is_anagram = is_anagram(current->word, pack);
  }
}

// Check if word is an anagram from subject
bool is_anagram(const char *word, subject_t subject) {
  const size_t len = strlen(word);
  char copy[len + 1];
  strncpy(copy, word, len + 1);

  if (len != subject.len) {
    return false;
  }

  char *lowered = to_lower(copy, len);
  if (strcmp(lowered, subject.lowered) == 0) {
    return false;
  }

  char *normalized = sort(lowered, len);
  return strcmp(normalized, subject.normalized) == 0;
}

// Transform the entire string to lowercase
char *to_lower(char *str, size_t len) {
  for (size_t i = 0; i < len; i++) {
    str[i] = tolower(str[i]);
  }
  return str;
}

// Sorts a string using selection sort [O(n)]
char *sort(char *str, size_t len) {
  for (size_t i = 0; i < len; i++) {
    size_t min = i;

    for (size_t j = i + 1; j < len; j++) {
      if (str[min] > str[j]) {
        min = j;
      }
    }

    swap(str, min, i);
  }
  return str;
}

// Creates a new subject from a passed string requires external memory spaces
// to store the values
subject_t new_subject(const char *str, size_t len, char *lowered,
                      char *normalized) {
  subject_t result;

  result.len = len;

  result.lowered = lowered;
  strncpy(lowered, str, len + 1);
  to_lower(result.lowered, len);

  result.normalized = normalized;
  strncpy(normalized, result.lowered, len + 1);
  sort(normalized, len);

  return result;
}

// Swaps the position of two characters in the passed indices.
void swap(char *str, size_t a, size_t b) {
  char aux = str[a];
  str[a] = str[b];
  str[b] = aux;
}
