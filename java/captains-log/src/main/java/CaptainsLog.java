import java.util.Random;

class CaptainsLog {

    private static final char[] PLANET_CLASSES = new char[]{'D', 'H', 'J', 'K', 'L', 'M', 'N', 'R', 'T', 'Y'};

    private Random random;

    CaptainsLog(Random random) {
        this.random = random;
    }

    char randomPlanetClass() {
        return PLANET_CLASSES[this.random.nextInt(PLANET_CLASSES.length)];
    }

    String randomShipRegistryNumber() {
        final int shipRangeStart = 1000;
        final int shipRangeEnd = 10000;

        return "NCC-" + this.random.nextInt(shipRangeStart, shipRangeEnd);
    }

    double randomStardate() {
        final int stardateRangeStart = 41000;
        final int stardateRangeEnd = 42000;

        return this.random.nextDouble(stardateRangeStart, stardateRangeEnd);
    }
}
