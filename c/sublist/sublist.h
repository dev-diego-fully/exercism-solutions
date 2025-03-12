// The module provides methods and data structures to classify the relationship
// between two lists into Equal, Unequal, Sublist and Superlist.
#ifndef SUBLIST_H
#define SUBLIST_H

#include <stddef.h>

// Represents the possible relationships between 2 lists.
typedef enum { EQUAL, UNEQUAL, SUBLIST, SUPERLIST } comparison_result_t;

// Checks and returns the relationship between the two passed lists
comparison_result_t check_lists(int *list_to_compare, int *base_list,
                                size_t list_to_compare_element_count,
                                size_t base_list_element_count);

#endif
