//
// This is only a SKELETON file for the 'Resistor Color' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
//@ts-check

/**
 * 
 * @param {string} color 
 * @returns {number}
 */
export const colorCode = ( color ) => COLORS.indexOf( color );

export const COLORS = Object.freeze(
  [
    "black", "brown", "red", "orange", "yellow",
    "green", "blue", "violet", "grey", "white"
  ]
);
