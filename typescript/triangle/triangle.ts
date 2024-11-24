export class Triangle {
  public static satisfyInequalities(a: number, b: number, c: number): boolean {
    return [
      [a, b, c],
      [a, c, b],
      [b, c, a],
    ].every(([a, b, c]) => a + b >= c);
  }

  private _a: number;
  private _b: number;
  private _c: number;
  private isTriangle: boolean;

  constructor(a: number, b: number, c: number) {
    [this._a, this._b, this._c] = [a, b, c];
    this.isTriangle =
      [a, b, c].every((x) => x > 0) && Triangle.satisfyInequalities(a, b, c);
  }

  get isEquilateral() {
    return this.isTriangle && this._a === this._b && this._b === this._c;
  }

  get isIsosceles() {
    return (
      this.isTriangle &&
      (this._a === this._b || this._a === this._c || this._b === this._c)
    );
  }

  get isScalene() {
    return (
      this.isTriangle &&
      this._a !== this._b &&
      this._a !== this._c &&
      this._b !== this._c
    );
  }
}
