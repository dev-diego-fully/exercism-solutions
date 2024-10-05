//
// This is only a SKELETON file for the 'Collatz Conjecture' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

//@ts-check

/**
 * 
 * @param {number} x 
 * @returns {boolean}
 */
const isPositive = ( x ) => x > 0;

/**
 * 
 * @param {number} x 
 * @returns {boolean}
 */
const isInteger = Number.isInteger;

/**
 * 
 * @param {number} x 
 * @returns {boolean}
 */
const isPositiveInteger = ( x ) => ( isPositive( x ) && isInteger( x ) );

/**
 * 
 * @param {number} x 
 * @returns {boolean}
 */
const isEven = ( x ) => (x % 2 == 0);

/**
 * 
 * @param {number} x 
 * @returns {number}
 */
const collatz = ( x ) => {
  
  if( isEven( x ) )
    return x / 2;
  
  else
    return 3 * x + 1

};

const calculateCollatzSteps = ( x ) => {

  const noStep = 0;
  const oneStep = 1;
  const collatzStop = 1;

  if( x == collatzStop )
    return noStep;

  return oneStep + calculateCollatzSteps( collatz( x ) );

}


/**
 * 
 * @param {number} x
 * @returns {number} 
 */
export const steps = ( x ) => {

  if( !isPositiveInteger( x ) )
    throw new Error( "Only positive numbers are allowed" );

  return calculateCollatzSteps( x );

};
