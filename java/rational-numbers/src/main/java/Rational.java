import java.util.Objects;
import java.util.stream.Stream;
import java.util.stream.IntStream;

class Rational {

    private final int numerator;
    private final int denominator;

    Rational(int numerator, int denominator) {
        int finalNumerator = numerator;
        int finalDenominator = denominator;

        final int mdc = IntegerUtils.mdc(numerator, denominator);

        finalNumerator = numerator / mdc;
        finalDenominator = denominator / mdc;

        if (finalDenominator < 0) {
            finalNumerator *= -1;
            finalDenominator *= -1;
        }

        this.numerator = finalNumerator;
        this.denominator = finalDenominator;
    }

    int getNumerator() {
        return this.numerator;
    }

    int getDenominator() {
        return this.denominator;
    }

    Rational add(Rational other) {
        final int ajustedNumerator = this.numerator * other.denominator;
        final int ajustedOtherNumerator = other.numerator * this.denominator;

        final int numerator = ajustedNumerator + ajustedOtherNumerator;
        final int denominator = this.denominator * other.denominator;

        return new Rational(numerator, denominator);
    }

    Rational subtract(Rational other) {
        final int ajustedNumerator = this.numerator * other.denominator;
        final int ajustedOtherNumerator = other.numerator * this.denominator;

        final int numerator = ajustedNumerator - ajustedOtherNumerator;
        final int denominator = this.denominator * other.denominator;

        return new Rational(numerator, denominator);
    }

    Rational multiply(Rational other) {
        final int numerator = this.numerator * other.numerator;
        final int denominator = this.denominator * other.denominator;

        return new Rational(numerator, denominator);
    }

    Rational divide(Rational other) {
        final int numerator = this.numerator * other.denominator;
        final int denominator = other.numerator * this.denominator;

        return new Rational(numerator, denominator);
    }

    Rational abs() {
        return new Rational(Math.abs(numerator), Math.abs(denominator));
    }

    Rational pow(int power) {
        final int realPower = Math.abs(power);

        final int poweredNumerator = IntegerUtils.pow(
                this.numerator, realPower);
        final int poweredDenominator = IntegerUtils.pow(
                this.denominator, realPower);

        if (power > 0) {
            return new Rational(poweredNumerator, poweredDenominator);
        }

        return new Rational(poweredDenominator, poweredNumerator);
    }

    double exp(double exponent) {
        return Math.pow(
                exponent,
                (double) this.numerator / (double) this.denominator);
    }

    @Override
    public String toString() {
        return String
                .format("%d/%d", this.getNumerator(), this.getDenominator());
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Rational other) {
            return this.getNumerator() == other.getNumerator()
                    && this.getDenominator() == other.getDenominator();
        }

        return false;
    }

    @Override
    public int hashCode() {
        return Objects.hash(
                this.getNumerator(), this.getDenominator());
    }

    private static Rational reduced(int numerator, int denominator) {
        if (denominator < 0) {
            return new Rational(-numerator, -denominator);
        }

        final int mdc = IntegerUtils.mdc(numerator, denominator);

        return new Rational(numerator / mdc, denominator / mdc);
    }

}
