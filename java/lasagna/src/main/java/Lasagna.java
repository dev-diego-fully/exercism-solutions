import java.lang.Math;

public class Lasagna {
    
    public static int expectedMinutesInOven() {
        return 40;
    }

    public static int remainingMinutesInOven(int passedTime) {
        return Math.max(Lasagna.expectedMinutesInOven() - passedTime, 0);
    }

    public static int preparationTimeInMinutes(int layersCount) {
        final int minutesPerLayer = 2;

        return layersCount *minutesPerLayer;
    }

    public static int totalTimeInMinutes(int layersCount, int minutesInOven) {
        return preparationTimeInMinutes(layersCount) + minutesInOven;
    }
}
