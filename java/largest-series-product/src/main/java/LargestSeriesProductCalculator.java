import java.util.Comparator;

class LargestSeriesProductCalculator {

    private final Series series;

    LargestSeriesProductCalculator(String inputNumber) {
        IntString.ensureIsIntString(inputNumber);
        this.series = new Series(inputNumber);
    }

    long calculateLargestProductForSeriesLength(int numberOfDigits) {
        return this.series
                .slices(numberOfDigits)
                .map(IntString::product)
                .max(Comparator.naturalOrder())
                .get();
    }
}
