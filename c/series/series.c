#include "series.h"

#include <stdlib.h>
#include <string.h>

char **new_slice_array(size_t slices_size, size_t slices_count);
void copy_slice(const char *str, size_t start, size_t slice_len, char *slice);

slices_t slices(char *input_text, unsigned int substring_length) {
  const size_t length = strlen(input_text);
  const size_t limit = length - substring_length + 1;

  if (length < substring_length || substring_length < 1) {
    return (slices_t){0, NULL};
  }

  char **slices = new_slice_array(substring_length, limit);

  for (size_t i = 0; i < limit; i++) {
    copy_slice(input_text, i, substring_length, slices[i]);
  }

  return (slices_t){limit, slices};
}

// Creates an array of strings suitable for storing the series slices.
char **new_slice_array(size_t slices_size, size_t slices_count) {
  char **slices = calloc(slices_count, sizeof(char *));

  for (size_t i = 0; i < slices_count; i++) {
    slices[i] = calloc(1, slices_size);
  }

  return slices;
}

// Copies a slice of a string, starting at start and ending at slice + len, to
// the given "slice" buffer.
void copy_slice(const char *str, size_t start, size_t slice_len, char *slice) {
  strncpy(slice, &str[start], slice_len);
}