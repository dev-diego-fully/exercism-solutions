<?php

declare(strict_types=1);

/**
 * Extracts all contiguous substrings ("slices") of a specified length from a string of digits.
 *
 * This function takes a string of digits and generates an array of all possible
 * substrings of a given `series` length. For example, if the digits are "12345" and
 * the series length is 3, it will return ["123", "234", "345"].
 *
 * @param string $digits The input string containing only digits.
 * @param int $series The desired length of each slice.
 * @return array<string> An array of strings, where each string is a slice of the original digits.
 * @throws InvalidArgumentException If `series` is not positive or is longer than `digits`.
 *
 * @example
 * slices("12345", 3); // Returns ["123", "234", "345"]
 * slices("123", 1);   // Returns ["1", "2", "3"]
 * slices("45678", 2); // Returns ["45", "56", "67", "78"]
 */
function slices(string $digits, int $series): array
{
    if($series <= 0) {
        throw new InvalidArgumentException("Series len can only be positive");
    }

    $digitsCount = strlen($digits);

    if($digitsCount < $series) {
        throw new InvalidArgumentException("Series len can't be longer than the source number");
    }

    $limit = $digitsCount - $series + 1;
    $slices = [];

    for ($i = 0; $i < $limit; $i++) {
        array_push($slices, substr($digits, $i, $series));
    }

    return $slices;
}