//@ts-check

export class List {

  #values;

  get values() {
    return [...this.#values];
  }

  /**
   * 
   * @param {any[]} values 
   */
  constructor(values = []) {
    this.#values = [...values];
  }

  /**
   * 
   * @param {List} otherList
   * @returns {List} 
   */
  append(otherList) {
    this.#values = [...this.#values, ...otherList.#values];
    return this;
  }

  /**
   * 
   * @param {List} otherList 
   * @returns {List}
   */
  concat(otherList) {
    let concatened = this.values;
    
    for(const element of otherList.#values) {
      if(element instanceof List) {
        concatened = [...concatened, ...element.#values];
      } else {
        concatened = [...concatened, element];
      }
    }

    return new List(concatened);
  }

  /**
   * 
   * @param {(value: any) => boolean} predicated 
   * @returns {List}
   */
  filter(predicated) {
    let filtreds = [];

    for(const value of this.#values) {
      if(predicated(value)) {
        filtreds = [...filtreds, value];
      }
    }

    return new List(filtreds);
  }

  /**
   * 
   * @param {(value: any) => any} operation 
   * @returns {List}
   */
  map(operation) {
    let mapped = [];
    
    for(const value of this.#values) {
      mapped = [...mapped, operation(value)];
    }

    return new List(mapped);
  }

  length() {
    let len = 0;

    for(const value of this.#values) {
      len++;
    }

    return len;
  }

  /**
   * 
   * @param {(acc: any, current: any) => any} operation
   * @returns {List}
   */
  foldl(operation, initialValue = this.#values[0]) {
    let acc = initialValue;

    for(const value of this.#values) {
      acc = operation(acc, value);
    }

    return acc;
  }

  /**
   * 
   * @param {(acc: any, current: any) => any} operation
   * @returns {List}
   */
  foldr(operation, initialValue = this.#values[this.#values.length - 1]) {
    let acc = initialValue;

    for(let i = this.#values.length - 1; i >= 0; i--) {
      acc = operation(acc, this.#values[i]);
    }

    return acc;
  }

  reverse() {
    let reversed = [];
    
    for(const value of this.#values) {
      reversed = [value, ...reversed];
    }

    return new List(reversed);
  }
}
