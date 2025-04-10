import java.util.stream.IntStream;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Sieve {

    private final int maxPrime;
    private List<Integer> primes;
    private Set<Integer> nonPrimes;

    Sieve(int maxPrime) {
        this.maxPrime = maxPrime;
        this.nonPrimes = new HashSet<>();
    }

    List<Integer> getPrimes() {
        if (this.primes != null) {
            return this.primes;
        }
        
        this.primes = IntStream
                .rangeClosed(2, maxPrime)
                .filter(this::isPrime)
                .boxed()
                .toList();
        this.nonPrimes = null;

        return this.primes;
    }

    private boolean isPrime(int number) {
        if (this.nonPrimes.contains(number)) {
            return false;
        }
        this.multipliesOf(number)
                .forEach(this.nonPrimes::add);
        return true;
    }

    private IntStream multipliesOf(int value) {
        return IntStream
                .rangeClosed(value, this.maxPrime / value)
                .map(i -> i * value);
    }

}
