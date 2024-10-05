//
// This is only a SKELETON file for the 'RNA Transcription' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
//@ts-check
const DNA_NUCLEOTIDES = Object.freeze( [ "G", "C", "T", "A" ] );
const RNA_NUCLEOTIDES = Object.freeze( [ "C", "G", "A", "U" ] );
/**
 * 
 * @param {string} dnaNucleotide 
 * @returns {string|undefined}
 */
const rnaComplement = ( dnaNucleotide ) => {
  return RNA_NUCLEOTIDES.at(
    DNA_NUCLEOTIDES.indexOf( dnaNucleotide )
  );
  
}
/**
 * 
 * @param {string} dnaSequence 
 * @returns {string}
 */
export const toRna = ( dnaSequence ) => {
  return dnaSequence.split( "" ).reduce(
    ( prevRna, nucleotide ) => prevRna + rnaComplement( nucleotide ),
    ""
  );
};