import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

class SumOfMultiples {

    private Integer sum;
    private Set<Integer> divisors;
    private final int limit;

    SumOfMultiples(int limit, int[] set) {
        this.limit = limit;
        this.divisors = Arrays.stream(set)
                .boxed()
                .collect(Collectors.toSet());

        this.sum = null;
    }

    int getSum() {
        if (this.sum != null) {
            return this.sum;
        }

        this.sum = IntStream.range(1, this.limit)
                .filter(this::hasDivisorsInSet)
                .sum();
        this.divisors = null;

        return this.sum;
    }

    private boolean hasDivisorsInSet(int number) {
        if (number == 0) {
            return true;
        }

        return this.divisors
                .stream()
                .anyMatch(d -> d != 0 && number % d == 0);
    }

}
