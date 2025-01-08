// Package complexnumbers provides a type for representing and performing operations on complex numbers.
// This package offers a simple interface for performing common operations on complex numbers.
package complexnumbers

import "math"

// Number represents a complex number with real and imaginary parts.
type Number struct {
	real, imaginary float64
}

// Real returns the real part of the complex number.
func (n Number) Real() float64 {
	return n.real
}

// Imaginary returns the imaginary part of the complex number.
func (n Number) Imaginary() float64 {
	return n.imaginary
}

// Add adds two complex numbers and returns the result.
func (n1 Number) Add(n2 Number) Number {
	return Number{
		n1.real + n2.real,
		n1.imaginary + n2.imaginary,
	}
}

// Subtract subtracts one complex number from another and returns the result.
func (n1 Number) Subtract(n2 Number) Number {
	return Number{
		n1.real - n2.real,
		n1.imaginary - n2.imaginary,
	}
}

// Multiply multiplies the complex number by another complex number and returns the result.
func (n1 Number) Multiply(n2 Number) Number {
	return Number{
		n1.real*n2.real - n1.imaginary*n2.imaginary,
		n1.imaginary*n2.real + n1.real*n2.imaginary,
	}
}

// Times multiplies the complex number by a real number and returns the result.
func (n Number) Times(factor float64) Number {
	return Number{
		n.real * factor,
		n.imaginary * factor,
	}
}

// Divide divides the complex number by another complex number and returns the result.
// It uses the formula for dividing complex numbers.
func (n1 Number) Divide(n2 Number) Number {
	factor := (n2.real*n2.real + n2.imaginary*n2.imaginary)
	realPart := (n1.real*n2.real + n1.imaginary*n2.imaginary) / factor
	imaginaryPart := (n1.imaginary*n2.real - n1.real*n2.imaginary) / factor

	return Number{
		realPart,
		imaginaryPart,
	}
}

// Conjugate returns the complex conjugate of the number.
func (n Number) Conjugate() Number {
	return Number{n.real, -n.imaginary}
}

// Abs returns the absolute value (magnitude) of the complex number.
func (n Number) Abs() float64 {
	return math.Sqrt(n.real*n.real + n.imaginary*n.imaginary)
}

// Exp returns the result of raising Euler's number (e) to the power of the complex number.
func (n Number) Exp() Number {
	magnitude := Number{math.Exp(n.real), 0}
	rotationalFactor := Number{math.Cos(n.imaginary), math.Sin(n.imaginary)}

	return magnitude.Multiply(rotationalFactor)
}
