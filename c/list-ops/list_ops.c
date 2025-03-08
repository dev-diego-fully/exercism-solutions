#include "list_ops.h"

#include <string.h>

list_t *new_list(size_t length, list_element_t elements[]) {
  const size_t total_size = sizeof(list_t) + length * sizeof(list_element_t);
  list_t *new = malloc(total_size);

  if (!new) {
    return NULL;
  }

  memset(new, 0, total_size);

  new->length = length;

  for (size_t i = 0; i < length; i++) {
    new->elements[i] = elements[i];
  }

  return new;
}

list_t *append_list(list_t *list1, list_t *list2) {
  if (!list1 || !list2) {
    return NULL;
  }

  const size_t combined_length = list1->length + list2->length;
  list_element_t combined_elements[combined_length];

  for (size_t i = 0; i < list1->length; i++) {
    combined_elements[i] = list1->elements[i];
  }

  const size_t second_start = list1->length;
  for (size_t i = 0; i < list2->length; i++) {
    combined_elements[second_start + i] = list2->elements[i];
  }

  return new_list(combined_length, combined_elements);
}

list_t *filter_list(list_t *list, bool (*filter)(list_element_t)) {
  if (!list) {
    return NULL;
  }

  const size_t max_elements = list->length;
  size_t filtered_count = 0;
  list_element_t filtered[list->length];

  for (size_t i = 0; i < max_elements; i++) {
    list_element_t current = list->elements[i];
    if (filter(current)) {
      filtered[filtered_count] = current;
      filtered_count++;
    }
  }

  return new_list(filtered_count, filtered);
}

size_t length_list(list_t *list) {
  if (!list) {
    return 0;
  }

  return list->length;
}

list_t *map_list(list_t *list, list_element_t (*map)(list_element_t)) {
  if (!list) {
    return NULL;
  }

  const size_t len = list->length;
  list_element_t mapped[len];

  for (size_t i = 0; i < len; i++) {
    mapped[i] = map(list->elements[i]);
  }

  return new_list(len, mapped);
}

// folds (reduces) the given list from the left with a function
list_element_t foldl_list(list_t *list, list_element_t initial,
                          list_element_t (*foldl)(list_element_t,
                                                  list_element_t)) {
  if (!list) {
    return initial;
  }

  list_element_t current_value = initial;
  size_t len = list->length;

  for (size_t i = 0; i < len; i++) {
    current_value = foldl(current_value, list->elements[i]);
  }

  return current_value;
}

list_element_t foldr_list(list_t *list, list_element_t initial,
                          list_element_t (*foldr)(list_element_t,
                                                  list_element_t)) {
  if (!list) {
    return initial;
  }

  list_element_t current_value = initial;
  size_t len = list->length;

  for (size_t i = 0; i < len; i++) {
    current_value = foldr(list->elements[len - i - 1], current_value);
  }

  return current_value;
}

list_t *reverse_list(list_t *list) {
  const size_t len = list->length;
  list_element_t reversed_elements[len];

  for (size_t i = 0; i < len; i++) {
    reversed_elements[i] = list->elements[len - i - 1];
  }

  return new_list(len, reversed_elements);
}

void delete_list(list_t *list) {
  if (list) {
    free(list);
  }
}
