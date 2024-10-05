/**
 * 
 * @param {string} sentence 
 * @returns {string}
 */
function getInitialOf(sentence) {
  const first = 0;

  return sentence
    .charAt(first)
    .toUpperCase();
}

/**
 * 
 * @param {string} sentence 
 * @returns {string}
 */
export const parse = (sentence) => {
  const splitPattern = /[\s-]+/;
  const omittedPattern = /[^a-zA-Z\s-]/g;
  const joinner = '';

  return sentence
    .replace(omittedPattern, "")
    .split(splitPattern)
    .map(getInitialOf)
    .join(joinner);
};
