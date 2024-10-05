#include "high_scores.h"

#define TRUE 1
#define FALSE 0

int contains(const size_t *array, size_t array_len, size_t element);
size_t pick_index_of_highest(const int32_t *scores, size_t scores_len,
                             size_t *ignored_indexes,
                             size_t ignored_indexes_len);

int32_t latest(const int32_t *scores, size_t scores_len) {
  return scores[scores_len - 1];
}

int32_t personal_best(const int32_t *scores, size_t scores_len) {
  int32_t best = scores[0];
  for (size_t i = 1; i < scores_len; i++) {
    if (scores[i] > best) {
      best = scores[i];
    }
  }
  return best;
}

size_t personal_top_three(const int32_t *scores, size_t scores_len,
                          int32_t *output) {
  size_t ignored_indexes[2] = {0, 0};

  for (size_t i = 0; i < 3; i++) {
    if (i >= scores_len) {
      return scores_len;
    }
    size_t picked =
        pick_index_of_highest(scores, scores_len, ignored_indexes, i);
    output[i] = scores[picked];
    ignored_indexes[i] = picked;
  }
  return 3;
}

size_t pick_index_of_highest(const int32_t *scores, size_t scores_len,
                             size_t *ignored_indexes,
                             size_t ignored_indexes_len) {
  size_t index_of_highest = scores_len;
  for (size_t i = 0; i < scores_len; i++) {
    if (contains(ignored_indexes, ignored_indexes_len, i)) {
      continue;
    }
    if (index_of_highest == scores_len ||
        scores[i] > scores[index_of_highest]) {
      index_of_highest = i;
    }
  }
  return index_of_highest;
}

int contains(const size_t *array, size_t array_len, size_t element) {
  for (size_t i = 0; i < array_len; i++) {
    if (array[i] == element) {
      return TRUE;
    }
  }
  return FALSE;
}