export const toRoman = (num: number) => {
  return expandNumber(num)
    .flatMap(([digit, position]) => parseToRomanDigit(digit, position))
    .join("");
};

function expandNumber(num: number): number[][] {
  return digits(num).map((digit, index, digits) => [
    digit,
    digits.length - index - 1,
  ]);
}

function parseToRomanDigit(digit: number, position: number) {
  return toRomanDigit[digit].map((value) => withPosition[position][value]);
}

const toRomanDigit: Record<number, number[]> = {
  0: [],
  1: [1],
  2: [1, 1],
  3: [1, 1, 1],
  4: [1, 5],
  5: [5],
  6: [5, 1],
  7: [5, 1, 1],
  8: [5, 1, 1, 1],
  9: [9],
} as const;

const withPosition: Record<number, Record<number, string>> = {
  0: { 1: "I", 5: "V", 9: "IX" },
  1: { 1: "X", 5: "L", 9: "XC" },
  2: { 1: "C", 5: "D", 9: "CM" },
  3: { 1: "M" },
} as const;

function digits(num: number): number[] {
  return String(num).split("").map(Number);
}
