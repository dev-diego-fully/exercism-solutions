<?php

declare(strict_types=1);

/**
 * ResistorColorDuo
 *
 * This class provides functionality to interpret the value of a two-band resistor.
 * It converts resistor color bands into their corresponding numerical value.
 */
class ResistorColorDuo
{
    /**
     * @var array<string, int> $resistor_colors A private static array mapping resistor color names to their numerical values.
     */
    private static array $resistor_colors = [
        "black" => 0,
        "brown" => 1,
        "red" => 2,
        "orange" => 3,
        "yellow" => 4,
        "green" => 5,
        "blue" => 6,
        "violet" => 7,
        "grey" => 8,
        "white" => 9,
    ];

    /**
     * Calculates the numerical value of a two-band resistor based on its color bands.
     *
     * This method takes an array of two color strings and returns the combined integer value.
     * The first color represents the tens digit, and the second color represents the units digit.
     *
     * @param array<string> $colors An array containing two strings, each representing a resistor color.
     * For example: `['brown', 'black']`.
     *
     * @return int The numerical value of the resistor.
     * For example: for `['brown', 'black']` it returns `10`.
     */
    public function getColorsValue(array $colors): int
    {
        $ten = self::$resistor_colors[$colors[0]] * 10;
        $units = self::$resistor_colors[$colors[1]];

        return $ten + $units;
    }
}
