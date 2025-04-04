class ComplexNumber {

    private final double real;
    private final double imaginary;

    ComplexNumber(double real, double imaginary) {
        this.real = real;
        this.imaginary = imaginary;
    }

    double getReal() {
        return this.real;
    }

    double getImaginary() {
        return this.imaginary;
    }

    double abs() {
        return Math.sqrt(
                Math.pow(this.real, 2) + Math.pow(this.imaginary, 2));
    }

    ComplexNumber add(ComplexNumber other) {
        final double real = this.real + other.real;
        final double imaginary = this.imaginary + other.imaginary;

        return new ComplexNumber(real, imaginary);
    }

    ComplexNumber subtract(ComplexNumber other) {
        final double real = this.real - other.real;
        final double imaginary = this.imaginary - other.imaginary;

        return new ComplexNumber(real, imaginary);
    }

    ComplexNumber multiply(ComplexNumber other) {
        final double realPartA = this.real * other.real;
        final double realPartB = this.imaginary * other.imaginary;
        final double imaginaryPartA = this.imaginary * other.real;
        final double imaginaryPartB = this.real * other.imaginary;

        final double real = realPartA - realPartB;
        final double imaginary = imaginaryPartA + imaginaryPartB;

        return new ComplexNumber(real, imaginary);
    }

    ComplexNumber divide(ComplexNumber other) {
        final double commonDenominator, realNumerator, imaginaryNumerator;

        commonDenominator = (Math.pow(other.real, 2) +
                Math.pow(other.imaginary, 2));

        realNumerator = (this.real * other.real +
                this.imaginary * other.imaginary);

        imaginaryNumerator = (this.imaginary * other.real -
                this.real * other.imaginary);

        final double real = realNumerator / commonDenominator;
        final double imaginary = imaginaryNumerator / commonDenominator;

        return new ComplexNumber(real, imaginary);
    }

    ComplexNumber conjugate() {
        return new ComplexNumber(this.real, -this.imaginary);
    }

    ComplexNumber exponentialOf() {
        final ComplexNumber partA = new ComplexNumber(
                Math.exp(this.real), 0.0);
        final ComplexNumber partB = new ComplexNumber(
                Math.cos(this.imaginary),
                Math.sin(this.imaginary));

        return partA.multiply(partB);
    }
}