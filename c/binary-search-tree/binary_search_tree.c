#include "binary_search_tree.h"
#include <stdlib.h>

// Groups a reference to a list, as well as counting the number of elements
// present in it.
typedef struct {
  size_t count;
  int *elements;
} list_t;

typedef node_t **nodeholder_t;

size_t count(const node_t *tree);
void do_sorted_data(const node_t *tree, list_t *list);
void insert(nodeholder_t tree, int data);

// Build a binary tree from the given elements. Does not load balance.
node_t *build_tree(const int *tree_data, size_t tree_data_len) {
  node_t *tree = NULL;

  for (size_t i = 0; i < tree_data_len; i++) {
    insert(&tree, tree_data[i]);
  }

  return tree;
}

// Destroy the given tree, destroying all its nodes in the process.Does not
// support trees with nodes that have not been dynamically allocated.
void free_tree(node_t *tree) {
  if (!tree) {
    return;
  }
  free_tree(tree->left);
  free_tree(tree->right);
  free(tree);
}

// Retrieves, in an ordered manner, all the elements of the given tree.
int *sorted_data(const node_t *tree) {
  const size_t len = count(tree);
  list_t list = {0, calloc(len, sizeof(int))};
  do_sorted_data(tree, &list);

  return list.elements;
}

void do_sorted_data(const node_t *tree, list_t *list) {
  if (!tree) {
    return;
  }
  do_sorted_data(tree->left, list);
  list->elements[list->count++] = tree->data;
  do_sorted_data(tree->right, list);
}

// Inserts a node correctly into the given tree.
void insert(nodeholder_t tree, int data) {
  nodeholder_t current = tree;

  while ((*current) != NULL) {
    if (data <= (*current)->data) {
      current = &((*current)->left);
    } else {
      current = &((*current)->right);
    }
  }

  *current = calloc(1, sizeof(node_t));
  (*current)->data = data;
}

// Returns the number of elements present in the tree.
size_t count(const node_t *tree) {
  if (!tree) {
    return 0;
  }
  return 1 + count(tree->left) + count(tree->right);
}
