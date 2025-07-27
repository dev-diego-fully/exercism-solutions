/**
 * Performs a binary search to find the index of a target value within a sorted array.
 *
 * This function efficiently searches for a `needle` within a `haystack` array.
 * It repeatedly divides the search interval in half. If the value is found, its index is returned.
 * If the value is not present in the array, an error is thrown.
 * The input array **must be sorted** for this algorithm to work correctly.
 *
 * @template T The type of elements in the array.
 * @param haystack The sorted array to search within.
 * @param needle The value to search for.
 * @returns The index of the `needle` if found.
 * @throws Error If the `needle` is not found in the `haystack` array.
 */
export function find<T>(haystack: T[], needle: T): number {
  let [bot, top] = [0, haystack.length - 1];

  for (let middle = middleFor(bot, top); bot <= top; middle = middleFor(bot, top)) {
    const element = haystack[middle];

    if (element === needle) {
      return middle;

    } else if (element < needle) {
      bot = middle + 1;
      
    } else {
      top = middle - 1;
    }
  }

  throw new Error('Value not in array');
}

/**
 * Calculates the middle index between a 'bot' (bottom) and 'top' boundary.
 *
 * This is a helper function for binary search, ensuring the middle index
 * is always an integer by rounding down.
 *
 * @param bot The lower bound of the interval.
 * @param top The upper bound of the interval.
 * @returns The integer middle index.
 */
function middleFor(bot: number, top: number): number {
  return Math.floor((bot + top) / 2);
}