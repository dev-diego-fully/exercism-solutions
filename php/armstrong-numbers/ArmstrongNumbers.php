<?php

declare(strict_types=1);

/**
 * Checks if a given number is an Armstrong number.
 *
 * An Armstrong number (also known as a narcissistic number, pluperfect digital invariant,
 * or Plus Perfect Number) is a number that is the sum of its own digits each raised
 * to the power of the number of digits.
 *
 * @param int $number The integer to check.
 * @return bool True if the number is an Armstrong number, false otherwise.
 *
 * @example
 * isArmstrongNumber(9);   // Returns true (9^1 = 9)
 * isArmstrongNumber(153); // Returns true (1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153)
 * isArmstrongNumber(10);  // Returns false (1^2 + 0^2 = 1 != 10)
 */
function isArmstrongNumber(int $number): bool
{
    return armstrongSum($number) === $number;
}

/**
 * Calculates the Armstrong sum for a given number.
 *
 * The Armstrong sum is the sum of each digit of the number raised to the power
 * of the total number of digits in the original number.
 *
 * @param int $number The integer for which to calculate the Armstrong sum.
 * @return int The calculated Armstrong sum.
 */
function armstrongSum(int $number): int
{
    $digits = digits($number);
    $digitsCount = count($digits);
    $sum = array_sum(array_map(fn(int $digit) => $digit ** $digitsCount, $digits));

    return (int) $sum;
}

/**
 * Extracts individual digits from an integer and returns them as an array.
 *
 * The digits are returned in their original order (from most significant to least significant).
 *
 * @param int $number The integer from which to extract digits.
 * @return array<int> An array of integers, where each element is a digit of the original number.
 *
 * @example
 * digits(153); // Returns [1, 5, 3]
 * digits(9);   // Returns [9]
 * digits(0);   // Returns []
 */
function digits(int $number): array
{
    $digits = [];

    for ($current = $number; $current > 0; $current = (int) ($current / 10)) {
        array_unshift($digits, $current % 10);
    }

    return $digits;
}