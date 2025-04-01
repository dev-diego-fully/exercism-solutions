// @ts-check

/***
 * Truncates the given string to 5 UTF-8 characters long
 * @param {string} input String to be truncated
 * @returns {string}
 */
export const truncate = (input) => {
  return [...input].slice(0, 5).join("");
};
