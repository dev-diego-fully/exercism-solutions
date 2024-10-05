public class ElonsToyCar {

    private int drivenDistance;
    private int baterry = 100;

    public static ElonsToyCar buy() {
        return new ElonsToyCar();
    }

    public String distanceDisplay() {
        final String distanceDisplayTemplate = "Driven %d meters";

        return String.format(distanceDisplayTemplate, this.drivenDistance);
    }

    public String batteryDisplay() {
        final String batteryDisplayTemplate = "Battery at %d%%";
        final String batteryEmpty = "Battery empty";

        if( baterry > 0 ) {
            return String.format(batteryDisplayTemplate, this.baterry);
        }

        return batteryEmpty;
    }

    public void drive() {
        final int distanceToDrive = 20;

        if (this.baterry > 0) {
            this.drivenDistance += distanceToDrive;
            this.baterry -= 1;
        }
    }
}
