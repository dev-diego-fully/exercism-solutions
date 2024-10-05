//
// This is only a SKELETON file for the 'Flatten Array' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

/**
 * 
 * @param {any[]} toFlat 
 * @returns {any[]}
 */
export const flatten = (toFlat) => {
  return toFlat
    .flat(Infinity)
    .filter((x) => x !== undefined && x !== null);
}