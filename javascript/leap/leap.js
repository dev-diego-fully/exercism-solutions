//
// This is only a SKELETON file for the 'Leap' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

//@ts-check

/**
 * 
 * @param {number} x 
 * @returns {object}
 */
const Is = ( x ) => {
  return {
    /**
     * 
     * @param {number} y 
     * @returns {boolean}
     */
    divisibleBy: ( y ) => x % y == 0,
    /**
     * 
     * @param {number} y 
     * @returns {boolean}
     */
    notDivisibleBy: ( y ) => x % y != 0
  }
} 

/**
 * 
 * @param {number} year
 * @return {boolean} 
 */
export const isLeap = (year) => {

  const isYear = Is( year );

  return (
    isYear.divisibleBy( 4 ) && 
    isYear.notDivisibleBy( 100 ) || isYear.divisibleBy( 400 )
  );

};