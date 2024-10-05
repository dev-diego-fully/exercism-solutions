

/**
 * 
 * @param {string} sentenceA 
 * @param {string} sentenceB 
 * @returns {boolean}
 */
function anagramChecker(sentence) {
  const loweredSentence = sentence.toLowerCase();
  const sentenceLetters = loweredSentence.split("").sort().join("");

  return function(candidate) {
    const loweredCandidate = candidate.toLowerCase();
    
    if(loweredSentence == loweredCandidate) {
      return false;
    }

    const candidateLetters = loweredCandidate.split("").sort().join("");

    return sentenceLetters == candidateLetters;
  }
  
}

/**
 * 
 * @param {string} sentence 
 * @param {string[]} candidates 
 */
export const findAnagrams = (sentence, candidates) => {

  return candidates.filter(anagramChecker(sentence));
};
