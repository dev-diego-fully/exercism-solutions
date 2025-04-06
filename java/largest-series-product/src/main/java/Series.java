import java.util.stream.Stream;
import java.util.stream.IntStream;

class Series {

    private final String string;

    Series(String string) {
        this.string = string;
    }

    Stream<String> slices(int num) {
        SeriesValidator.ensureValidSliceLength(num, this.string);

        return IntStream
                .range(0, this.string.length() - num + 1)
                .mapToObj(start -> this.string.substring(start, start + num));
    }

}
