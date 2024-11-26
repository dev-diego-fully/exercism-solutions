export function isArmstrongNumber(num: number | bigint): boolean {
  return sumOfArmstrong(num) === BigInt(num);
}

function sumOfArmstrong(num: number | bigint): BigInt {
  const digits: number[] = digitsOf(num);
  const digitsCount: bigint = BigInt(digits.length);
  
  return digits.reduce(
    (sum, x) => sum + armstrongPow(x, digitsCount),
    BigInt(0)
  );
}

function armstrongPow(digit: number, digitsNumber: bigint): bigint {
  return BigInt(digit) ** digitsNumber;
}

function digitsOf(num: number | bigint): number[] {
  return String(num).split("").map(Number);
}
