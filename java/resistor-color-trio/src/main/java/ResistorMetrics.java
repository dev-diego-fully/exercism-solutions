import java.util.List;

class ResistorMetrics {

    public String toMetrics(long resistance) {
        final int prefixIndex = this.metricPrefixIndexFor(resistance);
        final String prefix = prefixes.get(prefixIndex);
        final long convertedValue = resistance / baseForPrefixIndex(prefixIndex);

        return String.valueOf(convertedValue) + " " + prefix;
    }

    private int metricPrefixIndexFor(long resistance) {
        return clamp(0, this.log1000(resistance), prefixes.size() - 1);
    }

    private long baseForPrefixIndex(int index) {
        return (long) Math.floor(Math.pow(metricStep, index));
    }

    private int clamp(int value, int rangeStart, int rangeEnd) {
        return Integer.max(rangeStart, Integer.min(value, rangeEnd));
    }

    private int log1000(long value) {
        return (int) (Math.log10(value) / Math.log10(metricStep));
    }

    private static List<String> prefixes = List.of(
            "ohms", "kiloohms", "megaohms", "gigaohms");

    private static int metricStep = 1000;

}