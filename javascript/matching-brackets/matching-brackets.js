//@ts-check
/**
 * @typedef {"bracket"| "curly"| "parentheses"} BracketType
 * @typedef {BracketType[]} BracketTypeStack
 * @typedef {function(BracketTypeStack, BracketType): boolean} BracketTypeStackOperation
 */

/**
 * @returns {BracketTypeStack}
 */
function BracketTypeStack() {
  return [];
}

/**
 * @param {BracketTypeStack} stack 
 * @param {BracketType} bracketType
 * @returns {true}
 */
function pushBracketType(stack, bracketType) {
  stack.push(bracketType);

  return true;
}

/**
 * @param {BracketTypeStack} stack 
 * @param {BracketType} bracketType
 * @returns {boolean}
 */
function popBracketType(stack, bracketType) {
  if (stackIsEmpty(stack)) {
    return false;
  }

  if (stackSeek(stack) != bracketType) {
    return false;
  }

  stack.pop();
  return true;
}

/**
 * @param {BracketTypeStack} stack 
 * @returns {BracketType}
 */
function stackSeek(stack) {
  return stack[stack.length - 1];
}

/**
 * @param {BracketTypeStack} stack 
 * @returns {boolean}
 */
function stackIsEmpty(stack) {
  return stack.length === 0;
}

/**
 * @param {string} bracket
 * @returns {[BracketType, BracketTypeStackOperation]}
 */
function bracketTypeAndOperation(bracket) {
  return {
    "{": ["curly", pushBracketType],
    "}": ["curly", popBracketType],
    "(": ["parentheses", pushBracketType],
    ")": ["parentheses", popBracketType],
    "[": ["square", pushBracketType],
    "]": ["square", popBracketType]
  }[bracket];
}

/**
 * @param {string} str 
 * @returns {boolean}
 */
export const isPaired = (str) => {
  const nonBrackets = /[^\[\]\{\}\(\)]/g;

  const brackets = str
    .replace(nonBrackets, "")
    .split("");
  const stack = BracketTypeStack();
  const fail = false;

  for (const bracket of brackets) {
    const [bracketType, operation] = bracketTypeAndOperation(bracket);

    if (operation(stack, bracketType) == fail) {
      return false;
    }
  }

  return stackIsEmpty(stack);
}
