/**
 * 
 * @param {object} appearences 
 * @param {string} c 
 * @returns {object}
 */
function registerAppearence(appearences, c) {
  appearences[c] = (appearences[c] ?? 0) + 1;
  return appearences;
};

/**
 * 
 * @param {number} v 
 * @returns {boolean}
 */
function isUnique(v) {
  return v <= 1;
}

/**
 * 
 * @param {string} sentence
 * @returns {boolean}
 */
export const isIsogram = (sentence) => {
  return Object
    .values(
      sentence
        .replace(/[^a-zA-Z]/g, "")
        .toLowerCase()
        .split("")
        .reduce(registerAppearence, {})
    )
    .every(isUnique);
};
