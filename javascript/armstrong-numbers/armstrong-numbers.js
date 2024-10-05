//@ts-check

/**
 * @param {number} num 
 * @returns {boolean}
 */
export const isArmstrongNumber = (num) => {
  const strNumber = num.toString();
  const digitNumber = strNumber.length;

  const digitsPowSum = strNumber
    .split("")
    .map(Number)
    .reduce((sum, n) => sum + n ** digitNumber, 0);
    
  return digitsPowSum == num;
};
