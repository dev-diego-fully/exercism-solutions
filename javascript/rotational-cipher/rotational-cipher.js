//@ts-check5
const alphabetSize = 26;
const lowerCaseStart = "a".charCodeAt(0);
const upperCaseStart = "A".charCodeAt(0);


/**
 * 
 * @param {string} char 
 * @returns {boolean}
 */
function isUpperCase(char) {
  return char.match(/[A-Z]/) !== null;
}

/**
 * 
 * @param {string} char 
 * @returns {boolean}
 */
function isLowerCase(char) {
  return char.match(/[a-z]/) !== null;
}

/**
 * @param {string} char 
 * @param {number} rotations 
 * @returns {string}
 */
function lowerCaseRotate(char, rotations) {
  const charCode = char.charCodeAt(0);
  const letterPosition = charCode - lowerCaseStart;
  const rotatePosition = (letterPosition + rotations) % alphabetSize;

  return String.fromCharCode(lowerCaseStart + rotatePosition);
}

/**
 * @param {string} char 
 * @param {number} rotations 
 * @returns 
 */
function upperCaseRotate(char, rotations) {
  const charCode = char.charCodeAt(0);
  const letterPosition = charCode - upperCaseStart;
  const rotatePosition = (letterPosition + rotations) % alphabetSize;

  return String.fromCharCode(upperCaseStart + rotatePosition);
}

/**
 * 
 * @param {string} char 
 * @returns {string}
 */
function letterRotate(char, rotations) {
  if(isLowerCase(char)) {
    return lowerCaseRotate(char, rotations);
  }
  if(isUpperCase(char)) {
    return upperCaseRotate(char, rotations);
  }
  return char
}

/**
 * 
 * @param {string} text 
 * @param {number} rotations 
 * @returns {string}
 */
export const rotate = (text, rotations) => {
  /**
   * @param {string} char 
   * @returns {string}
   */
  const rotator = (char) => letterRotate(char, rotations); 
  return text
    .split("")
    .map(rotator)
    .join("");
};
