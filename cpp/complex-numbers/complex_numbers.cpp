/// @file complex_numbers.cpp
/// @brief Implements the Complex class for complex number operations.
#include "complex_numbers.h"

namespace complex_numbers
{
    double Complex::real() const
    {
        return this->real_part;
    }

    double Complex::imag() const
    {
        return this->imaginary_part;
    }

    Complex::Complex(double real, double imaginary)
    {
        this->real_part = real;
        this->imaginary_part = imaginary;
    }

    Complex Complex::operator+(const Complex &other) const
    {
        return Complex(
            this->real() + other.real(),
            this->imag() + other.imag());
    }

    Complex Complex::operator-(const Complex &other) const
    {
        return Complex(
            this->real() - other.real(),
            this->imag() - other.imag());
    }

    Complex Complex::operator*(const Complex &other) const
    {
        return Complex(
            this->real() * other.real() - this->imag() * other.imag(),
            this->imag() * other.real() + this->real() * other.imag());
    }

    Complex Complex::operator/(const Complex &other) const
    {
        const double raw_real = (this->real() * other.real() + this->imag() * other.imag());
        const double raw_imaginary = this->imag() * other.real() - this->real() * other.imag();
        const double factor = other.real() * other.real() + other.imag() * other.imag();

        return Complex(
            raw_real / factor, raw_imaginary / factor);
    }

    double Complex::abs() const
    {
        return std::sqrt(std::pow(this->real(), 2.0) + std::pow(this->imag(), 2.0));
    }

    Complex Complex::conj() const
    {
        return Complex(this->real(), -this->imag());
    }

    Complex Complex::exp() const
    {
        const auto real = std::exp(this->real());
        return real * Complex(
                          std::cos(this->imag()),
                          std::sin(this->imag()));
    }

    Complex operator+(const Complex &that, double other)
    {
        return Complex(that.real() + other, that.imag());
    }

    Complex operator-(const Complex &that, double other)
    {
        return Complex(that.real() - other, that.imag());
    }

    Complex operator*(const Complex &that, double other)
    {
        return Complex(that.real() * other, that.imag() * other);
    }

    Complex operator/(const Complex &that, double other)
    {
        return Complex(that.real() / other, that.imag() / other);
    }

    Complex operator+(double other, const Complex &that)
    {
        return that + other;
    }

    Complex operator-(double other, const Complex &that)
    {
        return Complex(other, 0.0) - that;
    }

    Complex operator*(double other, const Complex &that)
    {
        return that * other;
    }

    Complex operator/(double other, const Complex &that)
    {
        return Complex(other, 0.0) / that;
    }
} // namespace complex_numbers
