// Provides a binary search tree as well as methods for its construction,
// destruction and for retrieving its elements in an orderly manner.
#ifndef BINARY_SEARCH_TREE_H
#define BINARY_SEARCH_TREE_H
#include <stddef.h>

// Represents a node in the search tree. It can also represent an entire tree
// using the starting node.
typedef struct node node_t;

struct node {
  node_t *right;
  node_t *left;
  int data;
};

// Build a binary tree from the given elements. Does not load balance.
node_t *build_tree(const int *tree_data, size_t tree_data_len);

// Destroy the given tree, destroying all its nodes in the process.Does not
// support trees with nodes that have not been dynamically allocated.
void free_tree(node_t *tree);

// Retrieves, in an ordered manner, all the elements of the given tree.
int *sorted_data(const node_t *tree);

#endif
