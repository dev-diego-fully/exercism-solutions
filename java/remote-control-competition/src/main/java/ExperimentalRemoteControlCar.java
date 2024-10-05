public class ExperimentalRemoteControlCar implements RemoteControlCar {

    //attributes
    private int distanceTravelled = 0;

    //RemoteControlCar implementations
    public void drive() {
        final int distanceForDrive = 20;

        this.distanceTravelled += distanceForDrive;
    }

    public int getDistanceTravelled() {
        return this.distanceTravelled;
    }
    
}
