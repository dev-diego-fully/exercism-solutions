#include "sublist.h"

#include <stdbool.h>

// Represents a portion of an integer list, using the size and starting index
typedef struct {
  const int *list;
  size_t start;
  size_t count;
} slice_t;

bool is_sublist(const slice_t *a, const slice_t *b);
bool match(const slice_t *a, const slice_t *b);

// Checks and returns the relationship between the two passed lists
comparison_result_t check_lists(int *slice_to_compare, int *base_list,
                                size_t slice_to_compare_element_count,
                                size_t base_list_element_count) {
  const slice_t a = {slice_to_compare, 0, slice_to_compare_element_count};
  const slice_t b = {base_list, 0, base_list_element_count};

  const bool is_a_sublist_b = is_sublist(&a, &b);
  const bool is_b_sublist_a = is_sublist(&b, &a);

  if (is_a_sublist_b == is_b_sublist_a) {
    return is_a_sublist_b ? EQUAL : UNEQUAL;
  }
  return is_a_sublist_b ? SUBLIST : SUPERLIST;
}

// Checks and returns whether the slice is a sublist of the second.
bool is_sublist(const slice_t *sub, const slice_t *super) {
  if (sub->count > super->count) {
    return false;
  }

  const size_t super_limit = super->count - sub->count;

  for (size_t i = 0; i <= super_limit; i++) {
    const slice_t super_slice = {super->list, i, sub->count};
    if (match(&super_slice, sub)) {
      return true;
    }
  }

  return false;
}

// checks if the elements of the first slice match the elements of the second
// slice (they are equal).
bool match(const slice_t *a, const slice_t *b) {
  const size_t limit = a->count < b->count ? a->count : b->count;

  for (size_t i = 0; i < limit; i++) {
    if (a->list[a->start + i] != b->list[b->start + i]) {
      return false;
    }
  }

  return true;
}