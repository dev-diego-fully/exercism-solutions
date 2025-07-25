<?php

declare(strict_types=1);

/**
 * Performs a binary search to find the index of a target value within a sorted array.
 *
 * This function efficiently searches for a `$needle` within a `$haystack` array.
 * It repeatedly divides the search interval in half. If the value is found, its index is returned.
 * If the value is not present in the array, -1 is returned.
 * The input array MUST be sorted for this algorithm to work correctly.
 *
 * @param int $needle The value to search for.
 * @param array<int> $haystack The sorted array to search within.
 * @return int The index of the `$needle` if found, otherwise -1.
 *
 * @example
 * find(6, [6]);                     // Returns 0
 * find(6, [1, 3, 4, 6, 8, 9, 11]);  // Returns 3
 * find(1, [1, 3, 4, 6, 8, 9, 11]);  // Returns 0
 * find(11, [1, 3, 4, 6, 8, 9, 11]); // Returns 6
 * find(7, [1, 3, 4, 6, 8, 9, 11]);  // Returns -1
 * find(1, []);                      // Returns -1
 */
function find(int $needle, array $haystack): int
{
    $bot = 0;
    $top = count($haystack) - 1;

    for ($middle = middleFor($bot, $top); $bot <= $top; $middle = middleFor($bot, $top)) {
        $element = $haystack[$middle];

        if ($needle === $element) {
            return $middle;

        } else if ($needle < $element) {
            $top = $middle - 1;

        } else {
            $bot = $middle + 1;
        }
    }

    return -1;
}

/**
 * Calculates the middle index between a 'bottom' and 'top' boundary.
 *
 * This is a helper function for the binary search algorithm, ensuring the middle index
 * is always an integer by rounding down.
 *
 * @param int $bot The lower bound of the interval.
 * @param int $top The upper bound of the interval.
 * @return int The integer middle index.
 */
function middleFor(int $bot, int $top): int
{
    $avg = ($bot + $top) / 2;
    return (int) (floor($avg));
}