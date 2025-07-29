/**
 * Applies a rotational cipher (Caesar cipher) to a given string.
 *
 * This function rotates each letter of the input string by a specified `key`.
 * The rotation is applied to both uppercase and lowercase letters,
 * while leaving numbers, spaces, and punctuation unchanged.
 *
 * @param raw The string to be encrypted.
 * @param key The number of positions to rotate each letter.
 * @returns The encrypted string.
 * @throws Error If the `key` is not an integer.
 *
 * @example
 * rotate('a', 1);   // Returns 'b'
 * rotate('OMG', 5); // Returns 'TRL'
 * rotate("Let's eat, Grandma!", 21); // Returns "Gzo'n zvo, Bmviyhv!"
 */
export function rotate(raw: string, key: number): string {
  if (!Number.isInteger(key)) {
    throw new Error();
  }
  return raw
    .split("")
    .map(char => rotateChar(char, key))
    .join("");
}

/**
 * Rotates a single character by a specified key.
 *
 * This is a helper function that determines if the character is an uppercase
 * or lowercase letter and applies the rotation accordingly. If the character
 * is not a letter, it is returned unchanged.
 *
 * @param char The character to rotate.
 * @param key The number of positions to rotate.
 * @returns The rotated character.
 */
function rotateChar(char: string, key: number): string {
  if (isLowerCase(char)) {
    const newIndex = rotateIndex(indexOfLower(char), key, ALPHABET_SIZE);
    return lowerCaseFromIndex(newIndex);
  }
  if (isUpperCase(char)) {
    const newIndex = rotateIndex(indexOfUpper(char), key, ALPHABET_SIZE);
    return upperCaseFromIndex(newIndex);
  }
  return char;
}

/**
 * Checks if a character is a lowercase letter (a-z).
 *
 * @param char The character to check.
 * @returns True if the character is a lowercase letter, false otherwise.
 */
function isLowerCase(char: string): boolean {
  return char >= "a" && char <= "z";
}

/**
 * Calculates the zero-based index of a lowercase letter.
 *
 * @param char The lowercase letter.
 * @returns The index of the letter (0 for 'a', 1 for 'b', etc.).
 */
function indexOfLower(char: string): number {
  return charCode(char) - charCode("a");
}

/**
 * Converts a zero-based index back to a lowercase letter.
 *
 * @param index The zero-based index (0-25).
 * @returns The corresponding lowercase letter.
 */
function lowerCaseFromIndex(index: number): string {
  const letter = charCode("a") + index;

  return String.fromCharCode(letter);
}

/**
 * Checks if a character is an uppercase letter (A-Z).
 *
 * @param char The character to check.
 * @returns True if the character is an uppercase letter, false otherwise.
 */
function isUpperCase(char: string): boolean {
  return char >= "A" && char <= "Z";
}

/**
 * Calculates the zero-based index of an uppercase letter.
 *
 * @param char The uppercase letter.
 * @returns The index of the letter (0 for 'A', 1 for 'B', etc.).
 */
function indexOfUpper(char: string): number {
  return charCode(char) - charCode("A");
}

/**
 * Converts a zero-based index back to an uppercase letter.
 *
 * @param index The zero-based index (0-25).
 * @returns The corresponding uppercase letter.
 */
function upperCaseFromIndex(index: number): string {
  const letter = charCode("A") + index;

  return String.fromCharCode(letter);
}

/**
 * Gets the Unicode value of a character.
 *
 * @param char The character.
 * @returns The Unicode value.
 */
function charCode(char: string): number {
  return char.charCodeAt(0);
}

/**
 * Calculates a new rotated index within a given length, handling wrap-around.
 *
 * @param index The original index.
 * @param rot The rotation amount.
 * @param len The size of the alphabet.
 * @returns The new rotated index.
 *
 * @example
 * rotateIndex(0, 1, 26); // Returns 1
 * rotateIndex(12, 13, 26); // Returns 25
 * rotateIndex(13, 13, 26); // Returns 0
 */
function rotateIndex(index: number, rot: number, len: number): number {
  return (index + rot) % len;
}

/**
 * @const ALPHABET_SIZE The number of letters in the English alphabet.
 */
const ALPHABET_SIZE = 26;