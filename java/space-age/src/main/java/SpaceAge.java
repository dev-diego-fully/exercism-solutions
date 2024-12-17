import java.util.Map;

class SpaceAge {

    public SpaceAge(double seconds) {
        this.seconds = seconds;
    }

    public double getSeconds() {
        return this.seconds;
    }

    public double onEarth() {
        return this.calculateAge(SolarSystemPlanet.EARTH);
    }

    public double onMercury() {
        return this.calculateAge(SolarSystemPlanet.MERCURY);
    }

    public double onVenus() {
        return this.calculateAge(SolarSystemPlanet.VENUS);
    }

    public double onMars() {
        return this.calculateAge(SolarSystemPlanet.MARS);
    }

    public double onJupiter() {
        return this.calculateAge(SolarSystemPlanet.JUPITER);
    }

    public double onSaturn() {
        return this.calculateAge(SolarSystemPlanet.SATURN);
    }

    public double onUranus() {
        return this.calculateAge(SolarSystemPlanet.URANUS);
    }

    public double onNeptune() {
        return this.calculateAge(SolarSystemPlanet.NEPTUNE);
    }

    private double calculateAge(SolarSystemPlanet planet) {
        return (this.seconds / EARTH_YEAR_IN_SECONDS) / planet.getOrbitalPeriod();
    }

    private final double seconds;
    private final static double EARTH_YEAR_IN_SECONDS = 60 * 60 * 24 * 365.25;
}
