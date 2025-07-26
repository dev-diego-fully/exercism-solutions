<?php

declare(strict_types=1);

/**
 * Applies a given accumulator function to each element of an input array,
 * returning a new array with the results.
 *
 * This function is similar to `array_map` but is named `accumulate` in this context.
 * It iterates through each `$value` in the `$input` array and passes it to the
 * `$accumulator` callable. The return value of the accumulator is then added
 * to the `$result` array.
 *
 * @param array $input The input array whose elements will be processed.
 * @param callable $accumulator A callable function that accepts one argument (an element from `$input`)
 * and returns a transformed value.
 * @return array A new array containing the results of applying the accumulator function
 * to each element of the input array.
 *
 * @example
 * // Accumulate squares of numbers
 * accumulate([1, 2, 3], fn($value) => $value ** 2); // Returns [1, 4, 9]
 *
 * // Accumulate uppercase versions of strings
 * accumulate(['Hello', 'World!'], fn($string) => mb_strtoupper($string)); // Returns ['HELLO', 'WORLD!']
 *
 * // Accumulate using a built-in function
 * accumulate([" Hello\t", "\t World!\n "], 'trim'); // Returns ['Hello', 'World!']
 *
 * // Accumulate using a static method (assuming 'Str' class and 'len' method exist)
 * accumulate(['Hello', 'World!'], 'Str::len'); // Returns [5, 6]
 */
function accumulate(array $input, callable $accumulator): array
{
    $result = [];

    foreach ($input as $value) {
        array_push($result, $accumulator($value));
    }

    return $result;
}