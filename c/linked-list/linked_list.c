#include "linked_list.h"
#include <stdbool.h>
#include <stdlib.h>

// Represents a node of the doubly linked list.
// Stores a value and has a previous neighbor and a next neighbor.
typedef struct list_node {
  struct list_node *prev, *next;
  ll_data_t data;
} list_node_t;

// Represents a doubly linked list. Stores the count of elements, as well as a
// reference to the first and last nodes.
typedef struct list {
  struct list_node *first, *last;
  size_t count;
} list_t;

list_node_t *node_create(ll_data_t data, list_node_t *prev, list_node_t *next);
void node_destroy(list_node_t *node);
bool list_is_empty(const list_t *list);
bool list_is_single(const list_t *list);

// counts the items on a list
size_t list_count(const list_t *list) {
  if (list) {
    return list->count;
  }
  return 0;
}

// inserts item at back of a list
void list_push(list_t *list, ll_data_t item_data) {
  if (!list) {
    return;
  }
  list->count++;

  if (list_is_empty(list)) {
    list->last = node_create(item_data, NULL, NULL);
    list->first = list->last;
    return;
  }
  list->last->next = node_create(item_data, list->last, NULL);
  list->last = list->last->next;
}

// inserts item at front of a list
void list_unshift(list_t *list, ll_data_t item_data) {
  if (!list) {
    return;
  }
  list->count++;

  if (list_is_empty(list)) {
    list->first = node_create(item_data, NULL, NULL);
    list->last = list->first;
    return;
  }
  list->first->prev = node_create(item_data, NULL, list->first);
  list->first = list->first->prev;
}

// removes item from back of a list
ll_data_t list_pop(list_t *list) {
  if (!list || list_is_empty(list)) {
    return 0;
  }

  list->count--;

  list_node_t *popped = list->last;
  const ll_data_t popped_data = popped->data;
  // printf("Popping: %d\n", popped_data);

  if (list_is_single(list)) {
    list->first = NULL;
    list->last = NULL;
  } else {
    popped->prev->next = NULL;
    list->last = popped->prev;
  }

  node_destroy(popped);
  return popped_data;
}
// removes item from front of a list
ll_data_t list_shift(list_t *list) {
  if (!list || list_is_empty(list)) {
    return 0;
  }
  list->count--;

  list_node_t *shifted = list->first;
  const ll_data_t shifted_data = list->first->data;

  if (list_is_single(list)) {
    list->first = NULL;
    list->last = NULL;
  } else {
    shifted->next->prev = NULL;
    list->first = shifted->next;
  }

  node_destroy(shifted);
  return shifted_data;
}

// deletes a node that holds the matching data
void list_delete(list_t *list, ll_data_t data) {
  if (!list || list_is_empty(list)) {
    return;
  }
  for (list_node_t *cur = list->first; cur; cur = cur->next) {
    if (cur->data != data) {
      continue;
    }

    list->count--;
    list_node_t **prev = cur->prev ? &cur->prev->next : &list->first;
    list_node_t **next = cur->next ? &cur->next->prev : &list->last;
    *prev = cur->next;
    *next = cur->prev;
    node_destroy(cur);
    return;
  }
}

// constructs a new (empty) list
list_t *list_create() {
  list_t *list = calloc(1, sizeof(list_t));
  return list;
}

// destroys an entire list
// list will be a dangling pointer after calling this method on it
void list_destroy(list_t *list) {
  if (!list) {
    return;
  }

  for (list_node_t *cur = list->first; cur; cur = list->first) {
    list->first = cur->next;
    node_destroy(cur);
  }
  free(list);
}

// Check if the list is empty.
bool list_is_empty(const list_t *list) { return !list->first; }

// Checks if the list has only one element
bool list_is_single(const list_t *list) {
  return list->first == list->last && list->first;
}

// Create a new node that stores the passed value and has the given neighbors
list_node_t *node_create(ll_data_t data, list_node_t *prev, list_node_t *next) {
  list_node_t *node = malloc(sizeof(list_node_t));

  node->data = data;
  node->prev = prev;
  node->next = next;

  return node;
}

// Destroy the past without destroying your neighbors
void node_destroy(list_node_t *node) {
  if (node) {
    free(node);
  }
}