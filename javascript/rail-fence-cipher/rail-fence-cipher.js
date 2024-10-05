//@ts-check
/**
 * @param {string} text 
 * @returns {function(number): string}
 */
function charGetter(text) {
  return function (index) {
    return text.charAt(index);
  }
}

/**
 * @param {number} railsNumber 
 * @returns {function(number):number}
 */
function zigZagRailer(railsNumber = 2) {
  /**
   * @param {number} index
   * @returns {number}
   */
  function railer(index) {
    const zigZagLen = 2 * (railsNumber - 1);

    if (index >= zigZagLen) {
      return railer(index % zigZagLen);
    }
    if (index < railsNumber) {
      return index;
    }

    return zigZagLen - index;
  }
  return railer;
}

/**
   * @param {number[][]} rails
   * @param {number} railIndex 
   * @param {number} messageIndex
   * @returns {number[][]}
   */
function pushToRail(rails, railIndex, messageIndex) {
  if (!rails[railIndex]) {
    rails[railIndex] = [];
  }

  rails[railIndex].push(messageIndex);
  
  return rails;
}

/**
 * @param {any[]} array 
 * @param {any} value 
 * @param {number} index 
 */
function putOnArray(array, index, value) {
  array[index] = value;
  return array
}

/**
 * 
 * @param {number} messageLen 
 * @param {number} railsNumber 
 * @returns {number[]}
 */
function encoderReference(messageLen, railsNumber) {
  return Array
    .from(Array(messageLen).keys())
    .map(Number)
    .map(zigZagRailer(railsNumber))
    .reduce(pushToRail, [])
    .flat();
}

/**
 * @param {number} messageLen 
 * @param {number} railsNumber 
 * @returns {number[]}
 */
function decoderReference(messageLen, railsNumber) {
  const swapIndexWithValues = putOnArray;
  return encoderReference(messageLen, railsNumber)
    .reduce(swapIndexWithValues, [])
}

/**
 * @param {string} message 
 * @param {number} railsNumber
 * @returns {string}
 */
export const encode = (message, railsNumber) => {
  return encoderReference(message.length, railsNumber)
    .map(charGetter(message))
    .join("");
}

/**
 * @param {string} encoded 
 * @param {number} railsNumber
 * @returns {string}
 */
export const decode = (encoded, railsNumber) => {
  return decoderReference(encoded.length, railsNumber)
    .map(charGetter(encoded))
    .join("");
};
