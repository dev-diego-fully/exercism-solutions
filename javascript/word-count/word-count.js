//
// This is only a SKELETON file for the 'Word Count' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

/**
 * 
 * @param {String} string
 * @param {Object} 
 */
export const countWords = (string) => {
  const splitPattern = /[^\w|\']/;
  
  return string
    .toLowerCase()
    .split(splitPattern)
    .filter(isNonEmptyString)
    .map(removeQuotation)
    .reduce(countWord, {})
};

/**
 * 
 * @param {Object} counter 
 * @param {string} word 
 * @returns {Object}
 */
function countWord(counter, word) {
  counter[word] = (counter[word] ?? 0) + 1;

  return counter;
}

/**
 * 
 * @param {String} string
 * @returns {String}
 */
function removeQuotation(string) {
  const [start, end] = [string.at(0), string.at(string.length - 1)];
  if(start != end) {
    return string;
  }
  if(start == "\"" | start == "\'") {
    return string.substring(1, string.length - 1);
  }
  return string;
}

/**
 * 
 * @param {string} string 
 * @returns {boolean}
 */
function isNonEmptyString(string) {
  return string !== "";
}