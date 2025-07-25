<?php

declare(strict_types=1);

/**
 * SpaceAge
 *
 * This class calculates a person's age on different planets based on a given age in seconds on Earth.
 * It uses the orbital periods of planets relative to Earth's year.
 */
class SpaceAge
{
    /**
     * @var array<string, float> ORBITAL_PERIODS A constant array mapping planet names to their orbital periods relative to Earth's year.
     */
    private const ORBITAL_PERIODS = [
        "Mercury" => 0.2408467,
        "Venus" => 0.61519726,
        "Earth" => 1.0,
        "Mars" => 1.8808158,
        "Jupiter" => 11.862615,
        "Saturn" => 29.447498,
        "Uranus" => 84.016846,
        "Neptune" => 164.79132
    ];

    /**
     * @var float EARTH_YEAR_IN_SECONDS The number of seconds in a standard Earth year.
     * This is calculated as 365.25 days * 24 hours/day * 60 minutes/hour * 60 seconds/minute.
     */
    private const EARTH_YEAR_IN_SECONDS = 365.25 * 24 * 60 * 60;

    /**
     * @var int The age of the person in seconds on Earth.
     */
    private int $ageInSeconds;

    /**
     * Constructs a new SpaceAge instance.
     *
     * @param int $seconds The age in seconds on Earth.
     */
    public function __construct(int $seconds)
    {
        $this->ageInSeconds = $seconds;
    }

    /**
     * Calculates the age on Earth in Earth years.
     *
     * @return float The age on Earth.
     *
     * @example
     * (new SpaceAge(1000000000))->earth(); // Returns 31.69
     */
    public function earth(): float
    {
        return $this->ageInSeconds / self::EARTH_YEAR_IN_SECONDS;
    }

    /**
     * Calculates the age on Mercury in Earth years.
     *
     * @return float The age on Mercury.
     *
     * @example
     * (new SpaceAge(2134835688))->mercury(); // Returns 280.88
     */
    public function mercury(): float
    {
        return $this->earth() / self::ORBITAL_PERIODS["Mercury"];
    }

    /**
     * Calculates the age on Venus in Earth years.
     *
     * @return float The age on Venus.
     *
     * @example
     * (new SpaceAge(189839836))->venus(); // Returns 9.78
     */
    public function venus(): float
    {
        return $this->earth() / self::ORBITAL_PERIODS["Venus"];
    }

    /**
     * Calculates the age on Mars in Earth years.
     *
     * @return float The age on Mars.
     *
     * @example
     * (new SpaceAge(2129871239))->mars(); // Returns 35.88
     */
    public function mars(): float
    {
        return $this->earth() / self::ORBITAL_PERIODS["Mars"];
    }

    /**
     * Calculates the age on Jupiter in Earth years.
     *
     * @return float The age on Jupiter.
     *
     * @example
     * (new SpaceAge(901876382))->jupiter(); // Returns 2.41
     */
    public function jupiter(): float
    {
        return $this->earth() / self::ORBITAL_PERIODS["Jupiter"];
    }

    /**
     * Calculates the age on Saturn in Earth years.
     *
     * @return float The age on Saturn.
     *
     * @example
     * (new SpaceAge(2000000000))->saturn(); // Returns 2.15
     */
    public function saturn(): float
    {
        return $this->earth() / self::ORBITAL_PERIODS["Saturn"];
    }

    /**
     * Calculates the age on Uranus in Earth years.
     *
     * @return float The age on Uranus.
     *
     * @example
     * (new SpaceAge(1210123456))->uranus(); // Returns 0.46
     */
    public function uranus(): float
    {
        return $this->earth() / self::ORBITAL_PERIODS["Uranus"];
    }

    /**
     * Calculates the age on Neptune in Earth years.
     *
     * @return float The age on Neptune.
     *
     * @example
     * (new SpaceAge(1821023456))->neptune(); // Returns 0.35
     */
    public function neptune(): float
    {
        return $this->earth() / self::ORBITAL_PERIODS["Neptune"];
    }
}