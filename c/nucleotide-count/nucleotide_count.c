#include "nucleotide_count.h"

#include <math.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * Formats the counts of nucleotides into a string.
 *
 * @param a Count of 'A' nucleotides.
 * @param c Count of 'C' nucleotides.
 * @param g Count of 'G' nucleotides.
 * @param t Count of 'T' nucleotides.
 * @return A formatted string with the counts.
 */
char *format_nucleotide_counts(size_t a, size_t c, size_t g, size_t t);

/**
 * Calculates the length of the formatted string.
 *
 * @param format The format string.
 * @param place_holder The placeholder string.
 * @param nucleotide_count The number of nucleotides.
 * @return The length of the formatted string.
 */
size_t formated_string_length(const char *format, const char *place_holder,
                              size_t nucleotide_count);

/**
 * Calculates the total length of a string repeated multiple times.
 *
 * @param str The string to repeat.
 * @param repetitions The number of repetitions.
 * @return The total length of the repeated string.
 */
size_t string_repetion_length(const char *str, size_t repetitions);

/**
 * Calculates the total space required for repeated size_t values.
 *
 * @param repetions The number of repetitions.
 * @return The total space required.
 */
size_t size_t_repetition_size(size_t repetions);

/**
 * Creates an empty string.
 *
 * @return A pointer to an empty string.
 */
char *empty_string();

char *count(const char *dna_strand) {
  if (dna_strand == NULL) {
    return NULL;
  }

  size_t a = 0, c = 0, g = 0, t = 0;
  const size_t strand_len = strlen(dna_strand);

  for (size_t i = 0; i < strand_len; i++) {
    switch (dna_strand[i]) {
    case 'A':
      a++;
      break;
    case 'T':
      t++;
      break;
    case 'C':
      c++;
      break;
    case 'G':
      g++;
      break;
    default:
      return empty_string();
    }
  }

  return format_nucleotide_counts(a, c, g, t);
}

char *format_nucleotide_counts(size_t a, size_t c, size_t g, size_t t) {
  static const char *counter_string_format = "A:%lu C:%lu G:%lu T:%lu";
  static const char *counter_placeholder = "%ld";
  static const size_t nucleotide_count = 4;

  const size_t formated_len = formated_string_length(
      counter_string_format, counter_placeholder, nucleotide_count);

  char *formated = (char *)calloc(formated_len, sizeof(char));

  if (formated == NULL) {
    return NULL;
  }

  snprintf(formated, formated_len, counter_string_format, a, c, g, t);

  return formated;
}

size_t formated_string_length(const char *format, const char *place_holder,
                              size_t nucleotide_count) {
  const size_t total_digits_space = size_t_repetition_size(nucleotide_count);
  const size_t format_string_len = strlen(format);
  const size_t total_placeholder_space =
      string_repetion_length(place_holder, nucleotide_count);

  return format_string_len - total_placeholder_space + total_digits_space;
}

size_t string_repetion_length(const char *str, size_t repetitions) {
  return strlen(str) * repetitions;
}

size_t size_t_repetition_size(size_t repetions) {
  const size_t size_t_max_digits = (size_t)log10(SIZE_MAX) + 1;
  return size_t_max_digits * repetions;
}

char *empty_string() { return calloc(1, sizeof(char)); }