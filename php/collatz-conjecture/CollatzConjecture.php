<?php

declare(strict_types=1);

/**
 * Calculates the number of steps required to reach 1 following the Collatz conjecture rules.
 *
 * The Collatz conjecture states that starting with any positive integer,
 * if you repeatedly apply the rule (n/2 for even numbers, 3n+1 for odd numbers),
 * you will eventually reach 1. This function counts how many steps it takes.
 *
 * @param int $number The positive integer to start the Collatz sequence from.
 * @return int The number of steps to reach 1.
 * @throws InvalidArgumentException If the input number is not a positive integer.
 */
function steps(int $number): int
{
    if ($number <= 0) {
        throw new InvalidArgumentException("/Only positive integers are allowed");
    }

    $current = $number;

    for ($steps = 0; $current !== 1; $steps++) {
        $current = collatz($current);
    }

    return $steps;
}

/**
 * Applies the Collatz conjecture rule to a given number.
 *
 * If the number is even, it's divided by 2.
 * If the number is odd, it's multiplied by 3 and 1 is added.
 *
 * @param int $number The integer to apply the Collatz rule to.
 * @return int The result after applying the Collatz rule.
 */
function collatz(int $number): int
{
    if ($number % 2 === 0) {
        return $number / 2;
    } else {
        return 3 * $number + 1;
    }
}