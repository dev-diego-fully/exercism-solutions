//@ts-check
/**
 * @typedef {string} Codon
 * @typedef {string} Protein
 * @typedef {string} RNAStrand
 */


const ProteinMap = (() => {
  const ProteinMap = {};
  /**
   * @param {object} map 
   * @param {Protein} protein 
   * @param {...Codon} codons 
   */
  function register(map, protein, ...codons) {
    codons.forEach(
      (codon) => {
        map[codon] = protein
      }
    )
  }

  register(ProteinMap, "Methionine", "AUG");
  register(ProteinMap, "Phenylalanine", "UUU", "UUC");
  register(ProteinMap, "Leucine", "UUA", "UUG");
  register(ProteinMap, "Serine", "UCU", "UCC", "UCA", "UCG");
  register(ProteinMap, "Tyrosine", "UAU", "UAC");
  register(ProteinMap, "Cysteine", "UGU", "UGC");
  register(ProteinMap, "Tryptophan", "UGG");
  register(ProteinMap, "STOP", "UAA", "UAG", "UGA");

  Object.freeze(ProteinMap);

  return ProteinMap;
})();

/**
 * @param {Codon} codon 
 * @returns {Protein}
 */
function translateCodon(codon) {
  const protein = ProteinMap[codon];
  return protein ?? "INVALID";
}

/**
 * @returns {function(string):boolean}
 */
function nonStopped() {
  let stopped = false;
  /**
   * @param {Protein} protein
   * @returns {boolean}
   */
  return function (protein) {
    if (stopped) {
      return false;
    }

    if (protein === "STOP") {
      stopped = true;
      return false;
    }

    return true;
  }
}

/**
 * 
 * @param {RNAStrand} strand
 * @returns {Protein[]} 
 */
export const translate = (strand = "") => {
  if (strand == "") {
    return [];
  }
  return (strand
    .match(/.{1,3}/g) ?? [])
    .map(translateCodon)
    .filter(nonStopped())
    .map((codon) => {
      if(codon == "INVALID") {
        throw new Error("Invalid codon");
      }
      return codon;
    });
};
