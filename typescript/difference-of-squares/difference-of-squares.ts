export class Squares {
  private squaresSum: number;
  private sumSquare: number;

  constructor(count: number) {
    this.sumSquare = sum(naturals(count)) ** 2;
    this.squaresSum = sum(naturals(count).map((x) => x ** 2));
  }

  get sumOfSquares(): number {
    return this.squaresSum;
  }

  get squareOfSum(): number {
    return this.sumSquare;
  }

  get difference(): number {
    return this.squareOfSum - this.sumOfSquares;
  }
}

function naturals(limit: number): Array<number> {
  return Array.from(Array(limit + 1).keys()).slice(1);
}

function sum(array: Array<number>): number {
  return array.reduce((sum, e) => sum + e);
}
