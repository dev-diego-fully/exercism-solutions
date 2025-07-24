<?php

declare(strict_types=1);

/**
 * Checks if a given year is a leap year.
 *
 * This function determines if a year is a leap year according to the Gregorian calendar rules:
 * - A year is a leap year if it is divisible by 4.
 * - However, if it is divisible by 100, it is NOT a leap year,
 * - unless it is also divisible by 400 (in which case it IS a leap year).
 *
 * @param int $year The year to check.
 * @return bool True if the year is a leap year, false otherwise.
 *
 * @example
 * isLeap(2000); // Returns true (divisible by 400)
 * isLeap(1900); // Returns false (divisible by 100 but not by 400)
 * isLeap(2004); // Returns true (divisible by 4 and not by 100)
 * isLeap(2003); // Returns false (not divisible by 4)
 */
function isLeap(int $year): bool
{
    return $year % 4 === 0 && ($year % 100 !== 0 || $year % 400 === 0);
}