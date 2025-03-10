#include "sieve.h"

#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

const uint32_t FIRST_PRIME = 2;

// Non-prime marker. Manages which numbers are prime or not within the range [0,
// length).
typedef struct {
  size_t length;
  bool non_prime_marks[];
} marker_t;

bool is_prime(marker_t *marker, uint32_t number);
void mark_multiplies(marker_t *marker, uint32_t num);
uint32_t get_non_markeds(const marker_t *marker, uint32_t *output, size_t max);

void mark_as_non_prime(marker_t *marker, uint32_t number);
void mark_every(marker_t *marker, size_t every, size_t start);

marker_t *new_marker(size_t size);
void destroy_marker(marker_t *marker);

/// Calculate at most `max_primes` prime numbers in the interval [2,limit]
/// using the Sieve of Eratosthenes and store the prime numbers in `primes`
/// in increasing order.
/// The function returns the number of calculated primes.
uint32_t sieve(uint32_t limit, uint32_t *primes, size_t max_primes) {
  marker_t *marker = new_marker(limit + 1);

  for (uint32_t i = FIRST_PRIME; i <= limit / i; i += i > 2 ? 2 : 1) {
    if (!marker->non_prime_marks[i]) {
      mark_multiplies(marker, i);
    }
  }

  uint32_t count = get_non_markeds(marker, primes, max_primes);
  destroy_marker(marker);

  return count;
}

// Checks if the passed number is a prime according to the prime marker
bool is_prime(marker_t *marker, uint32_t number) {
  return !marker->non_prime_marks[number];
}

// Adds all unmarked elements to the output, without exceeding the max size.
uint32_t get_non_markeds(const marker_t *marker, uint32_t *output, size_t max) {
  uint32_t count = 0;

  for (size_t i = 0; count < max && i < marker->length; i++) {
    if (!marker->non_prime_marks[i]) {
      output[count++] = i;
    }
  }

  return count;
}

// Marks multiples of the passed value as non-prime.
void mark_multiplies(marker_t *marker, uint32_t number) {
  mark_every(marker, number, number * number);
}

// Mark the passed number as non-prime.
void mark_as_non_prime(marker_t *marker, uint32_t number) {
  marker->non_prime_marks[number] = true;
}

// Mark all elements from start, every every elements
void mark_every(marker_t *marker, size_t every, size_t start) {
  for (size_t i = start; i < marker->length; i += every) {
    mark_as_non_prime(marker, i);
  }
}

// Creates (allocates and initializes) a new prime marker with the desired size.
marker_t *new_marker(size_t size) {
  const size_t non_prime_marks_array_size = sizeof(bool) * size;
  marker_t *marker = malloc(sizeof(marker_t) + non_prime_marks_array_size);

  marker->length = size;
  memset(marker->non_prime_marks, 0, non_prime_marks_array_size);

  for (size_t i = 0; i < marker->length && i < FIRST_PRIME; i++) {
    marker->non_prime_marks[i] = true;
  }

  return marker;
}

// Destroys the passed marker (ideally created with new_marker)
void destroy_marker(marker_t *marker) { free(marker); }