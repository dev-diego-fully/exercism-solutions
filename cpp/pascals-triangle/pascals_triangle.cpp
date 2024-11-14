#include "pascals_triangle.h"

namespace pascals_triangle {

std::vector<int> next_row(const std::vector<int> &current);

std::vector<std::vector<int>> generate_rows(int number) {

  if (number <= 0) {
    return {};
  }

  std::vector<std::vector<int>> rows{{1}};

  for (int i = 1; i < number; i++) {
    rows.push_back(next_row(rows[i - 1]));
  }

  return rows;
}

std::vector<int> next_row(const std::vector<int> &current) {
  std::vector<int> row{current[0]};

  for (size_t i = 1; i < current.size(); i++) {
    row.push_back(current[i - 1] + current[i]);
  }

  row.push_back(current[current.size() - 1]);

  return row;
}

} // namespace pascals_triangle
