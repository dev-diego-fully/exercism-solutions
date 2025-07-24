<?php

declare(strict_types=1);

/**
 * Classifies a number as perfect, deficient, or abundant based on its aliquot sum.
 *
 * An **aliquot sum** is the sum of a number's proper divisors (divisors excluding the number itself).
 * - A **perfect** number's aliquot sum equals the number itself.
 * - A **deficient** number's aliquot sum is less than the number itself.
 * - An **abundant** number's aliquot sum is greater than the number itself.
 *
 * @param int $number The positive integer to classify.
 * @return string The classification: "perfect", "deficient", or "abundant".
 * @throws InvalidArgumentException If the input number is not a positive integer.
 *
 * @example
 * getClassification(6);  // Returns "perfect" (divisors: 1, 2, 3; sum: 1+2+3 = 6)
 * getClassification(28); // Returns "perfect" (divisors: 1, 2, 4, 7, 14; sum: 1+2+4+7+14 = 28)
 * getClassification(8);  // Returns "deficient" (divisors: 1, 2, 4; sum: 1+2+4 = 7 < 8)
 * getClassification(15); // Returns "deficient" (divisors: 1, 3, 5; sum: 1+3+5 = 9 < 15)
 * getClassification(12); // Returns "abundant" (divisors: 1, 2, 3, 4, 6; sum: 1+2+3+4+6 = 16 > 12)
 * getClassification(24); // Returns "abundant" (divisors: 1, 2, 3, 4, 6, 8, 12; sum: 1+2+3+4+6+8+12 = 36 > 24)
 */
function getClassification(int $number): string
{
    if ($number <= 0) {
        throw new InvalidArgumentException("Invalid non positive number");
    }

    $divisorsSum = aliquoteSum($number);

    if ($divisorsSum === $number) {
        return "perfect";
    } else if ($divisorsSum < $number) {
        return "deficient";
    } else {
        return "abundant";
    }
}

/**
 * Calculates the sum of all proper divisors of a given number.
 *
 * Proper divisors are all positive divisors of a number, excluding the number itself.
 *
 * @param int $number The integer for which to calculate the aliquot sum.
 * @return int The sum of the number's proper divisors.
 *
 * @example
 * aliquoteSum(6);  // Returns 6
 * aliquoteSum(12); // Returns 16
 * aliquoteSum(8);  // Returns 7
 */
function aliquoteSum(int $number): int
{
    return array_sum(divisorsOf($number));
}

/**
 * Finds all proper divisors of a given positive integer.
 *
 * Proper divisors are all positive integers that divide the number evenly,
 * excluding the number itself.
 *
 * @param int $number The integer for which to find divisors.
 * @return array<int> An array of integers, where each element is a proper divisor of the number.
 *
 * @example
 * divisorsOf(6);  // Returns [1, 2, 3]
 * divisorsOf(12); // Returns [1, 2, 3, 4, 6]
 * divisorsOf(7);  // Returns [1]
 */
function divisorsOf(int $number): array
{
    $divisors = [];

    for ($candidate = 1; $candidate < $number; $candidate++) {
        if ($number % $candidate === 0) {
            array_push($divisors, $candidate);
        }
    }

    return $divisors;
}