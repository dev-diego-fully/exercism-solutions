/**
 * Finds the largest product of a contiguous series of digits of a given length within a number string.
 *
 * This function validates the input, extracts all contiguous slices of a specified length,
 * calculates the product of the digits for each slice, and returns the maximum product found.
 *
 * @param num The string containing the digits.
 * @param span The length of the series of digits to consider.
 * @returns The largest product found.
 * @throws Error If `span` is negative, `span` is larger than the number string length, or the input string contains non-digit characters.
 *
 * @example
 * largestProduct('576802143', 2); // Returns 48 (from the slice '68')
 * largestProduct('1027839564', 3); // Returns 270 (from the slice '956')
 */
export function largestProduct(num: string, span: number): number {
  if (span < 0) {
    throw new Error("Span must not be negative");
  }
  if (span > num.length) {
    throw new Error("Span must be smaller than string length");
  }
  if (!isNumber(num)) {
    throw new Error("Digits input must only contain digits");
  }

  const multiplications = Array
    .from(slices(num, span))
    .map(digitsMultiplication);

  return Math.max(...multiplications);
}

/**
 * A generator function that produces contiguous slices of a string.
 *
 * It iterates through the `source` string and yields substrings of length `slicesLen`,
 * moving one character at a time.
 *
 * @param source The string to be sliced.
 * @param slicesLen The length of each slice.
 * @yields A string slice.
 */
function* slices(source: string, slicesLen: number): Generator<string, void, void> {
  const topLimit = source.length - slicesLen + 1;

  for (let i = 0; i < topLimit; i++) {
    yield source.slice(i, i + slicesLen);
  }
}

/**
 * Calculates the product of all digits in a string.
 *
 * The string is first split into individual characters, each is converted to a number,
 * and then all numbers are multiplied together.
 *
 * @param num The string of digits.
 * @returns The product of the digits.
 *
 * @example
 * digitsMultiplication('123'); // Returns 6
 * digitsMultiplication('576'); // Returns 210
 */
function digitsMultiplication(num: string): number {
  return num
    .split("")
    .map(Number)
    .reduce((prev, val) => prev * val);
}

/**
 * Checks if a string contains only digits (0-9).
 *
 * @param num The string to check.
 * @returns `true` if the string contains only digits, `false` otherwise.
 */
function isNumber(num: string): boolean {
  return !/[^0-9]/.test(num)
}