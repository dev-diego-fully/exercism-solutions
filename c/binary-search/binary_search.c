#include "binary_search.h"

const int *do_binary_search(int value, const int *arr, const int start,
                            const int end);

const int *binary_search(int value, const int *arr, size_t length) {
  if (length == 0) {
    return NULL;
  }
  return do_binary_search(value, arr, 0, length);
}

const int *do_binary_search(int value, const int *arr, const int start,
                            const int end) {
  if (start > end) {
    return NULL;
  }
  const int middle = (start + end) / 2;
  if (arr[middle] == value) {
    return &arr[middle];
  }
  if (arr[middle] < value) {
    return do_binary_search(value, arr, middle + 1, end);
  }
  return do_binary_search(value, arr, start, middle - 1);
}