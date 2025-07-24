<?php

declare(strict_types=1);

/**
 * Calculates the square of the sum of the first 'max' natural numbers.
 *
 * This function uses the formula for the sum of the first 'n' natural numbers,
 * which is `n * (n + 1) / 2`, and then squares the result.
 *
 * @param int $max The upper limit (n) of the natural numbers.
 * @return int The square of the sum of natural numbers up to 'max'.
 */
function squareOfSum(int $max): int
{
    return ($max ** 2 * ($max + 1) ** 2) / 4;
}

/**
 * Calculates the sum of the squares of the first 'max' natural numbers.
 *
 * This function uses the formula for the sum of the squares of the first 'n' natural numbers,
 * which is `n * (n + 1) * (2n + 1) / 6`.
 *
 * @param int $max The upper limit (n) of the natural numbers.
 * @return int The sum of the squares of natural numbers up to 'max'.
 */
function sumOfSquares(int $max): int
{
    return $max * ($max + 1) * (2 * $max + 1) / 6;
}

/**
 * Calculates the difference between the square of the sum and the sum of the squares
 * of the first 'max' natural numbers.
 *
 * This is a common mathematical problem, often related to number theory exercises.
 *
 * @param int $max The upper limit (n) of the natural numbers.
 * @return int The calculated difference.
 */
function difference(int $max): int
{
    return squareOfSum($max) - sumOfSquares($max);
}