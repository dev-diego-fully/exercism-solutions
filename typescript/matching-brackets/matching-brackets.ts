/**
 * Checks whether all brackets in the input string are correctly paired and nested.
 *
 * @param input - The string containing characters and brackets to evaluate.
 * @returns `true` if all brackets are properly matched and nested; otherwise, `false`.
 */
export function isPaired(input: string): boolean {
  const stack = [];

  for (const bracket of input) {
    if (isCloserBracket(bracket)) {
      const top = stack.pop() ?? "";

      if (!bracketCloses(top, bracket)) {
        return false;
      }

    } else if (isOpenerBracket(bracket)) {
      stack.push(bracket);
    }
  }

  return stack.length === 0;
}

/**
 * Bracket classification and validation utilities initialized for standard brackets: `()`, `[]`, and `{}`.
 */
const { isOpenerBracket, isCloserBracket, bracketCloses } = ((openBrackets: string[], closerBrackets: string[]) => {

  const OPENERS = new Set(openBrackets);
  const CLOSERS = new Set(closerBrackets);
  const OPEN_CLOSER_PAIRS = new Map(openBrackets.map((v, i) => [v, closerBrackets[i]]));

  function isOpenerBracket(bracket: string): boolean {
    return OPENERS.has(bracket);
  }

  function isCloserBracket(bracket: string): boolean {
    return CLOSERS.has(bracket);
  }

  function bracketCloses(openBracket: string, closerCandidate: string): boolean {
    return OPEN_CLOSER_PAIRS.get(openBracket) === closerCandidate;
  }

  return {
    isOpenerBracket, isCloserBracket,
    bracketCloses
  }

})(["(", "[", "{"], [")", "]", "}"]);