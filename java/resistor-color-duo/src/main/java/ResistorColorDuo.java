import java.util.List;

class ResistorColorDuo {

    public int value(String[] colors) {
        if (colors.length < 2) {
            throw new IllegalArgumentException("Banana.");
        }

        final int ten = colorValue(colors[0]);
        final int unit = colorValue(colors[1]);

        return ten * 10 + unit;
    }

    private int colorValue(String color) {
        return resistorsColor.indexOf(color);
    }

    private static final List<String> resistorsColor = List.of(
            "black", "brown", "red", "orange",
            "yellow", "green", "blue", "violet",
            "grey", "white");

}
