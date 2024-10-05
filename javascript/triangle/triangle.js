//
// This is only a SKELETON file for the 'Triangle' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

//@ts-check

export class Triangle {

  static allSides = 3;
  static twoSides = 2;
  static noSide = 0;
  static oneSide = 1;

  /**
   * 
   * @param {number} a 
   * @param {number} b 
   * @param {number} c 
   */
  constructor(a, b, c) {

    this._a = a;
    this._b = b;
    this._c = c;

  }

  get a() {
    return this._a;
  }

  get b() {
    return this._b;
  }

  get c() {
    return this._c;
  }

  get sides( ) {
    return [this.a, this.b, this.c];
  }

  get equalsSides() {

    const uniqueSides = (new Set( this.sides )).size;

    switch(uniqueSides) {
      case Triangle.oneSide:
        return Triangle.allSides;

      case Triangle.twoSides:
        return Triangle.twoSides;

      case Triangle.allSides:
        return Triangle.noSide;
      
      default:
        return Triangle.noSide;

    }

  }

  get allSidesPositive() {
    return this.sides.every(side => side > 0);
  }

  get satisfiesInequalities() {

    /**
     * 
     * @param {number} a 
     * @param {number} b 
     * @param {number} c 
     * @returns {boolean}
     */
    const inequality = ( a, b, c ) => a + b >= c; 

    const inequalityABvsC = inequality( this.a, this.b, this.c );
    const inequalityACvsB = inequality( this.a, this.c, this.b );
    const inequalityBCvsA = inequality( this.b, this.c, this.a );

    return inequalityABvsC && inequalityACvsB && inequalityBCvsA;

  }

  get isValidTriangle() {
    return this.satisfiesInequalities && this.allSidesPositive;
  }

  get isEquilateral() {

    return this.isValidTriangle && this.equalsSides == Triangle.allSides;

  }

  get isIsosceles() {

    return this.isValidTriangle && this.equalsSides >= Triangle.twoSides;

  }

  get isScalene() {

    return this.isValidTriangle && this.equalsSides == Triangle.noSide;

  }
}