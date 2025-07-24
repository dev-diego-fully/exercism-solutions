<?php

declare(strict_types=1);

/**
 * Reverses a given string.
 *
 * This function takes a string, splits it into an array of individual characters,
 * reverses the order of those characters, and then joins them back into a single string.
 *
 * @param string $text The input string to be reversed.
 * @return string The reversed string.
 *
 * @example
 * reverseString("hello"); // Returns "olleh"
 * reverseString("world"); // Returns "dlrow"
 * reverseString("12345"); // Returns "54321"
 */
function reverseString(string $text): string
{
    return implode(array_reverse(str_split($text)));
}