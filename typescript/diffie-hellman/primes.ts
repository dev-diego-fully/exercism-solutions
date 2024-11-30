export function isPrime(n: number): boolean {
  return iteratorEvery(
    primesTo(Math.floor(Math.sqrt(n))),
    (p) => !isDivisible(n, p)
  );
}

function* primesTo(n: number): Generator<number, void, void> {
  if (n >= 2) {
    yield 2;
  }
  const previousPrimes = [2];
  for (let i = 3; i <= n; i += 2) {
    const limitCheck = Math.sqrt(i);
    if (previousPrimes.every((p) => p <= limitCheck && !isDivisible(i, p))) {
      previousPrimes.push(i);
      yield i;
    }
  }
}

function isDivisible(dividend: number, divisor: number): boolean {
  return dividend % divisor === 0;
}

function iteratorEvery<T>(
  iterator: Iterable<T>,
  checker: (val: T) => boolean
): boolean {
  for (const val of iterator) {
    if (!checker(val)) {
      return false;
    }
  }
  return true;
}
