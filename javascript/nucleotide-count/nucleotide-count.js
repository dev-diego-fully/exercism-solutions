//
// This is only a SKELETON file for the 'Nucleotide Count' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

/**
 * @typedef {"A" | "T" | "C" | "G"} Nucleotide
 * @typedef {[number, number, number, number]}
 */

/**
 * 
 * @returns {NucleotideCounter}
 */
function NucleotideCounter() {
  return [0, 0, 0, 0];
}

function nucleotidePosition(nucleotide) {
  return ["A", "C", "G", "T"].indexOf(nucleotide);
}

/**
 * 
 * @param {NucleotideCounter} counter 
 * @param {Nucleotide} nucleotide 
 * @returns 
 */
function addNucleotide(counter, nucleotide) {
  counter[nucleotidePosition(nucleotide)]++;
  return counter;
}

/**
 * 
 * @param {string} string 
 * @returns {boolean}
 */
function isNucleotide(string) {
  return ["A", "C", "G", "T"]
    .includes(string);
}

/**
 * 
 * @param {string} strand 
 */
export function countNucleotides(strand) {
  const splittedStrand = strand.split("");
  
  if(splittedStrand.every(isNucleotide)) {
    return splittedStrand
      .reduce(addNucleotide, NucleotideCounter())
      .join(" ");
  }

  throw new Error('Invalid nucleotide in strand');
}
