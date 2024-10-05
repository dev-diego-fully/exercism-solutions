//@ts-check
/**
 * 
 * @param {string} letter 
 * @param {Object<number, string[]>} letterScoreMaps
 * @returns {number}
 */
function scoreOf(letter, letterScoreMaps) {
  for (const score of Object.keys(letterScoreMaps)) {
    if (letterScoreMaps[score]?.includes(letter)) {
      return Number(score);
    }
  }
  throw new Error();
}

export const transform = (letterScoreMaps) => {
  const transformed = {};

  return Object.values(letterScoreMaps)
    .reduce(
      (transformed, scoredLetters) => {
        scoredLetters.reduce(
          (transformed, letter) => {
            transformed[letter.toLowerCase()] = scoreOf(letter, letterScoreMaps);
            return transformed;
          },
          transformed);

        return transformed;
      },
      transformed);
};
