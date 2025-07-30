/**
 * Encodes a given plain text using the Atbash cipher.
 *
 * The Atbash cipher is a simple substitution cipher where the alphabet is
 * reversed. This function normalizes the input text by removing punctuation
 * and spaces, converting it to lowercase, and then encoding each character.
 * The output is grouped into blocks of 5 characters for readability.
 * Numbers remain unchanged.
 *
 * @param plainText The text to be encoded.
 * @returns The Atbash encoded cipher text, grouped by 5 characters.
 *
 * @example
 * encode('yes'); // Returns 'bvh'
 * encode('OMG'); // Returns 'lnt'
 * encode('Testing,1 2 3, testing.'); // Returns 'gvhgr mt123 gvhgr mt'
 */
export function encode(plainText: string): string {
  return (normalize(plainText)
    .match(ATBASH_GROUP) ?? [])
    .map(slice => slice.split("").map(encodeChar).join(""))
    .join(" ");
}

/**
 * Decodes a given Atbash cipher text back to plain text.
 *
 * This function removes spaces from the cipher text and then decodes each
 * character. Numbers remain unchanged.
 *
 * @param cipherText The Atbash encoded text to be decoded.
 * @returns The decoded plain text.
 *
 * @example
 * decode('vcvix rhn'); // Returns 'exercism'
 * decode('gvhgr mt123 gvhgr mt'); // Returns 'testing123testing'
 */
export function decode(cipherText: string): string {
  return cipherText
    .split("")
    .filter(c => c !== " ")
    .map(encodeChar)
    .join("");
}

/**
 * Normalizes a given string for Atbash encoding.
 *
 * This involves removing non-alphanumeric characters and converting
 * the entire string to lowercase.
 *
 * @param text The input string to normalize.
 * @returns The normalized string.
 */
function normalize(text: string): string {
  return text
    .replace(ENCODABLE_PATTERN, "")
    .toLowerCase();
}

/**
 * Encodes a single character using the Atbash cipher.
 *
 * Digits are returned as is. Letters are swapped with their
 * corresponding character from the reversed alphabet.
 *
 * @param char The character to encode.
 * @returns The Atbash encoded character.
 */
function encodeChar(char: string): string {
  if (isDigit(char)) {
    return char;
  }
  return REVERSE_ALHABET[ALPHABET.indexOf(char)];
}

/**
 * Checks if a given character is a digit (0-9).
 *
 * @param char The character to check.
 * @returns True if the character is a digit, false otherwise.
 */
function isDigit(char: string): boolean {
  return char >= '0' && char <= '9';
}

/**
 * @constant ALPHABET Represents the standard English alphabet in lowercase.
 */
const ALPHABET = "abcdefghijklmnopqrstuvwxyz";
/**
 * @constant REVERSE_ALHABET Represents the English alphabet in reverse order (lowercase).
 */
const REVERSE_ALHABET = "zyxwvutsrqponmlkjihgfedcba";
/**
 * @constant ENCODABLE_PATTERN A regular expression to match and remove any character that is NOT an alphanumeric character.
 */
const ENCODABLE_PATTERN = /[^a-zA-Z0-9]/g;
/**
 * @constant ATBASH_GROUP A regular expression to match sequences of 1 to 5 word characters (alphanumeric).
 * Used for grouping the encoded text.
 */
const ATBASH_GROUP = /\w{1,5}/g;