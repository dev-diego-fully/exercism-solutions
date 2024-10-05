//@ts-check

export class List {

  #elements;

  get #length() {
    return this.#elements.length;
  }

  /**
   * 
   * @param {any[]} elements 
   */
  constructor(elements = []) {
    this.#elements = [...elements];
  }

  /**
   * 
   * @param {List} other
   * @returns {"EQUAL"|"SUBLIST"|"SUPERLIST"|"UNEQUAL"} 
   */
  compare(other) {
    const aSublistOfB = this.#sublist(other);
    const bSublistOfA = other.#sublist(this);

    if (aSublistOfB && bSublistOfA) {
      return "EQUAL";
    }

    if (aSublistOfB) {
      return "SUBLIST";
    }

    if (bSublistOfA) {
      return "SUPERLIST";
    }

    return "UNEQUAL";
  }

  /**
   * 
   * @param {List} other
   * @returns {boolean} 
   */
  #sublist(other) {
    if (this.#length == 0) {
      return true;
    }

    if (this.#length > other.#length) {
      return false;
    }

    return Array
      .from((Array(other.#length + 1 - this.#length).keys()))
      .some((n) => other.#slice(n, this.#length).#equals(this));
  }

  /**
   * 
   * @param {number} start 
   * @param {number} len 
   * @returns {List}
   */
  #slice(start, len) {
    return new List(this.#elements.slice(start, start + len));
  }

  /**
   * 
   * @param {List} other 
   * @returns {boolean}
   */
  #equals(other) {
    for(let i = 0; i < this.#length; i++) {
      if(other.#elements[i] != this.#elements[i]) {
        return false;
      }
    }
    return true;
  }

}