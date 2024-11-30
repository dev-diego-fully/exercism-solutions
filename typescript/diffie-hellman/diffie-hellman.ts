import { isPrime } from "./primes.ts";

export class DiffieHellman {
  private readonly p: number;
  private readonly g: number;

  constructor(p: number, g: number) {
    this.ensureValidPrimes(p, g);

    [this.p, this.g] = [p, g];
  }

  public getPublicKey(privateKey: number): number {
    this.ensureValidKey(privateKey);

    return this.g ** privateKey % this.p;
  }

  public getSecret(theirPublicKey: number, myPrivateKey: number): number {
    this.ensureValidKey(theirPublicKey);
    this.ensureValidKey(myPrivateKey);

    return theirPublicKey ** myPrivateKey % this.p;
  }

  private ensureValidPrimes(p: number, g: number) {
    if (p <= g) {
      throw new Error("p must be greater than g");
    }
    if (!isPrime(p)) {
      throw new Error("p must be a prime number");
    }
    if (!isPrime(g)) {
      throw new Error("g must be a prime number");
    }
  }

  private ensureValidKey(key: number) {
    if (key <= 1) {
      throw new Error("key must be greater than 1");
    }
    if (key >= this.p - 1) {
      throw new Error("key is not compatible with p");
    }
  }
}
