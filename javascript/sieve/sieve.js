//@ts-check

/**
 * 
 * @param {number} limit
 * @returns {number[]}
 */
export const primes = (limit) => {
  let candidates = Array
    .from(Array(limit + 1).keys())
    .splice(2);
  
  for(const num of candidates) {
    candidates = candidates.filter((candidate) => num == candidate || candidate % num != 0);
  }

  return candidates;

};