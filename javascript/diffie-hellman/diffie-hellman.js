//@ts-check

/**
 * 
 * @param {number} start 
 * @param {number} end
 * @yields {number} 
 */
function* range(start, end) {
  for (let i = start; i < end; i++) {
    yield i;
  }
}
const primesAt = (() => {
  const primes = [2];
  /**
   * 
   * @param {number} n
   * @returns {number[]} 
   */
  function primesAt(n) {
    const lastPrime = primes[primes.length - 1]
    if (lastPrime < n) {
      const neededPrimes = primesAt(Math.sqrt(n));
      const numberBeetwen = Array.from(range(lastPrime, n + 1));
      const newPrimes = numberBeetwen.filter(
        (candidate) => neededPrimes.every((p) => candidate % p !== 0)
      );
      primes.push(...newPrimes);
    }
    const firstNonLesserThan = primes.indexOf(primes.find((x) => x >= n));
    return primes.slice(0, firstNonLesserThan + 1);
  }
  return primesAt;
})();

/**
 * 
 * @param {number} x 
 * @returns {boolean}
 */
function isPrime(x) {
  return primesAt(Math.sqrt(x)).every((p) => x % p !== 0);
}

export class DiffieHellman {

  #p;
  #g;
  #a;
  /**
   * @param {number} p 
   * @param {number} g 
   */
  constructor(p, g) {
    if(!isPrime(p)) {
      throw new Error("Invalid value for prime p");
    }
    if(!isPrime(g)) {
      throw new Error("Invalid value for prime g");
    }
    this.#p = p;
    this.#g = g;
  }

  /**
   * 
   * @param {number} privateKey 
   * @returns {number}
   */
  getPublicKey(privateKey) {
    if(1 < privateKey && privateKey < this.#p) {
      return (this.#g ** privateKey) % this.#p;
    }
    throw new RangeError("Invalid value for private key");
  }

  /**
   * 
   * @param {number} theirPublicKey 
   * @param {number} myPrivateKey 
   * @returns {number}
   */
  getSecret(theirPublicKey, myPrivateKey) {
    return theirPublicKey ** myPrivateKey % this.#p;
  }
}
