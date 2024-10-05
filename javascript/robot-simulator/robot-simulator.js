//@ts-check

const directions = Object.freeze(
  ["north", "east", "south", "west"]
);


export class InvalidInputError extends Error {
  constructor(message) {
    super();
    this.message = message || 'Invalid Input';
  }
}

export class Robot {

  #x = 0;
  #y = 0;
  #direction = 0;

  get bearing() {
    return directions[this.#direction];
  }

  get coordinates() {
    return [this.#x, this.#y];
  }

  /**
   * 
   * @param {{x: number, y: number, direction: string}} param0 
   * @returns {Robot}
   */
  place({ x, y, direction }) {
    if (!directions.includes(direction)) {
      throw new InvalidInputError();
    }
    [this.#x, this.#y, this.#direction] = [x, y, directions.indexOf(direction)];
    return this;
  }

  /**
   * 
   * @param {string} instructions 
   */
  evaluate(instructions) {
    return instructions
      .split("")
      .forEach(
        (v) => {
          switch(v) {
            case "L":
              return this.#turnRight();
            case "R":
              return this.#turnLeft();
            case "A":
              return this.#advance();
            default:
              throw new InvalidInputError(v);
          }
        }
      )
  }

  #turnRight() {
    if(this.#direction == 0) {
      this.#direction = 3;
      return this;
    }
    this.#direction = (this.#direction - 1) % 4;
    return this;
  }

  #turnLeft() {
    this.#direction = (this.#direction + 1) % 4;
    return this;
  }

  #advance() {
    switch(directions[this.#direction]) {
      case "north":
        this.#y++;
        return this;
      case "east":
        this.#x++;
        return this;
      case "south":
        this.#y--;
        return this;
      case "west":
        this.#x--;
        return this;
      default:
        return this;
    }
  }

}
