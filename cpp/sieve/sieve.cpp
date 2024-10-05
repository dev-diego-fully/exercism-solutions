#include "sieve.h"

namespace sieve {

using PrimeMarker = std::vector<bool>;

std::vector<int> prime_candidates(const int limit) {
  std::vector<int> candidates;

  for (int i = 2; i <= limit; i++) {
    candidates.push_back(i);
  }

  return candidates;
}

void mark_divisible_as_non_prime(PrimeMarker &marks,
                                 const std::vector<int> &candidates,
                                 size_t candidate_index) {
  const int elem = candidates[candidate_index];
  for (size_t i = candidate_index + elem; i < marks.size(); i += elem) {
    marks[i] = false;
  }
}

std::vector<int> filter_markeds(std::vector<int> candidates,
                                PrimeMarker marks) {
  std::vector<int> markeds;
  for (size_t i = 0; i < candidates.size(); i++) {
    if (marks[i]) {
      markeds.push_back(candidates[i]);
    }
  }
  return markeds;
}

std::vector<int> primes(const unsigned int limit) {
  const std::vector<int> candidates = prime_candidates(limit);
  PrimeMarker marks(limit - 1, true);

  for (size_t i = 0; i < candidates.size(); i++) {
    const bool is_marked = marks[i];
    if (is_marked) {
      mark_divisible_as_non_prime(marks, candidates, i);
    }
  }

  return filter_markeds(candidates, marks);
}

} // namespace sieve
