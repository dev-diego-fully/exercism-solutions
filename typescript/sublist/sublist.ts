/**
 * List
 *
 * This class provides functionalities to compare lists, determining
 * if one is a sublist, superlist, equal, or unequal to another.
 * It encapsulates an array and offers methods for list comparisons and internal slicing.
 */
export class List {
  /**
   * @var elements The internal array that holds the elements of the list.
   */
  private elements: any[];

  /**
   * Creates a new List instance.
   *
   * @param elements The initial elements to populate the list.
   */
  constructor(...elements: any[]) {
    this.elements = elements;
  }

  /**
   * Compares this list with another list to determine their relationship.
   *
   * @param other The other List instance to compare against.
   * @returns A string indicating the relationship:
   * - "equal": if both lists contain the same elements in the same order.
   * - "sublist": if this list is a sublist of the `other` list, but not equal.
   * - "superlist": if this list is a superlist of the `other` list, but not equal.
   * - "unequal": if there is no sublist/superlist relationship between them.
   */
  public compare(other: List): string {
    const isSub = this.isSublist(other);
    const isSuper = other.isSublist(this);

    if (isSub && isSuper) {
      return "equal";
    } else if (isSub) {
      return "sublist";
    } else if (isSuper) {
      return "superlist";
    } else {
      return "unequal";
    }
  }

  /**
   * Checks if the list is empty.
   *
   * @returns True if the list contains no elements, false otherwise.
   */
  private isEmpty(): boolean {
    return this.length === 0;
  }

  /**
   * Checks if this list is a sublist of another list.
   *
   * An empty list is always considered a sublist of any other list.
   *
   * @param other The other List instance to check against.
   * @returns True if this list is a sublist of `other`, false otherwise.
   */
  private isSublist(other: List): boolean {
    if (this.isEmpty()) {
      return true;
    }
    if (other.isEmpty()) {
      return false;
    }

    for (const slice of other.slices(this.length)) {
      if (arrayCompare(this.elements, slice)) {
        return true;
      }
    }

    return false;
  }

  /**
   * Generates slices (sub-arrays) of the list with a specified length.
   *
   * It yields each possible contiguous sub-array of `sliceLen` from the `elements`.
   *
   * @param sliceLen The desired length of each slice.
   * @yields An array representing a slice of the list.
   */
  private *slices(sliceLen: number): Generator<any[], void, unknown> {
    const top = this.length - sliceLen + 1;

    for (const startIndex of range(0, top)) {
      const slice = this.slice(startIndex, sliceLen);
      yield slice;
    }
  }

  /**
   * Gets the current number of elements in the list.
   *
   * @returns The number of elements.
   */
  private get length(): number {
    return this.elements.length;
  }

  /**
   * Extracts a portion of the internal elements array.
   *
   * @param start The starting index of the slice (inclusive).
   * @param len The length of the slice.
   * @returns A new array containing the sliced elements.
   */
  private slice(start: number, len: number) {
    return this.elements.slice(start, start + len);
  }
}

/**
 * Compares two arrays for deep equality (same elements in the same order).
 *
 * @template T The type of elements in the arrays.
 * @param a The first array to compare.
 * @param b The second array to compare.
 * @returns True if the arrays are identical in content and order, false otherwise.
 */
function arrayCompare<T>(a: T[], b: T[]): boolean {
  if (a.length !== b.length) {
    return false;
  }

  for (const index of range(0, a.length)) {
    if (a[index] !== b[index]) {
      return false;
    }
  }

  return true;
}

/**
 * A generator function that yields a sequence of numbers within a specified range.
 *
 * It starts from `start`, increments by `step` (defaulting to 1), and continues
 * until `i` is no longer less than `end`.
 *
 * @param start The starting number of the sequence (inclusive).
 * @param end The ending number of the sequence (exclusive).
 * @param step The increment between numbers (defaults to 1).
 * @yields The next number in the sequence.
 */
function* range(start: number, end: number, step: number = 1): Generator<number, void, unknown> {
  for (let i = start; i < end; i += step) {
    yield i;
  }
}