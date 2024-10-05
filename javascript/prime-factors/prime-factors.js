//@ts-check

/**
 * 
 * @param {number} number
 * @yields {number} 
 */
function* primesTo(number) {
  const previousPrimes = [];

  for (let i = 2; i <= number; i += 1 + (i >= 3 ? 1 : 0)) {
    if (previousPrimes.every(p => i % p !== 0)) {
      previousPrimes.push(i);
      yield i;
    }
  }
}

/**
 * 
 * @param {number} number 
 * @returns {boolean}
 */
function isPrime(number) {
  for(const prime of primesTo(Math.ceil(Math.sqrt(number)))) {
    if(number % prime === 0) {
      return false;
    }  
  }
  return true;
}

/**
 * 
 * @param {number} number
 * @returns {number[]}
 */
export const primeFactors = (number) => {
  const factors = [];
  const limit = Math.max(Math.ceil(Math.sqrt(number)), 3);
  let current = number;
  let last = 0;

  for (const prime of primesTo(limit + 1)) {
    if(current === 1) {
      break;
    }
    if(isPrime(current)) {
      factors.push(current);
      break;
    }
    while (current % prime === 0) {
      factors.push(prime);
      current /= prime;
    }
  }

  return factors;
};
