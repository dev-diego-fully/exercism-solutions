package main.java;

public enum SolarSystemPlanet {

    MERCURY(0.2408467),
    VENUS(0.61519726),
    EARTH(1.0),
    MARS(1.8808158),
    JUPITER(11.862615),
    SATURN(29.447498),
    URANUS(84.016846),
    NEPTUNE(164.79132);

    public double getOrbitalPeriod() {
        return this.orbitalPeriod;
    }

    private final double orbitalPeriod;

    private SolarSystemPlanet(double orbitalPeriod) {
        this.orbitalPeriod = orbitalPeriod;
    }

}
