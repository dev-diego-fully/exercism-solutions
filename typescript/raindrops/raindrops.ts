export function convert(num: number): string {
  const sounds = raindrops
    .filter(({ divisor }) => isDivisible(num, divisor))
    .map(({ sound }) => sound);

  if (sounds.length != 0) {
    return sounds.join("");
  }

  return String(num);
}

function isDivisible(dividend: number, divisor: number): boolean {
  return dividend % divisor == 0;
}

const raindrops = [
  { sound: "Pling", divisor: 3 },
  { sound: "Plang", divisor: 5 },
  { sound: "Plong", divisor: 7 },
] as const;
