<?php

declare(strict_types=1);

/**
 * Calculates the prime factors of a given positive integer.
 *
 * This function finds all prime numbers that divide the input number without leaving a remainder.
 * The factors are returned in ascending order.
 *
 * @param int $number The positive integer for which to find prime factors.
 * @return array<int> An array containing the prime factors of the number.
 *
 * @example
 * factors(1);        // Returns []
 * factors(2);        // Returns [2]
 * factors(9);        // Returns [3, 3]
 * factors(8);        // Returns [2, 2, 2]
 * factors(12);       // Returns [2, 2, 3]
 * factors(901255);   // Returns [5, 17, 23, 461]
 */
function factors(int $number): array
{
    $limit = sqrt($number);
    $current = $number;
    $factors = [];

    $current = factorate($current, 2, $factors);

    for ($candidate = 3; $candidate <= $limit; $candidate += 2) {
        $current = factorate($current, $candidate, $factors);
    }

    if ($current !== 1) {
        array_push($factors, $current);
    }

    return $factors;
}

/**
 * Divides a number repeatedly by a given value as long as it's divisible,
 * adding the divisor to an output array for each division.
 *
 * This is a helper function used by `factors` to extract all occurrences of a specific prime factor.
 * The `$output` array is passed by reference to accumulate the factors.
 *
 * @param int $number The number to be factorized.
 * @param int $value The potential prime factor to test and divide by.
 * @param array<int> &$output A reference to the array where found factors will be added.
 * @return int The remaining number after all divisions by `$value` have occurred.
 */
function factorate(int $number, int $value, array &$output): int
{
    $current = $number;

    while ($current % $value === 0) {
        array_push($output, $value);
        $current /= $value;
    }

    return $current;
}