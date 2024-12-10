import java.util.stream.IntStream;

class NaturalNumber {

    private final Classification classification;

    NaturalNumber(int number) {
        if (number <= 0) {
            throw new IllegalArgumentException("You must supply a natural number (positive integer)");
        }
        this.classification = this.classify(number);
    }

    Classification getClassification() {
        return this.classification;
    }

    private Classification classify(int number) {
        final int divisorsSum = this.sumOfDivisors(number);

        if (divisorsSum < number) {
            return Classification.DEFICIENT;
        }
        if (divisorsSum == number) {
            return Classification.PERFECT;
        }
        return Classification.ABUNDANT;
    }

    private int sumOfDivisors(int number) {
        return IntStream
                .range(1, number)
                .filter((divisor) -> number % divisor == 0)
                .sum();
    }

}
