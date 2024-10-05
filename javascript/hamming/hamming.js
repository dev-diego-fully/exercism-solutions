//
// This is only a SKELETON file for the 'Hamming' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

//@ts-check
/**
 * 
 * @param {string} collection1 
 * @param {string} collection2 
 * @param {number} index 
 * @returns {boolean}
 */
const pairCompare = ( collection1, collection2, index ) => {

  return collection1.at( index ) == collection2.at( index );

}


/**
 * 
 * @param {string} sequenceA 
 * @param {string} sequenceB
 * @returns {number}
 */
export const compute = ( sequenceA, sequenceB ) => {

  const hammingCalculationError = -1;

  if( sequenceA.length != sequenceB.length )
    throw new Error('strands must be of equal length')

  let hamming = 0;

  for( const charIndex in sequenceA.split( "" ) ) {
    
    if( !pairCompare( sequenceA, sequenceB, charIndex ) )
      hamming++;

  }

  return hamming;

};
