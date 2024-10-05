//@ts-check
const NicomachusCategory = Object.freeze({
  PERFECT: "perfect",
  ABUDANT: "abundant",
  DEFICIENT: "deficient"
});

/**
 * 
 * @param {number} x 
 * @returns {boolean}
 */
function isNatural(x) {
  return Number.isInteger(x) && x > 0;
}

/**
 * 
 * @param {number} value 
 */
function aliquote(value) {
  const aliquote = [];

  for (let integer = 1; integer <= value/2; integer++) {
    const div = value / integer;

    if(isNatural(div)) {
      aliquote.push(integer);
    }

  }

  return aliquote;

}

/**
 * 
 * @param {number} value 
 * @returns {string}
 */
export const classify = (value) => {

  if (!isNatural(value)) {
    throw new Error("Classification is only possible for natural numbers.");
  }

  const aliquoteSum = aliquote(value)
    .reduce((acc, value) => acc + value, 0);

  if (aliquoteSum == value) {
    return NicomachusCategory.PERFECT;
  }

  if (aliquoteSum > value) {
    return NicomachusCategory.ABUDANT;
  }

  return NicomachusCategory.DEFICIENT;

};
