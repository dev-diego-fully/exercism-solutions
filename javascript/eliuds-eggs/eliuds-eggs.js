//@ts-check

/**
 * 
 * @param {number} displayValue
 * @returns {number} 
 */
export const eggCount = (displayValue) => {
  return (displayValue >>> 0)
    .toString(2)
    .split("")
    .filter(x => x === "1")
    .length
};
