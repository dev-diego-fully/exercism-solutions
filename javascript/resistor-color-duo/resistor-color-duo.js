//
// This is only a SKELETON file for the 'Resistor Color Duo' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
//@ts-check

const COLORS = Object.freeze( [
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
] );

/**
 * 
 * @param {string} color 
 * @returns {number|undefined}
 */
const decodeColor = ( color ) => {

  const value = COLORS.indexOf( color );

  return value !== -1 ? value : undefined;

} 

/**
 * 
 * @param {string[]} colors
 * @returns {number} 
 */
export const decodedValue = ( colors ) => {

  const firsPosition = 0;
  const secondPosition = 1;

  const firstColor = colors.at( firsPosition )?.toLowerCase();
  const secondColor = colors.at( secondPosition )?.toLowerCase();

  const valueOfFirst = decodeColor( String( firstColor ) );
  const valueOfSecond = decodeColor( String( secondColor ) );

  return Number(
    String( valueOfFirst ) + String( valueOfSecond ) 
  );

};
