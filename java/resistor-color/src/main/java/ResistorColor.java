
import java.util.List;

class ResistorColor {

    private static final List<String> resitorColors = List.of(
            "black", "brown", "red", "orange",
            "yellow", "green", "blue", "violet",
            "grey", "white");

    public int colorCode(String color) {
        return resitorColors.indexOf(color);
    }

    public String[] colors() {
        return resitorColors.toArray(String[]::new);
    }
}
