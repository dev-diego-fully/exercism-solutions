/**
 * Represents a rational number (fraction) with a numerator and a denominator.
 *
 * This class provides methods for common arithmetic operations (addition,
 * subtraction, multiplication, division), absolute value, exponentiation,
 * and reduction to lowest terms. Rational numbers are always stored in their
 * simplest form after operations.
 */
export class Rational {
  /**
   * @var _denominator The denominator of the rational number.
   */
  private _denominator: number;
  /**
   * @var _numerator The numerator of the rational number.
   */
  private _numerator: number;

  /**
   * Creates a new Rational instance.
   *
   * Throws an error if the numerator or denominator are not integers.
   *
   * @param numerator The numerator of the rational number.
   * @param denominator The denominator of the rational number.
   * @throws Error If numerator or denominator are not integers.
   */
  constructor(numerator: number, denominator: number) {
    if (!Number.isInteger(numerator)) {
      throw new Error();
    }
    if (!Number.isInteger(denominator)) {
      throw new Error();
    }
    this._numerator = numerator;
    this._denominator = denominator;
  }

  /**
   * Gets the numerator of the rational number.
   *
   * @returns The numerator.
   */
  get numerator(): number {
    return this._numerator;
  }

  /**
   * Gets the denominator of the rational number.
   *
   * @returns The denominator.
   */
  get denominator(): number {
    return this._denominator;
  }

  /**
   * Adds this rational number to another rational number.
   *
   * The result is automatically reduced to its lowest terms.
   *
   * @param other The other rational number to add.
   * @returns A new Rational instance representing the sum.
   *
   * @example
   * new Rational(1, 2).add(new Rational(2, 3));    // Returns Rational(7, 6)
   * new Rational(1, 2).add(new Rational(-1, 2));   // Returns Rational(0, 1)
   */
  add(other: Rational): Rational {
    const ajustedThisNumerator = this.numerator * other.denominator;
    const ajustedOtherNumerator = other.numerator * this.denominator;

    const denominator = this.denominator * other.denominator;
    const numerator = ajustedThisNumerator + ajustedOtherNumerator;

    return (new Rational(numerator, denominator)).reduce();
  }

  /**
   * Subtracts another rational number from this rational number.
   *
   * The result is automatically reduced to its lowest terms.
   *
   * @param other The other rational number to subtract.
   * @returns A new Rational instance representing the difference.
   *
   * @example
   * new Rational(1, 2).sub(new Rational(2, 3));    // Returns Rational(-1, 6)
   * new Rational(1, 2).sub(new Rational(1, 2));    // Returns Rational(0, 1)
   */
  sub(other: Rational): Rational {
    const ajustedThisNumerator = this.numerator * other.denominator;
    const ajustedOtherNumerator = other.numerator * this.denominator;

    const denominator = this.denominator * other.denominator;
    const numerator = ajustedThisNumerator - ajustedOtherNumerator;

    return new Rational(numerator, denominator).reduce();
  }

  /**
   * Multiplies this rational number by another rational number.
   *
   * The result is automatically reduced to its lowest terms.
   *
   * @param other The other rational number to multiply by.
   * @returns A new Rational instance representing the product.
   *
   * @example
   * new Rational(1, 2).mul(new Rational(2, 3));    // Returns Rational(1, 3)
   * new Rational(1, 2).mul(new Rational(0, 1));    // Returns Rational(0, 1)
   */
  mul(other: Rational): Rational {
    const numerator = this.numerator * other.numerator;
    const denominator = this.denominator * other.denominator;

    return new Rational(numerator, denominator).reduce();
  }

  /**
   * Divides this rational number by another rational number.
   *
   * The result is automatically reduced to its lowest terms.
   *
   * @param other The other rational number to divide by.
   * @returns A new Rational instance representing the quotient.
   *
   * @example
   * new Rational(1, 2).div(new Rational(2, 3));    // Returns Rational(3, 4)
   * new Rational(1, 2).div(new Rational(-2, 3));   // Returns Rational(-3, 4)
   */
  div(other: Rational): Rational {
    const numerator = this.numerator * other.denominator;
    const denominator = other.numerator * this.denominator;

    return new Rational(numerator, denominator).reduce();
  }

  /**
   * Returns the absolute value of this rational number.
   *
   * The result is automatically reduced to its lowest terms.
   *
   * @returns A new Rational instance representing the absolute value.
   *
   * @example
   * new Rational(-1, 2).abs(); // Returns Rational(1, 2)
   * new Rational(0, 1).abs();  // Returns Rational(0, 1)
   */
  abs(): Rational {
    const numerator = Math.abs(this.numerator);
    const denominator = Math.abs(this.denominator);

    return new Rational(numerator, denominator).reduce();
  }

  /**
   * Raises this rational number to an integer power.
   *
   * Handles both positive and negative integer exponents. The result is automatically
   * reduced to its lowest terms.
   *
   * @param exp The integer exponent.
   * @returns A new Rational instance representing the result of the exponentiation.
   *
   * @example
   * new Rational(1, 2).exprational(3);     // Returns Rational(1, 8)
   * new Rational(3, 5).exprational(-2);    // Returns Rational(25, 9)
   * new Rational(0, 1).exprational(5);     // Returns Rational(0, 1)
   */
  exprational(exp: number): Rational {
    const m = Math.abs(exp);
    const top = this.numerator ** m;
    const bot = this.denominator ** m;

    if (exp >= 0) {
      return new Rational(top, bot).reduce();
    }
    return new Rational(bot, top).reduce();
  }

  /**
   * Raises a given real number base to the power of this rational number.
   *
   * @param base The real number base.
   * @returns The result of the exponentiation as a number.
   *
   * @example
   * new Rational(4, 3).expreal(8);  // Returns approximately 16.0
   * new Rational(-1, 2).expreal(9); // Returns approximately 1.0 / 3.0
   */
  expreal(base: number): number {
    return base ** (this.numerator / this.denominator);
  }

  /**
   * Reduces the rational number to its lowest terms.
   *
   * This involves dividing both the numerator and the denominator by their
   * greatest common divisor. Ensures the denominator is always positive.
   *
   * @returns A new Rational instance representing the reduced form.
   *
   * @example
   * new Rational(2, 4).reduce();     // Returns Rational(1, 2)
   * new Rational(-4, 6).reduce();    // Returns Rational(-2, 3)
   * new Rational(3, -9).reduce();    // Returns Rational(-1, 3)
   */
  reduce(): Rational {
    if (this.numerator === 0) {
      return new Rational(0, 1);
    }

    let currentDenominator = this.denominator;
    let currentNumerator = this.numerator;
    const factLimit = Math.min(
      Math.abs(this.numerator),
      Math.abs(this.denominator)
    );

    for (const factor of factors(factLimit)) {
      if (sharesFactors(currentNumerator, currentDenominator, factor)) {
        currentNumerator = currentNumerator / factor;
        currentDenominator = currentDenominator / factor;
      }
    }

    if (currentDenominator < 0) {
      return new Rational(-currentNumerator, -currentDenominator);
    }

    return new Rational(currentNumerator, currentDenominator);
  }
}

/**
 * A generator function that yields potential factors up to a given limit.
 *
 * It yields 2 (if limit allows) and then all integers from 0 up to the limit.
 * Note: This function yields all numbers, not just prime factors, for reduction.
 *
 * @param limit The upper bound for factors to yield (inclusive).
 * @yields The next potential factor.
 */
function* factors(limit: number): Generator<number, void, unknown> {
  const firstPrime = 2;

  if (limit > firstPrime) {
    yield firstPrime;
  }
  for (let i = 0; i <= limit; i++) {
    yield i;
  }
}

/**
 * Checks if two numbers share a given factor.
 *
 * @param a The first number.
 * @param b The second number.
 * @param factor The potential common factor.
 * @returns True if both `a` and `b` are divisible by `factor`, false otherwise.
 */
function sharesFactors(a: number, b: number, factor: number): boolean {
  return a % factor === 0 && b % factor === 0;
}