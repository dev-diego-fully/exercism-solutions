//@ts-check

/**
 * 
 * @param {number} n
 * @yields {number} 
 */
function* naturals(n) {
  let current = 1;

  while (current <= n) {
    yield current++;
  }
}

/**
 * 
 * @param {number} n 
 * @returns {boolean}
 */
function isNatural(n) {
  return n > 0 && Number.isInteger(n);
}

/**
 * 
 * @param {number} n 
 * @returns {number}
 */
function square(n) {
  return Math.pow(n, 2);
}

/**
 * 
 * @param {number} a 
 * @param {number} b 
 * @returns {number}
 */
function sum(a, b) {
  return a + b;
}

export class Squares {

  #n;
  /**
   * 
   * @param {number} n 
   */
  constructor(n) {
    if (!isNatural(n)) {
      throw new Error("Valid only for natural numbers.");
    }
    this.#n = n;
  }

  get sumOfSquares() {
    return Array.from(naturals(this.#n))
      .map(square)
      .reduce(sum, 0);
  }

  get squareOfSum() {
    return square(
      Array.from(naturals(this.#n))
        .reduce(sum, 0)
    );
  }

  get difference() {
    return this.squareOfSum -this.sumOfSquares; 
  }
}