public class CarsAssemble {

    public double productionRatePerHour(int speed) {
        final double carsAtOneSpeed = 221;

        double carsAtAtualSpeed = carsAtOneSpeed * speed;
        double successRate;

        if (1 <= speed && speed <= 4) {
            successRate = 1;
        } else if (5 <= speed && speed <= 8) {
            successRate = 0.9;
        } else if (speed == 9) {
            successRate = 0.8;
        } else if (speed == 10) {
            successRate = 0.77;
        } else {
            return 0;
        }

        return carsAtAtualSpeed * successRate;
    }

    public int workingItemsPerMinute(int speed) {
        final double minutesInHour = 60;

        return (int)(this.productionRatePerHour(speed)/minutesInHour);
    }
}
