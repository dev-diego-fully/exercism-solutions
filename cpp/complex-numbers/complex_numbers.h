/// @file complex_numbers.h
/// @brief Defines the Complex class for complex number operations.
#if !defined(COMPLEX_NUMBERS_H)
#define COMPLEX_NUMBERS_H

#include <cmath>

namespace complex_numbers
{
    /// @class Complex
    /// @brief Represents a complex number and provides basic operations.
    class Complex
    {
    public:
        /// @brief Gets the real part of the complex number.
        /// @return The real part.
        double real() const;

        /// @brief Gets the imaginary part of the complex number.
        /// @return The imaginary part.
        double imag() const;

        /// @brief Constructs a complex number with given real and imaginary parts.
        /// @param real The real part.
        /// @param imaginary The imaginary part.
        Complex(double real, double imaginary);

        /// @brief Computes the magnitude (absolute value) of the complex number.
        /// @return The magnitude.
        double abs() const;

        /// @brief Computes the complex conjugate.
        /// @return The conjugate of the complex number.
        Complex conj() const;

        /// @brief Computes the exponential of the complex number.
        /// @return The exponentiation result.
        Complex exp() const;

        /// @brief Adds two complex numbers.
        Complex operator+(const Complex &other) const;

        /// @brief Subtracts two complex numbers.
        Complex operator-(const Complex &other) const;

        /// @brief Multiplies two complex numbers.
        Complex operator*(const Complex &other) const;

        /// @brief Divides two complex numbers.
        Complex operator/(const Complex &other) const;

        friend Complex operator+(const Complex &that, double other);
        friend Complex operator-(const Complex &that, double other);
        friend Complex operator*(const Complex &that, double other);
        friend Complex operator/(const Complex &that, double other);

        friend Complex operator+(double other, const Complex &that);
        friend Complex operator-(double other, const Complex &that);
        friend Complex operator*(double other, const Complex &that);
        friend Complex operator/(double other, const Complex &that);

    private:
        double real_part = 0;      ///< The real part of the complex number.
        double imaginary_part = 0; ///< The imaginary part of the complex number.
    };

    /// @brief Adds a complex number and a double.
    Complex operator+(const Complex &that, double other);

    /// @brief Subtracts a double from a complex number.
    Complex operator-(const Complex &that, double other);

    /// @brief Multiplies a complex number by a double.
    Complex operator*(const Complex &that, double other);

    /// @brief Divides a complex number by a double.
    Complex operator/(const Complex &that, double other);

    /// @brief Adds a double and a complex number.
    Complex operator+(double other, const Complex &that);

    /// @brief Subtracts a complex number from a double.
    Complex operator-(double other, const Complex &that);

    /// @brief Multiplies a double by a complex number.
    Complex operator*(double other, const Complex &that);

    /// @brief Divides a double by a complex number.
    Complex operator/(double other, const Complex &that);

} // namespace complex_numbers

#endif // COMPLEX_NUMBERS_H
