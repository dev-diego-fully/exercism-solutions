//@ts-check
/**
 * @typedef {Number[]} NumberCombination
 */

export class Series {
  #series;

  /**
   * @param {string} series 
   */
  constructor(series) {
    if (series.length == 0) {
      throw new Error("series cannot be empty");
    }
    this.#series = Object.freeze(series.split("").map(Number));
  }

  /**
   * @param {number} sliceLength
   * @returns {NumberCombination[]} 
   */
  slices(sliceLength) {
    if (sliceLength == 0) {
      throw new RangeError("slice length cannot be zero");
    }
    if (sliceLength < 0) {
      throw new RangeError("slice length cannot be negative");
    }
    if (sliceLength > this.#series.length) {
      throw new RangeError("slice length cannot be greater than series length");
    }

    const seriesLastStart = this.#series.length - sliceLength;
    const combinations = [];

    for (let i = 0; i <= seriesLastStart; i++) {
      const combinationStart = i;
      const combinationEnd = combinationStart + sliceLength;

      combinations.push(this.#series.slice(combinationStart, combinationEnd));
    }

    return combinations;
  }
}
