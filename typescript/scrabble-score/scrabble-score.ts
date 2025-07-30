/**
 * Calculates the Scrabble score for a given word.
 *
 * Each letter in the word contributes to the total score based on predefined values.
 * The function is case-insensitive and handles empty or undefined inputs gracefully.
 *
 * @param word The word to be scored. Defaults to an empty string if not provided.
 * @returns The total Scrabble score for the word.
 *
 * @example
 * score('a');              // Returns 1
 * score('street');         // Returns 6
 * score('quirky');         // Returns 22
 * score('OXYPHENBUTAZONE'); // Returns 41
 */
export function score(word: string = ""): number {
  return word
    .split("")
    .map(letterScore)
    .reduce(sum, 0);
}

/**
 * Determines the Scrabble score for a single letter.
 *
 * The letter is converted to uppercase to ensure case-insensitive scoring.
 * If the letter is not found in the predefined score sets, it contributes 0.
 *
 * @param letter The letter to score.
 * @returns The Scrabble score for the letter.
 */
function letterScore(letter: string): number {
  const realLetter = letter.toUpperCase();

  for (const index in SCORES) {
    const score = Number(index);

    if (SCORES[score].has(realLetter)) {
      return score;
    }
  }

  return 0;
}

/**
 * A simple reduction function to sum two numbers.
 *
 * @param a The first number.
 * @param b The second number.
 * @returns The sum of `a` and `b`.
 */
const sum = (a: number, b: number): number => a + b;

/**
 * @constant SCORES
 * An object mapping Scrabble point values to sets of letters that correspond to that value.
 * This constant defines the scoring rules for each letter.
 */
const SCORES: Record<number, Set<string>> = {
  1: new Set(["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"]),
  2: new Set(["D", "G"]),
  3: new Set(["B", "C", "M", "P"]),
  4: new Set(["F", "H", "V", "W", "Y"]),
  5: new Set(["K"]),
  8: new Set(["J", "X"]),
  10: new Set(["Q", "Z"])
};