<?php

declare(strict_types=1);

/**
 * Returns a complete list of standard resistor color codes.
 *
 * The colors are ordered according to their numerical value in the resistor color code system,
 * starting from black (0) to white (9).
 *
 * @return array<string> An indexed array of strings, where each string is a resistor color name.
 */
function getAllColors(): array
{
    return [
        "black",
        "brown",
        "red",
        "orange",
        "yellow",
        "green",
        "blue",
        "violet",
        "grey",
        "white"
    ];
}

/**
 * Retrieves the numerical code for a given resistor color.
 *
 * This function looks up the provided color string in the standard list of resistor colors
 * and returns its corresponding integer value.
 *
 * @param string $color The name of the resistor color (e.g., "brown", "red").
 * @return int The numerical code associated with the color. Returns `false` if the color is not found,
 * though in a strictly typed context where all inputs are valid colors, this won't happen.
 *
 * @example
 * colorCode("black"); // Returns 0
 * colorCode("brown"); // Returns 1
 * colorCode("white"); // Returns 9
 */
function colorCode(string $color): int
{
    return array_search($color, getAllColors());
}