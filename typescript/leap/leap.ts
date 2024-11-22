function isDivisible(dividend: number, divisor: number): boolean {
  return dividend % divisor == 0;
}

export function isLeap(year: number): boolean {
  return (
    isDivisible(year, 4) && (!isDivisible(year, 100) || isDivisible(year, 400))
  );
}
