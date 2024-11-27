export const eggCount = (displayValue: number): number => {
  let count: number = 0;

  for (const digit of binaryDigits(displayValue)) {
    count += digit;
  }

  return count;
};

function* binaryDigits(displayValue: number): Generator<number, void, void> {
  for (let i = displayValue; i > 0; i = Math.floor(i / 2)) {
    yield i % 2;
  }
}
