import java.util.List;

public class MetricResistance {

    public static MetricResistance fromOhms(long ohms) {
        return new MetricResistance(ohms);
    }

    public String formatedAsHighest() {
        final int order = this.magnetudeOrder();
        final long value = this.valueInMagnetudeOrder(order);
        return value + " " + metricsPrefix.get(order);
    }

    private final long resistance;

    private int magnetudeOrder() {
        int order = (int) Math.log10(this.resistance) / metricStepZeros;
        return Integer.max(0, Integer.min(order, metricsPrefix.size() - 1));
    }

    private long valueInMagnetudeOrder(int order) {
        return this.resistance / (long) Math.pow(metricStep, order);
    }

    private MetricResistance(long ohms) {
        this.resistance = ohms;
    }

    private final static int metricStep = 1_000;
    private final static int metricStepZeros = 3;

    private final static List<String> metricsPrefix = List.of(
            "ohms", "kiloohms", "megaohms", "gigaohms");

}
