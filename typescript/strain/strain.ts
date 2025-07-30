/**
 * Filters elements from a list, keeping only those for which the `keeper` function returns `true`.
 *
 * This function iterates through the provided list and builds a new list
 * containing only the elements that satisfy the condition defined by the `keeper` callback.
 * It's similar to `Array.prototype.filter()`.
 *
 * @template T The type of elements in the list.
 * @param list The input array to filter.
 * @param keeper A callback function that takes an element and returns `true` if the element should be kept, `false` otherwise.
 * @returns A new array containing only the elements that satisfied the `keeper` condition.
 *
 * @example
 * keep([1, 2, 3], (e: number) => e < 10);      // Returns [1, 2, 3]
 * keep([1, 2, 3], (e: number) => e % 2 === 1); // Returns [1, 3]
 * keep(['apple', 'banana'], (word: string) => word.length > 5); // Returns ['banana']
 */
export function keep<T>(list: T[], keeper: (element: T) => boolean): T[] {
  const result = [];

  for (const element of list) {
    if (keeper(element)) {
      result.push(element);
    }
  }

  return result;
}

/**
 * Filters elements from a list, discarding those for which the `discarder` function returns `true`.
 *
 * This function iterates through the provided list and builds a new list
 * containing only the elements that *do not* satisfy the condition defined by the `discarder` callback.
 * It's effectively the opposite of `keep` or `Array.prototype.filter()`.
 *
 * @template T The type of elements in the list.
 * @param list The input array to filter.
 * @param discarder A callback function that takes an element and returns `true` if the element should be discarded, `false` otherwise.
 * @returns A new array containing only the elements that *did not* satisfy the `discarder` condition.
 *
 * @example
 * discard([1, 2, 3], (e: number) => e > 10);      // Returns [1, 2, 3]
 * discard([1, 2, 3], (e: number) => e % 2 === 1); // Returns [2]
 * discard(['apple', 'banana'], (word: string) => word.indexOf('z') === 0); // Returns ['apple', 'banana']
 */
export function discard<T>(list: T[], discarder: (element: T) => boolean): T[] {
  const result = [];

  for (const element of list) {
    if (!discarder(element)) {
      result.push(element);
    }
  }

  return result;
}