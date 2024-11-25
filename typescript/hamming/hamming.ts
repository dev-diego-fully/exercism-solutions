export function compute(left: string, right: string): number {
  const noDifferences = 0;
  if (left.length !== right.length) {
    throw new Error("DNA strands must be of equal length.");
  }
  return zip(left.split(""), right.split("")).reduce(updateHamming, noDifferences);
}

function updateHamming(
  currentHamming: number,
  [left, right]: [string, string]
) {
  return currentHamming + (left !== right ? 1 : 0);
}

function zip<T, U>(left: Array<T>, right: Array<U>): Array<[T, U]> {
  return left.map((value, index) => [value, right[index]]);
}
