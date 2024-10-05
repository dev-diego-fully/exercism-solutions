// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * 
 * @param {any[]} a 
 * @param {any[]} b
 * @returns {boolean} 
 */
function arrayCompare( a, b ) {

  if( a.length != b.length ) {

    return false;

  }

  for( const key of a.keys() ) {

    if( a[ key ] != b[ key ] ) {

      return false;

    }

  }

  return true;


}

/**
 * Create a function that returns a function making use of a closure to
 * perform a repeatable 2d translation of a coordinate pair.
 *
 * @param {number} dx the translate x component
 * @param {number} dy the translate y component
 *
 * @returns {function(number, number):number[]} a function which takes an x, y parameter, returns the
 *  translated coordinate pair in the form [x, y]
 */
export function translate2d(dx, dy) {

  /**
   * @param {number} x
   * @param {number} y
   * @returns {number[]}
  */
  return (x, y) => {

    return [ x + dx, y + dy ];

  }

}

/**
 * Create a function that returns a function making use of a closure to
 * perform a repeatable 2d scale of a coordinate pair.
 *
 * @param {number} sx the amount to scale the x component
 * @param {number} sy the amount to scale the y component
 *
 * @returns {function(number, number):number[]} a function which takes an x, y parameter, returns the
 *  scaled coordinate pair in the form [x, y]
 */
export function scale2d(sx, sy) {
  
  /**
   * @param {number} x
   * @param {number} y
   * @return {number[]}
   */
  return (x, y) => {

    return [ x * sx, y * sy ];

  };

}

/**
 * Create a composition function that returns a function that combines two
 * functions to perform a repeatable transformation
 *
 * @param {function} f the first function to apply
 * @param {function} g the second function to apply
 *
 * @returns {function(number, number):number[]} a function which takes an x, y parameter, returns the
 *  transformed coordinate pair in the form [x, y]
 */
export function composeTransform(f, g) {

  /**
   * @param {number} x
   * @param {number} y
   * @returns {number[]}
   */
  return ( x, y ) => {

    return g( ...f( x, y ) );

  }

}

/**
 * Return a function that memoizes the last result.  If the arguments are the same as the last call,
 * then memoized result returned.
 *
 * @param {function} f the transformation function to memoize, assumes takes two arguments 'x' and 'y'
 *
 * @returns {function(number, number):number[]} a function which takes x and y arguments, and will either return the saved result
 *  if the arguments are the same on subsequent calls, or compute a new result if they are different.
 */
export function memoizeTransform(f) {
  
  let cachedInputs = [];
  let cachedOutput = undefined;
  const xIndex = 0;
  const yIndex = 1;

  /**
   * @param {number[]} inputs
   * @returns {number[]}
   */
  return ( ...inputs ) => {

    if( !arrayCompare( cachedInputs, inputs ) ) {

      cachedInputs = [ ...inputs ];
      cachedOutput = f( ...inputs );

    }

    return cachedOutput;

  }

}
