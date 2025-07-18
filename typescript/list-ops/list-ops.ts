/**
 * A generic List implementation providing common collection operations.
 * This class aims to mimic some functional programming constructs for list manipulation.
 */
export class List<T> {
  private elements: T[];
  private count: number;

  /**
   * Creates a new List instance.
   * Initializes an empty list with a count of 0.
   */
  constructor() {
    this.elements = [];
    this.count = 0;
  }

  /**
   * A static factory method to create a new List from a variable number of arguments.
   *
   * @param values - The elements to initialize the list with.
   * @returns A new `List<T>` containing the provided elements.
   */
  public static create<T>(...values: T[]): List<T> {
    const created = new List<T>();

    for (const value of values) {
      created.push(value);
    }

    return created;
  }

  /**
   * Appends all elements from another list to the current list.
   * This operation creates a new list without modifying the original lists.
   *
   * @param other - The list to append.
   * @returns A new `List<T>` containing elements from both lists.
   */
  append(other: List<T>): List<T> {
    return List.create(...this.elements, ...other.elements);
  }

  /**
   * Concatenates multiple lists into a single new list.
   * The elements of the current list are included first, followed by
   * the elements of each list within the `lists` parameter, in order.
   *
   * @param lists - A `List` containing other `List` instances to concatenate.
   * @returns A new `List<T>` containing all concatenated elements.
   */
  concat(lists: List<List<T>>): List<T> {
    const concateds = List.create(...this.elements);

    for (const list of lists.elements) {
      for (const element of list.elements) {
        concateds.push(element);
      }
    }

    return concateds;
  }

  /**
   * Creates a new list containing only the elements that satisfy the provided predicate function.
   *
   * @param predicate - A function that returns `true` for elements to include, `false` otherwise.
   * @returns A new `List<T>` containing the filtered elements.
   */
  filter(predicate: (element: T) => boolean): List<T> {
    const filtered = new List<T>();

    for (const element of this.elements) {
      if (predicate(element)) {
        filtered.push(element);
      }
    }

    return filtered;
  }

  /**
   * Transforms each element in the list using the provided mapper function
   * and returns a new list with the transformed elements.
   *
   * @template U The type of the elements in the new list.
   * @param mapper - A function that transforms an element of type `T` into an element of type `U`.
   * @returns A new `List<U>` containing the mapped elements.
   */
  map<U>(mapper: (element: T) => U): List<U> {
    const mapped = new List<U>();

    for (const element of this.elements) {
      mapped.push(mapper(element));
    }

    return mapped;
  }

  /**
   * Reverses the order of the elements in the list and returns a new list.
   * The original list remains unchanged.
   *
   * @returns A new `List<T>` with the elements in reverse order.
   */
  reverse(): List<T> {
    const created = new List<T>();

    for (let i = this.count - 1; i >= 0; i--) {
      created.push(this.elements[i]);
    }

    return created;
  }

  /**
   * Applies a reducer function against an accumulator and each element in the list (from left to right)
   * to reduce it to a single value.
   *
   * @template U The type of the accumulated value.
   * @param reducer - A function that takes the accumulator and the current element, and returns the new accumulator value.
   * @param start - The initial value of the accumulator.
   * @returns The single accumulated value.
   */
  foldl<U>(reducer: (acc: U, current: T) => U, start: U): U {
    let result = start;

    for (const value of this.elements) {
      result = reducer(result, value);
    }

    return result;
  }

  /**
   * Applies a reducer function against an accumulator and each element in the list (from right to left)
   * to reduce it to a single value.
   *
   * @template U The type of the accumulated value.
   * @param reducer - A function that takes the accumulator and the current element, and returns the new accumulator value.
   * @param start - The initial value of the accumulator.
   * @returns The single accumulated value.
   */
  foldr<U>(reducer: (acc: U, current: T) => U, start: U): U {
    let result = start;

    for (let i = this.count - 1; i >= 0; i--) {
      result = reducer(result, this.elements[i]);
    }

    return result;
  }

  /**
   * Returns the number of elements in the list.
   *
   * @returns The current count of elements in the list.
   */
  length(): number {
    return this.count;
  }

  /**
   * Executes a provided function once for each list element.
   *
   * @param operation - The function to execute for each element.
   */
  forEach(operation: (element: T) => void) {
    for (const element of this.elements) {
      operation(element);
    }
  }

  /**
   * Adds an element to the end of the list.
   * This is a private helper method used internally by other list operations.
   *
   * @param element - The element to add.
   */
  private push(element: T) {
    this.elements[this.count] = element;
    this.count++;
  }

}