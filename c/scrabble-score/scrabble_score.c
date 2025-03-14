#include "scrabble_score.h"

#include <ctype.h>
#include <string.h>

unsigned int letter_score(char letter);

// Calculates the score of a given word in the game of scrabble
unsigned int score(const char *word) {
  static const unsigned int initial_score = 0;

  if (!word) {
    return initial_score;
  }

  const size_t word_len = strlen(word);
  unsigned int total_score = initial_score;

  for (size_t i = 0; i < word_len; i++) {
    const unsigned int cscore = letter_score(word[i]);
    total_score += cscore;
  }

  return total_score;
}

#define ALPHABET_LEN 26
// Calculates the index of a capital letter in the alphabet.
#define indexof(letter) letter - 'A'

// Stores the score of each letter
int scores[ALPHABET_LEN] = {
    [indexof('A')] = 1,  [indexof('E')] = 1, [indexof('I')] = 1,
    [indexof('O')] = 1,  [indexof('U')] = 1, [indexof('L')] = 1,
    [indexof('N')] = 1,  [indexof('R')] = 1, [indexof('S')] = 1,
    [indexof('T')] = 1,  [indexof('D')] = 2, [indexof('G')] = 2,
    [indexof('B')] = 3,  [indexof('C')] = 3, [indexof('M')] = 3,
    [indexof('P')] = 3,  [indexof('F')] = 4, [indexof('H')] = 4,
    [indexof('V')] = 4,  [indexof('W')] = 4, [indexof('Y')] = 4,
    [indexof('K')] = 5,  [indexof('J')] = 8, [indexof('X')] = 8,
    [indexof('Q')] = 10, [indexof('Z')] = 10};

// Calculates and returns the score of a letter in the scrabble game. If the
// character is not a letter, it returns 0.
unsigned int letter_score(char letter) {
  if (isupper(letter)) {
    return scores[indexof(letter)];
  }
  if (islower(letter)) {
    return scores[indexof(toupper(letter))];
  }
  static const unsigned int no_score = 0;
  return no_score;
}