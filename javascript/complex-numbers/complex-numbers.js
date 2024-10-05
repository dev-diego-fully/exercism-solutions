//@ts-check

export class ComplexNumber {

  #real;
  #imag;

  /**
   * 
   * @param {number} real 
   * @param {number} imag 
   */
  constructor(real, imag) {
    this.#real = real;
    this.#imag = imag;
  }

  get real() {
    return this.#real;
  }

  get imag() {
    return this.#imag;
  }

  /**
   * @param {ComplexNumber} other
   * @returns {ComplexNumber}
   */
  add(other) {
    return new ComplexNumber(this.real + other.real, this.imag + other.imag);
  }

  /**
   * 
   * @param {ComplexNumber} other
   * @returns {ComplexNumber}
   */
  sub(other) {
    return new ComplexNumber(this.real - other.real, this.imag - other.imag);
  }

  /**
   * 
   * @param {ComplexNumber} other
   * @returns {ComplexNumber}
   */
  div(other) {
    const a = (this.real * other.real + this.imag * other.imag);
    const b = (other.real ** 2 + other.imag ** 2);
    const c = (this.imag * other.real - this.real * other.imag);
    const d = (other.real ** 2 + other.imag ** 2);

    return new ComplexNumber(a / b, c / d);
  }

  /**
   * 
   * @param {ComplexNumber} other 
   * @returns {ComplexNumber}
   */
  mul(other) {
    return new ComplexNumber(
      this.real * other.real - this.imag * other.imag,
      this.imag * other.real + this.real * other.imag
    );
  }

  get abs() {
    return Math.sqrt(this.real ** 2 + this.imag ** 2);
  }

  get conj() {
    return new ComplexNumber(this.real, -this.imag);
  }

  get exp() {
    const a = new ComplexNumber(Math.exp(this.real), 0);
    const b = new ComplexNumber(Math.cos(this.imag), Math.sin(this.imag));
    
    return a.mul(b);
  }
}
