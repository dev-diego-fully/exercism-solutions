// @ts-check

/**
 * Determine how many cards of a certain type there are in the deck
 *
 * @param {number[]} stack
 * @param {number} card
 *
 * @returns {number} number of cards of a single type there are in the deck
 */
export function cardTypeCheck(stack, card) {
  
  let count = 0;

  stack.forEach( ( elem ) => count += elem === card ? 1 : 0  );

  return count;

}

/**
 * Determine how many cards are odd or even
 *
 * @param {number[]} stack
 * @param {boolean} type the type of value to check for - odd or even
 * @returns {number} number of cards that are either odd or even (depending on `type`)
 */
export function determineOddEvenCards(stack, type) {
  
  /**
   * 
   * @param {number} a 
   * @param {boolean} b 
   * @returns {boolean}
   */
  const evenMatchs = ( a, b ) => (a % 2 === 0) === b;
  let count = 0;

  for( const card of stack ) {

    if( evenMatchs( card, type ) )
      count++;

  }

  return count;


}
