// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Determines how long it takes to prepare a certain juice.
 *
 * @param {string} name
 * @returns {number} time in minutes
 */
export function timeToMixJuice(name) {
  switch( name ) {
    case 'Pure Strawberry Joy':
      return  0.5;
    case 'Energizer':
      return 1.5;
    case 'Green Garden':
      return 1.5
    case 'Tropical Island':
      return 3
    case 'All or Nothing':
      return 5;
    default:
      return 2.5;
  }
}

/**
 * Calculates the number of limes that need to be cut
 * to reach a certain supply.
 *
 * @param {number} wedgesNeeded
 * @param {string[]} limes
 * @returns {number} number of limes cut
 */
export function limesToCut(wedgesNeeded, limes) {
  
  let actualNeeded = wedgesNeeded;
  let lemonsCutted = 0;

  while( actualNeeded > 0 && limes.length > 0 ) {
    actualNeeded -= wedgesFrom( `${limes.shift()}` );
    lemonsCutted++;
  }

  return lemonsCutted;

}

/**
 * 
 * @param {String} limeSize 
 * @returns {number}
 */
function wedgesFrom(limeSize) {
  switch( limeSize ) {
    case "small":
      return 6;
    case "medium":
      return 8;
    case "large":
      return 10;
    default:
      return 0;
  }
}

/**
 * Determines which juices still need to be prepared after the end of the shift.
 *
 * @param {number} timeLeft
 * @param {string[]} orders
 * @returns {string[]} remaining orders after the time is up
 */
export function remainingOrders(timeLeft, orders) {
  
  let currentLefting = timeLeft;

  while( currentLefting > 0 ) {
    currentLefting -= timeToMixJuice( `${orders.shift()}` );
  }

  return orders;

}
