/**
 * CustomSet
 *
 * This class implements a custom Set data structure using a `Map` internally.
 * It provides common set operations such as adding elements, checking for emptiness,
 * verifying containment, and performing set algebra (subset, disjoint, equality,
 * union, intersection, and difference).
 *
 * @template T The type of elements stored in the set.
 */
export class CustomSet<T> {
  /**
   * @var inner The internal Map used to store set elements. Keys are the elements,
   * and values are booleans (simply `true`) to indicate presence.
   */
  private inner: Map<T, boolean>;

  /**
   * Creates a new CustomSet instance.
   *
   * Optionally initializes the set with elements from an array.
   *
   * @param initial An optional array of elements to initialize the set with.
   */
  constructor(initial?: T[]) {
    this.inner = new Map();

    initial?.forEach((element) => this.add(element));
  }

  /**
   * Checks if the set is empty.
   *
   * @returns True if the set contains no elements, false otherwise.
   *
   * @example
   * new CustomSet().empty();     // Returns true
   * new CustomSet([1]).empty();  // Returns false
   */
  empty(): boolean {
    return this.inner.size === 0;
  }

  /**
   * Checks if the set contains a specific element.
   *
   * @param element The element to check for.
   * @returns True if the element is in the set, false otherwise.
   *
   * @example
   * new CustomSet([1, 2, 3]).contains(1); // Returns true
   * new CustomSet([1, 2, 3]).contains(4); // Returns false
   */
  contains(element: T): boolean {
    return this.inner.get(element) !== undefined;
  }

  /**
   * Adds an element to the set.
   *
   * If the element already exists, the set remains unchanged.
   *
   * @param element The element to add.
   * @returns The CustomSet instance, allowing for method chaining.
   *
   * @example
   * new CustomSet().add(3).eql(new CustomSet([3]));        // Returns true
   * new CustomSet([1, 2, 4]).add(3).eql(new CustomSet([1, 2, 3, 4])); // Returns true
   */
  add(element: T): CustomSet<T> {
    this.inner.set(element, true);

    return this;
  }

  /**
   * Checks if this set is a subset of another set.
   *
   * A set `A` is a subset of set `B` if all elements of `A` are also elements of `B`.
   *
   * @param other The other CustomSet to compare against.
   * @returns True if this set is a subset of `other`, false otherwise.
   *
   * @example
   * new CustomSet().subset(new CustomSet());          // Returns true (empty set is subset of itself)
   * new CustomSet([1, 2, 3]).subset(new CustomSet([4, 1, 2, 3])); // Returns true
   * new CustomSet([1, 2, 3]).subset(new CustomSet([4, 1, 3]));  // Returns false
   */
  subset(other: CustomSet<T>): boolean {
    return this.elements().every(element => other.contains(element));
  }

  /**
   * Checks if this set is disjoint from another set.
   *
   * Two sets are disjoint if they share no common elements (their intersection is empty).
   *
   * @param other The other CustomSet to compare against.
   * @returns True if the sets are disjoint, false otherwise.
   *
   * @example
   * new CustomSet([1, 2]).disjoint(new CustomSet([3, 4])); // Returns true
   * new CustomSet([1, 2]).disjoint(new CustomSet([2, 3])); // Returns false
   */
  disjoint(other: CustomSet<T>): boolean {
    return this.intersection(other).empty();
  }

  /**
   * Checks if this set is equal to another set.
   *
   * Two sets are equal if they contain exactly the same elements.
   * The order of elements does not matter.
   *
   * @param other The other CustomSet to compare with.
   * @returns True if the sets are equal, false otherwise.
   *
   * @example
   * new CustomSet([1, 2]).eql(new CustomSet([2, 1]));   // Returns true
   * new CustomSet([1, 2, 3]).eql(new CustomSet([1, 2, 4])); // Returns false
   */
  eql(other: CustomSet<T>): boolean {
    return this.subset(other) && other.subset(this);
  }

  /**
   * Returns a new set containing all unique elements from both this set and another set.
   *
   * This is the set union operation.
   *
   * @param other The other CustomSet to union with.
   * @returns A new CustomSet containing the union of elements.
   *
   * @example
   * new CustomSet([1, 3]).union(new CustomSet([2, 3])).eql(new CustomSet([1, 2, 3])); // Returns true
   * new CustomSet().union(new CustomSet([2])).eql(new CustomSet([2])); // Returns true
   */
  union(other: CustomSet<T>): CustomSet<T> {
    const sameElements = this.elements().concat(other.elements());

    return new CustomSet(sameElements);
  }

  /**
   * Returns a new set containing only the elements common to both this set and another set.
   *
   * This is the set intersection operation.
   *
   * @param other The other CustomSet to intersect with.
   * @returns A new CustomSet containing the intersection of elements.
   *
   * @example
   * new CustomSet([1, 2, 3, 4]).intersection(new CustomSet([3, 2, 5])).eql(new CustomSet([2, 3])); // Returns true
   * new CustomSet([1, 2, 3]).intersection(new CustomSet([4, 5, 6])).eql(new CustomSet([])); // Returns true
   */
  intersection(other: CustomSet<T>): CustomSet<T> {
    const intersectedElements = this
      .elements()
      .filter(element => other.contains(element));

    return new CustomSet(intersectedElements);
  }

  /**
   * Returns a new set containing elements that are in this set but not in another set.
   *
   * This is the set difference operation (A - B).
   *
   * @param other The other CustomSet to compare against for difference.
   * @returns A new CustomSet containing the difference of elements.
   *
   * @example
   * new CustomSet([3, 2, 1]).difference(new CustomSet([2, 4])).eql(new CustomSet([1, 3])); // Returns true
   * new CustomSet([1, 2, 3, 4]).difference(new CustomSet()).eql(new CustomSet([1, 2, 3, 4])); // Returns true
   */
  difference(other: CustomSet<T>): CustomSet<T> {
    const diffElements = this
      .elements()
      .filter(element => !other.contains(element));

    return new CustomSet(diffElements);
  }

  /**
   * Retrieves all elements currently stored in the set as an array.
   *
   * This is a private helper method for internal operations.
   *
   * @returns An array containing all elements of the set.
   */
  private elements(): T[] {
    return Array.from(this.inner.keys());
  }
}