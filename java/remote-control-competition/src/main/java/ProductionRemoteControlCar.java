class ProductionRemoteControlCar implements RemoteControlCar, Comparable<ProductionRemoteControlCar> {

    // attributes
    private int distanceTravelled = 0;
    private int numberOfVictories = 0;

    // RemoteControlCar implementations
    public void drive() {
        final int distanceForDrive = 10;

        this.distanceTravelled += distanceForDrive;
    }

    public int getDistanceTravelled() {
        return this.distanceTravelled;
    }

    // Comparable implementations
    public int compareTo(ProductionRemoteControlCar other) {
        final int selfVictories = this.getNumberOfVictories();
        final int otherVictories = other.getNumberOfVictories();
        
        if(selfVictories == otherVictories) {
            return 0;
        }
        if(selfVictories > otherVictories) {
            return 1;
        }
        return -1;
    }

    // ProductionRemoteControlCar original methods
    public int getNumberOfVictories() {
        return this.numberOfVictories;
    }

    public void setNumberOfVictories(int numberOfVictories) {
        this.numberOfVictories = numberOfVictories;
    }

}
