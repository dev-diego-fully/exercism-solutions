import java.util.List;
import java.util.LinkedList;
import java.util.stream.LongStream;
import java.util.stream.Stream;

class PrimeFactorsCalculator {

    static final long SMALLEST_PRIME_NUMBER = 2;

    List<Long> calculatePrimeFactorsOf(long number) {
        if (number < SMALLEST_PRIME_NUMBER) {
            return List.of();
        }

        long remainingNumber = number;
        final LinkedList<Long> factors = new LinkedList<>();
        final List<Long> mainPrimes = this.mainFactorsFor(number);

        for (Long factor : mainPrimes) {
            if (remainingNumber == 1) {
                return List.copyOf(factors);
            }
            remainingNumber = this.addFactorationFor(remainingNumber, factor, factors);
        }

        if (remainingNumber > 1) {
            factors.addLast(remainingNumber);
        }

        return List.copyOf(factors);
    }

    private List<Long> mainFactorsFor(long number) {
        final long maxFactor = (long) Math.sqrt(number);

        return LongStream
                .concat(LongStream.of(2), this.oddsTo(maxFactor))
                .boxed()
                .toList();
    }

    private long addFactorationFor(long number, long factor, List<Long> factors) {
        long remainingNumber = number;

        for (; remainingNumber % factor == 0; remainingNumber /= factor) {
            factors.add(factor);
        }

        return remainingNumber;
    }

    private LongStream oddsTo(long number) {
        return LongStream
                .rangeClosed(3, number)
                .filter(prime -> prime % 2 != 0);
    }

}