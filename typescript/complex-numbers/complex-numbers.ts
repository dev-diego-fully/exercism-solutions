/**
 * Represents a complex number with a real and an imaginary part.
 *
 * This class provides fundamental operations for complex numbers,
 * including arithmetic operations (addition, subtraction, multiplication, division),
 * calculating absolute value, conjugation, and exponentiation using Euler's formula.
 */
export class ComplexNumber {
  /**
   * @var _real The real component of the complex number.
   */
  private _real: number;
  /**
   * @var _imaginary The imaginary component of the complex number.
   */
  private _imaginary: number;

  /**
   * Creates a new ComplexNumber instance.
   *
   * @param real The real part of the complex number.
   * @param imaginary The imaginary part of the complex number.
   */
  constructor(real: number, imaginary: number) {
    this._real = real;
    this._imaginary = imaginary;
  }

  /**
   * Gets the real component of the complex number.
   *
   * @returns The real part.
   *
   * @example
   * new ComplexNumber(1, 2).real; // Returns 1
   */
  public get real(): number {
    return this._real;
  }

  /**
   * Gets the imaginary component of the complex number.
   *
   * @returns The imaginary part.
   *
   * @example
   * new ComplexNumber(1, 2).imag; // Returns 2
   */
  public get imag(): number {
    return this._imaginary;
  }

  /**
   * Adds this complex number to another complex number.
   *
   * @param other The other complex number to add.
   * @returns A new ComplexNumber instance representing the sum.
   *
   * @example
   * new ComplexNumber(1, 2).add(new ComplexNumber(3, 4)); // Returns ComplexNumber(4, 6)
   */
  public add(other: ComplexNumber): ComplexNumber {
    const real = this.real + other.real;
    const imag = this.imag + other.imag;

    return new ComplexNumber(real, imag);
  }

  /**
   * Subtracts another complex number from this complex number.
   *
   * @param other The other complex number to subtract.
   * @returns A new ComplexNumber instance representing the difference.
   *
   * @example
   * new ComplexNumber(1, 2).sub(new ComplexNumber(3, 4)); // Returns ComplexNumber(-2, -2)
   */
  public sub(other: ComplexNumber): ComplexNumber {
    const real = this.real - other.real;
    const imag = this.imag - other.imag;

    return new ComplexNumber(real, imag);
  }

  /**
   * Divides this complex number by another complex number.
   *
   * @param other The other complex number to divide by.
   * @returns A new ComplexNumber instance representing the quotient.
   *
   * @example
   * new ComplexNumber(1, 2).div(new ComplexNumber(3, 4)); // Returns ComplexNumber(0.44, 0.08)
   */
  public div(other: ComplexNumber): ComplexNumber {
    const denominator = other.real ** 2 + other.imag ** 2;
    const realNumerator = this.real * other.real + this.imag * other.imag;
    const imagNumerator = this.imag * other.real - this.real * other.imag;

    return new ComplexNumber(
      realNumerator / denominator,
      imagNumerator / denominator
    );
  }

  /**
   * Multiplies this complex number by another complex number.
   *
   * @param other The other complex number to multiply by.
   * @returns A new ComplexNumber instance representing the product.
   *
   * @example
   * new ComplexNumber(1, 2).mul(new ComplexNumber(3, 4)); // Returns ComplexNumber(-5, 10)
   * new ComplexNumber(0, 1).mul(new ComplexNumber(0, 1)); // Returns ComplexNumber(-1, 0) (i * i = -1)
   */
  public mul(other: ComplexNumber): ComplexNumber {
    const real = this.real * other.real - this.imag * other.imag;
    const imag = this.imag * other.real + this.real * other.imag;

    return new ComplexNumber(real, imag);
  }

  /**
   * Gets the absolute value (magnitude or modulus) of the complex number.
   *
   * Calculated as the square root of (real^2 + imaginary^2).
   *
   * @returns The absolute value as a number.
   *
   * @example
   * new ComplexNumber(3, 4).abs;  // Returns 5
   * new ComplexNumber(0, -5).abs; // Returns 5
   */
  public get abs(): number {
    return Math.sqrt(this.real ** 2 + this.imag ** 2);
  }

  /**
   * Gets the complex conjugate of this complex number.
   *
   * The conjugate of $a + bi$ is $a - bi$.
   *
   * @returns A new ComplexNumber instance representing the conjugate.
   *
   * @example
   * new ComplexNumber(1, 1).conj; // Returns ComplexNumber(1, -1)
   * new ComplexNumber(5, 0).conj; // Returns ComplexNumber(5, 0)
   */
  public get conj(): ComplexNumber {
    if (this.imag === 0) {
      return this;
    }
    return new ComplexNumber(this.real, -this.imag);
  }

  /**
   * Calculates the exponential of the complex number ($e^z$).
   *
   * Uses Euler's formula: $e^{(a+bi)} = e^a(\cos(b) + i\sin(b))$.
   *
   * @returns A new ComplexNumber instance representing $e^z$.
   *
   * @example
   * new ComplexNumber(0, Math.PI).exp; // Returns ComplexNumber(-1, 0) (Euler's identity)
   * new ComplexNumber(1, 0).exp;       // Returns ComplexNumber(Math.E, 0)
   */
  public get exp(): ComplexNumber {
    const trigPart = new ComplexNumber(Math.cos(this.imag), Math.sin(this.imag));
    const ePart = new ComplexNumber(Math.E ** this.real, 0);

    return ePart.mul(trigPart);
  }
}