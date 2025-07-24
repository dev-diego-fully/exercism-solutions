<?php

declare(strict_types=1);

/**
 * Converts a number into a "raindrops" sound string based on its prime factors.
 *
 * This function checks if a number is divisible by 3, 5, or 7.
 * - If divisible by 3, it includes "Pling".
 * - If divisible by 5, it includes "Plang".
 * - If divisible by 7, it includes "Plong".
 * If the number is not divisible by 3, 5, or 7, the function returns the number itself as a string.
 *
 * @param int $number The integer to convert.
 * @return string The "raindrops" sound string, or the number itself if no sounds apply.
 *
 * @example
 * raindrops(28); // Returns "Plong" (divisible by 7)
 * raindrops(30); // Returns "PlingPlang" (divisible by 3 and 5)
 * raindrops(34); // Returns "34" (not divisible by 3, 5, or 7)
 */
function raindrops(int $number): string
{
    $sounds = soundsFor($number);

    if (count($sounds) === 0) {
        return strval($number);
    }

    return implode($sounds);
}

/**
 * Generates an array of "raindrops" sounds for a given number based on its divisibility by predefined factors.
 *
 * It iterates through `SOUND_DIVISORS` and `RAIN_SOUND` constants, appending the corresponding sound
 * if the number is divisible by the associated factor.
 *
 * @param int $number The number to check for divisibility.
 * @return array<string> An array of sound strings ("Pling", "Plang", "Plong") that apply to the number.
 *
 * @example
 * soundsFor(28); // Returns ["Plong"]
 * soundsFor(30); // Returns ["Pling", "Plang"]
 * soundsFor(34); // Returns []
 */
function soundsFor(int $number): array
{
    $max_sounds = count(SOUND_DIVISORS);
    $sounds = [];

    for ($sound_index = 0; $sound_index < $max_sounds; $sound_index++) {
        if ($number % SOUND_DIVISORS[$sound_index] === 0) {
            array_push($sounds, RAIN_SOUND[$sound_index]);
        }
    }

    return $sounds;
}

/**
 * @var array<int> SOUND_DIVISORS A constant array holding the divisors used for the "raindrops" logic (3, 5, 7).
 */
const SOUND_DIVISORS = [
    3,
    5,
    7
];

/**
 * @var array<string> RAIN_SOUND A constant array holding the "raindrops" sound strings ("Pling", "Plang", "Plong")
 * corresponding to the `SOUND_DIVISORS`.
 */
const RAIN_SOUND = [
    "Pling",
    "Plang",
    "Plong"
];