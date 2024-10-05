//@ts-check
//
// This is only a SKELETON file for the 'Resistor Color Trio' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

/**
 * @typedef {"ohms"|"kiloohms"|"megaohms"|"megaohms"|"gigaohms"} MetricOhms
 */

/**
 * 
 * @param {number} value 
 * @returns {[number, MetricOhms]}
 */
function toMetricOhms(value) {
  const [kilo, mega, giga] = [10 ** 3, 10 ** 6, 10 ** 9];
  if (value < kilo) {
    return [value, "ohms"];
  }
  if (value < mega) {
    return [value / kilo, "kiloohms"];
  }
  if (value < giga) {
    return [value / mega, "megaohms"];
  }
  return [value / giga, "gigaohms"];
}

export class ResistorColorTrio {

  static #colorsValues = Object.freeze([
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white"
  ]);

  static #colorValue(color) {
    return ResistorColorTrio
      .#colorsValues
      .indexOf(color);
  }

  #value;
  #unit;

  /**
   * 
   * @param {string[]} trio
   */
  constructor(trio) {
    const [a, b, c] = trio.map(ResistorColorTrio.#colorValue);
    
    if([a, b, c].includes(-1)) {
      throw new Error("/invalid color/");
    }
    
    [this.#value, this.#unit] = toMetricOhms((a * 10 + b) * (10 ** c));
  }

  get label() {
    return `Resistor value: ${this.#value} ${this.#unit}`;
  }
}
