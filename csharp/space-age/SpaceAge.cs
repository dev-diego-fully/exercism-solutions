/// <summary>
/// Class provides methods to convert the given amount of seconds used to
/// construct the instance into an age on the planet of the called method.
/// </summary>
public class SpaceAge
{
    // statics
    /// <summary>
    /// Length of the Earth year in seconds. It is used as a basis for
    /// calculating the year on all other planets.
    /// </summary>
    private const double EARTH_YEAR_IN_SECONDS = 365.25 * 24 * 60 * 60;
    /// <summary>
    /// Dictionary containing the orbital period of each planet
    /// (accessible by name).
    /// </summary>
    private static readonly Dictionary<string, double> OrbitalPeriods = new()
    {
        ["Mercury"] = 0.2408467,
        ["Venus"] = 0.61519726,
        ["Earth"] = 1.0,
        ["Mars"] = 1.8808158,
        ["Jupiter"] = 11.862615,
        ["Saturn"] = 29.447498,
        ["Uranus"] = 84.016846,
        ["Neptune"] = 164.79132
    };

    // attributes
    public readonly int seconds;

    // constructors
    public SpaceAge(int seconds)
    {
        this.seconds = seconds;
    }

    // public methods
    /// <summary>
    /// Convert the amount of seconds to the equivalent amount of years on
    /// planet Earth
    /// </summary>
    /// <returns>Number of years on the planet Earth</returns>
    public double OnEarth() => this.OnPlanet("Earth");
    
    /// <summary>
    /// Convert the amount of seconds to the equivalent amount of years on
    /// planet Mercury
    /// </summary>
    /// <returns>Number of years on the planet Mercury</returns>
    public double OnMercury() => this.OnPlanet("Mercury");
    
    /// <summary>
    /// Convert the amount of seconds to the equivalent amount of years on
    /// planet Venus
    /// </summary>
    /// <returns>Number of years on the planet Venus</returns>
    public double OnVenus() => this.OnPlanet("Venus");
    
    /// <summary>
    /// Convert the amount of seconds to the equivalent amount of years on
    /// planet Mars
    /// </summary>
    /// <returns>Number of years on the planet Mars</returns>
    public double OnMars() => this.OnPlanet("Mars");
    
    /// <summary>
    /// Convert the amount of seconds to the equivalent amount of years on
    /// planet Jupiter
    /// </summary>
    /// <returns>Number of years on the planet Jupiter</returns>
    public double OnJupiter() => this.OnPlanet("Jupiter");
    
    /// <summary>
    /// Convert the amount of seconds to the equivalent amount of years on
    /// planet Saturn
    /// </summary>
    /// <returns>Number of years on the planet Saturn</returns>
    public double OnSaturn() => this.OnPlanet("Saturn");
    
    /// <summary>
    /// Convert the amount of seconds to the equivalent amount of years on
    /// planet Uranus
    /// </summary>
    /// <returns>Number of years on the planet Uranus</returns>
    public double OnUranus() => this.OnPlanet("Uranus");
    
    /// <summary>
    /// Convert the amount of seconds to the equivalent amount of years on
    /// planet Neptune
    /// </summary>
    /// <returns>Number of years on the planet Neptune</returns>
    public double OnNeptune() => this.OnPlanet("Neptune");

    // private methods
    /// <summary>
    /// Converts seconds to the equivalent number of years on the planet
    /// with the given name.
    /// </summary>
    /// <param name="planetName">
    /// name of the planet that the duration will be calculated on.
    /// </param>
    /// <returns>Equivalent number of years</returns>
    private double OnPlanet(string planetName)
        => this.seconds / EARTH_YEAR_IN_SECONDS / OrbitalPeriods[planetName];
}