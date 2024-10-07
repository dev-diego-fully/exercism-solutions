class NeedForSpeed {

    private int speed = 0;
    private int batteryDrain = 0;
    private int battery = 100;
    private int drivenDistance = 0;

    public int getSpeed() {
        return this.speed;
    }

    public int getBatteryDrain() {
        return this.batteryDrain;
    }

    public int getBattery() {
        return this.battery;
    }

    public int getDrivenDistance() {
        return this.drivenDistance;
    }

    NeedForSpeed(int speed, int batteryDrain) {
        this.speed = speed;
        this.batteryDrain = batteryDrain;
    }

    public boolean batteryDrained() {
        return this.battery < this.batteryDrain;
    }

    public int distanceDriven() {
        return this.drivenDistance;
    }

    public void drive() {
        if (!this.batteryDrained()) {
            this.drivenDistance += this.speed;
            this.battery -= this.batteryDrain;
        }
    }

    public static NeedForSpeed nitro() {
        return new NeedForSpeed(50, 4);
    }
}

class RaceTrack {

    private int distance = 0;

    RaceTrack(int distance) {
        this.distance = distance;
    }

    public boolean tryFinishTrack(NeedForSpeed car) {
        final double carEfficiency = car.getBattery() / car.getBatteryDrain();
        return carEfficiency * car.getSpeed() >= this.distance;
    }

}
