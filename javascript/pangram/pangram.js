//
// This is only a SKELETON file for the 'Pangram' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
//@ts-check

const letters = Object.freeze( "abcdefghijklmnopqrstuvwxyz".split( "" ) );

/**
 * 
 * @param {string} sentence 
 * @returns {boolean}
 */
export const isPangram = ( sentence ) => {

  const sentenceLetters = (
    sentence
      .replace( /\s/, "" )
      .toLowerCase()
      .split( "" )
  );
  
  return letters.every( ( letter ) => sentenceLetters.includes( letter ) );

};
