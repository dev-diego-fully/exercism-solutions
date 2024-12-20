import java.util.List;

class Resistor {

    public static Resistor fromColors(String a, String b, String c) {
        final int ten = codeOf(a);
        final int unit = codeOf(b);
        final int zeros = codeOf(c);
        return new Resistor((ten * 10 + unit) * (long) Math.pow(10, zeros));
    }

    public MetricResistance getMetricResistance() {
        return MetricResistance.fromOhms(this.ohms);
    }

    private long ohms;

    private Resistor(long ohms) {
        this.ohms = ohms;
    }

    private static int codeOf(String color) {
        return colors.indexOf(color);
    }

    private static final List<String> colors = List.of(
            "black", "brown", "red", "orange",
            "yellow", "green", "blue", "violet",
            "grey", "white");

}
