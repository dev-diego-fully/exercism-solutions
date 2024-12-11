import java.util.Arrays;
import java.util.List;

class ResistorColorTrio {

    public String label(String[] resistorColors) {
        return (new ResistorMetrics())
                .toMetrics(this.resistanceOf(this.codesFor(resistorColors)));
    }

    private List<Integer> codesFor(String[] input) {
        return Arrays
                .stream(input)
                .limit(bandColorsCount)
                .map(this::codeFor)
                .toList();
    }

    private long resistanceOf(List<Integer> values) {
        final int ten = values.get(0);
        final int unit = values.get(1);
        final int zeros = values.get(2);

        return (ten * 10 + unit) * (long) Math.pow(10, zeros);
    }

    private int codeFor(String color) {
        return resistorColors
                .indexOf(color);
    }

    private static final List<String> resistorColors = List.of(
            "black", "brown", "red", "orange",
            "yellow", "green", "blue", "violet",
            "grey", "white");

    private final int bandColorsCount = 3;

}
