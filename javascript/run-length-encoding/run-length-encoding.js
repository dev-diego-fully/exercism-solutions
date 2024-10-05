//@ts-check
/**
 * @typedef {string} Char
 * @typedef {{char: Char, count: number}} CharNCount
 * @typedef {CharNCount[]} RunLengthStack
 */

/**
 * @param {Char} char 
 * @returns {CharNCount}
 */
function CharNCount(char, count = 1) {
  return {
    char: char,
    count: count
  }
}

/**
 * @param {string} str
 * @returns {CharNCount} 
 */
function CharNCountFrom(str) {
  const first = 0;
  const last = str.length - 1;

  const char = str.substring(last);
  const count = Number(str.substring(first, last)) || 1;

  return CharNCount(char, count);
}

/**
 * @returns {RunLengthStack}
 */
function RunLengthStack() {
  return [];
}


/**
 * @param {RunLengthStack} stack 
 * @param {Char} char
 * @returns {RunLengthStack} 
 */
function pushChar(stack, char) {
  const last = stack.length - 1;

  if (stack.length === 0 || stack[last].char !== char) {
    stack.push(CharNCount(char));
  } else {
    stack[last].count++;
  }

  return stack;
}

/**
 * @param {string} str
 * @returns {string}
 */
export const encode = (str) => {
  return str
    .split("")
    .reduce((stack, c) => pushChar(stack, c), RunLengthStack())
    .reduce(
      (encoded, lnc) => {
        const count = lnc.count > 1 ? String(lnc.count) : "";
        encoded += count + lnc.char;
        return encoded;
      },
      ""
    );
};

/**
 * 
 * @param {string} str 
 * @returns {string}
 */
export const decode = (str) => {
  const splitterPattern = /[\d]*[^\d]/g;
  
  return (str.match(splitterPattern) ?? [])
    .map(CharNCountFrom)
    .reduce(
      (decoded, lnc) => {
        decoded += lnc.char.repeat(lnc.count);
        return decoded;
      },
      ""
    );
};
