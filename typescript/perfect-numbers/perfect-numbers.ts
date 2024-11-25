export function classify(num: number): string {
  if (!isNatural(num)) {
    throw new RangeError(
      "Classification is only possible for natural numbers."
    );
  }
  const divisorsSum = sumOf(divisorsOf(num));
  if (divisorsSum < num) {
    return numberCategories.deficient;
  }
  if (divisorsSum == num) {
    return numberCategories.perfect;
  }
  return numberCategories.abundant;
}

function isNatural(num: number): boolean {
  return num > 0 && num % 1 === 0;
}

function sumOf(values: number[]) {
  return values.reduce((sum, n) => sum + n, 0);
}

function divisorsOf(num: number): number[] {
  const divisors = [];
  for (const candidate of divisorCandidatesFor(num)) {
    if (num % candidate === 0) {
      divisors.push(candidate);
    }
  }
  return divisors;
}

function* divisorCandidatesFor(num: number) {
  for (let i = 0; i < num; i++) {
    yield i;
  }
}

const numberCategories = {
  deficient: "deficient",
  perfect: "perfect",
  abundant: "abundant",
} as const;
