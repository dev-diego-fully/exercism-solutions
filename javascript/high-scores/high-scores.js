//@ts-check

export class HighScores {

  #scores;
  /**
   * 
   * @param {number[]} scores 
   */
  constructor(scores) {
    this.#scores = scores;
  }

  get scores() {
    return [...this.#scores];
  }

  get latest() {
    const last = this.#scores.length - 1;
    return this.#scores.at(last);
  }

  get personalBest() {
    return Math.max(...this.#scores);
  }

  get personalTopThree() {
    const [start, end] = [0, 3];
    /**
     * @param {number} a 
     * @param {number} b 
     * @returns {number}
     */
    const reversed = (a, b) => b - a;
    
    return [...this.#scores]
      .sort(reversed)
      .slice(start, end);
  }
}
