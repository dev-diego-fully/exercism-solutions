#include "nth_prime.h"

#include <stdint.h>
#include <stdlib.h>

/** @brief Macro representing a boolean true value. */
#define TRUE 1

/** @brief Macro representing a boolean false value. */
#define FALSE 0

/** @brief The first prime number. */
const uint32_t FIRST_PRIME = 2;

/** @brief Step value used to iterate exclusively through odd numbers. */
const uint32_t ODD_STEP = 2;

/**
 * @brief Dynamically allocated list structure utilizing a flexible array
 * member.
 */
typedef struct {
  uint32_t len;
  uint32_t size;
  uint32_t list[];
} List;

List* List_create(uint32_t size);
short List_push(List* list, uint32_t value);
short List_is_full(const List* list);
void List_destroy(List* list);
List* create_prime_list(uint32_t count);
short is_prime_to_list(const List* list, uint32_t element);

uint32_t nth(uint32_t n) {
  if (n == 0) {
    return 0;
  }
  if (n == 1) {
    return FIRST_PRIME;
  }

  List* prime_list = create_prime_list(n);

  for (uint32_t current = FIRST_PRIME + 1; -1; current += ODD_STEP) {
    if (is_prime_to_list(prime_list, current)) {
      List_push(prime_list, current);
      if (List_is_full(prime_list)) {
        List_destroy(prime_list);
        return current;
      }
    }
  }

  List_destroy(prime_list);

  return 0;
}

/**
 * @brief Creates and initializes a list prepopulated with the first prime
 * number.
 *
 * @param count The maximum capacity of the prime list.
 * @return List* Pointer to the created List structure.
 */
List* create_prime_list(uint32_t count) {
  List* list = List_create(count);
  List_push(list, FIRST_PRIME);

  return list;
}

/**
 * @brief Checks whether a given candidate element is prime relative to elements
 * in the prime list.
 *
 * @param list Pointer to the List containing previously found prime numbers.
 * @param element Candidate value to test.
 * @return short TRUE if element is not divisible by any prime in the list;
 * FALSE otherwise.
 */
short is_prime_to_list(const List* list, uint32_t element) {
  for (uint32_t i = 0; i < list->len; i++) {
    const uint32_t current = list->list[i];

    if (element % current == 0) {
      return FALSE;
    }
  }

  return TRUE;
}

/**
 * @brief Allocates memory for a List structure and its trailing flexible array
 * member.
 *
 * @param size Capacity of the list.
 * @return List* Pointer to the newly allocated List structure.
 */
List* List_create(uint32_t size) {
  List* list = calloc(1, sizeof(List) + size * sizeof(uint32_t));
  list->size = size;

  return list;
}

/**
 * @brief Pushes a value to the end of the list if capacity allows.
 *
 * @param list Pointer to the List structure.
 * @param value Value to append.
 * @return short TRUE if insertion succeeded; FALSE if the list is full.
 */
short List_push(List* list, uint32_t value) {
  if (list->len < list->size) {
    list->list[list->len] = value;
    list->len++;

    return TRUE;
  } else {
    return FALSE;
  }
}

/**
 * @brief Checks if the list has reached its capacity.
 *
 * @param list Pointer to the List structure.
 * @return short TRUE if length is greater than or equal to size; FALSE
 * otherwise.
 */
short List_is_full(const List* list) { return list->len >= list->size; }

/**
 * @brief Frees the dynamically allocated memory for the List.
 *
 * @param list Pointer to the List structure to destroy.
 */
void List_destroy(List* list) { free(list); }