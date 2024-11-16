#include "diamond.h"

namespace diamond {

std::string row(char letter, int row_size);
bool should_add_letter(char letter, int row_size, int slot_index);
int letter_index(char letter);

const int invalid_as_letter = -1;

std::vector<std::string> rows(char limit_letter) {
  const int limit_value = letter_index(limit_letter);

  if (limit_letter == invalid_as_letter) {
    return {};
  }

  const int rows_count = (limit_value + 1) * 2 - 1;
  const int rows_size = rows_count;
  const int middle_way = rows_count / 2;
  std::vector<std::string> rows_;

  char letter = 'A';

  for (int i = 0; i < rows_count; i++) {
    rows_.push_back(row(letter, rows_size));
    letter += i < middle_way ? 1 : -1;
  }

  return rows_;
}

std::string row(char letter, int row_size) {
  const char filler = ' ';
  std::string row_;

  for (int i = 0; i < row_size; i++) {
    row_.push_back(should_add_letter(letter, row_size, i) ? letter : filler);
  }

  return row_;
}

bool should_add_letter(char letter, int row_size, int slot_index) {
  const int middle = row_size / 2;
  const int letter_index_ = letter_index(letter);

  return slot_index == (middle - letter_index_) ||
         slot_index == (middle + letter_index_);
}

int letter_index(char letter) {
  if (isupper(letter)) {
    return letter - 'A';
  }
  if (islower(letter)) {
    return letter - 'a';
  }
  return invalid_as_letter;
}

} // namespace diamond
