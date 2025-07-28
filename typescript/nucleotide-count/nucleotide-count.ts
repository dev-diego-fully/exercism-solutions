/**
 * Calculates the count of each valid nucleotide (A, C, G, T) in a DNA strand.
 *
 * This function processes a DNA `strand` string, counts the occurrences of each
 * valid nucleotide, and returns an object representing these counts. It throws an error
 * if any invalid character is found in the strand.
 *
 * @param strand The DNA strand as a string, e.g., "AGCTAGCT".
 * @returns An object (NucleotideCounter) where keys are nucleotides (A, C, G, T) and values are their counts.
 * @throws Error If the `strand` contains any character that is not a valid nucleotide (A, C, G, T).
 */
export function nucleotideCounts(strand: string): NucleotideCounter {
  return strand
    .split("")
    .reduce(countNucleotide, newNucletoideCounter());
}

/**
 * Checks if a given character is a valid DNA nucleotide (A, T, C, or G).
 *
 * This is a helper function used to validate characters within a DNA strand.
 *
 * @param candidate The character to validate.
 * @returns True if the character is a valid nucleotide, false otherwise.
 */
function isValidNucleotide(candidate: string): boolean {
  switch (candidate) {
    case "A":
    case "T":
    case "C":
    case "G":
      return true;
    default:
      return false;
  }
}

/**
 * @typedef {object} NucleotideCounter
 * @property {number} A - The count of Adenine nucleotides.
 * @property {number} T - The count of Thymine nucleotides.
 * @property {number} C - The count of Cytosine nucleotides.
 * @property {number} G - The count of Guanine nucleotides.
 */
type NucleotideCounter = { [nucleotide: string]: number };

/**
 * Reducer function used to count valid nucleotides in a strand.
 *
 * This function is designed to be used with `Array.prototype.reduce()`. It increments
 * the count for a valid `candidate` nucleotide in the `counter` object. If an
 * invalid nucleotide is encountered, it throws an error.
 *
 * @param counter The current `NucleotideCounter` object.
 * @param candidate The nucleotide character to count.
 * @returns The updated `NucleotideCounter` object.
 * @throws Error If the `candidate` is not a valid nucleotide.
 */
function countNucleotide(counter: NucleotideCounter, candidate: string): NucleotideCounter {
  if (!isValidNucleotide(candidate)) {
    throw new Error("Invalid nucleotide in strand");
  };

  counter[candidate]++;
  return counter;
}

/**
 * Initializes a new `NucleotideCounter` object with all nucleotide counts set to zero.
 *
 * This is a helper function to provide a starting point for nucleotide counting.
 *
 * @returns A new `NucleotideCounter` object with all counts set to 0.
 */
function newNucletoideCounter(): NucleotideCounter {
  return {
    A: 0,
    T: 0,
    C: 0,
    G: 0
  };
}