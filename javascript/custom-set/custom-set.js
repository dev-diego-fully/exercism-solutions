//@ts-check

export class CustomSet {

  #elements = [];
  
  /**
   * 
   * @param {any[]} elements 
   */
  constructor(elements = []) {
    elements
      .forEach((item) => this.add(item));
  }

  /**
   * 
   * @returns {boolean}
   */
  empty() {
    return this.#elements.length === 0;
  }

  /**
   * 
   * @param {any} item 
   * @returns {boolean}
   */
  contains(item) {
    return this
      .#elements
      .includes(item);
  }

  /**
   * 
   * @param {any} item 
   * @returns {CustomSet}
   */
  add(item) {
    if (!this.contains(item)) {
      this.#elements.push(item);
    }
    return this;
  }

  /**
   * 
   * @param {CustomSet} other 
   * @returns {boolean}
   */
  subset(other) {
    return this.#elements
      .every((item) => other.contains(item));
  }

  /**
   * 
   * @param {CustomSet} other 
   * @returns {boolean}
   */
  disjoint(other) {
    return (
      this.#elements.every((element) => !other.contains(element)) &&
      other.#elements.every((element) => !this.contains(element))
    );
  }

  /**
   * 
   * @param {CustomSet} other 
   * @returns {boolean}
   */
  eql(other) {
    return this.subset(other) && other.subset(this);
  }

  /**
   * 
   * @param {CustomSet} other 
   * @returns {CustomSet}
   */
  union(other) {
    return new CustomSet([
      ...this.#elements,
      ...other.#elements
    ]);
  }

  /**
   * 
   * @param {CustomSet} other 
   * @returns {CustomSet}
   */
  intersection(other) {
    return new CustomSet(
      this
        .#elements
        .filter((element) => other.contains(element))
    );
  }

  /**
   * 
   * @param {CustomSet} other 
   * @returns {CustomSet}
   */
  difference(other) {
    return new CustomSet(
      this.#elements.filter((item) => !other.contains(item))
    );
  }
}
