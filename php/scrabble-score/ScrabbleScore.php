<?php

declare(strict_types=1);

/**
 * Calculates the Scrabble score for a given word.
 *
 * This function sums the individual scores of each letter in the word.
 * It normalizes the input to uppercase before calculating the score.
 * Characters not defined in Scrabble scoring (e.g., spaces, punctuation) contribute 0 points.
 *
 * @param string $word The word for which to calculate the Scrabble score.
 * @return int The total Scrabble score for the word.
 *
 * @example
 * score('a');              // Returns 1
 * score('f');              // Returns 4
 * score('at');             // Returns 2
 * score('zoo');            // Returns 12
 * score('street');         // Returns 6
 * score('quirky');         // Returns 22
 * score('OxyphenButazone'); // Returns 41
 * score('');               // Returns 0
 * score('abcdefghijklmnopqrstuvwxyz'); // Returns 87
 */
function score(string $word): int
{
    $score = 0;

    foreach (normalizeChars($word) as $letter) {
        $score += letterScore($letter);
    }

    return $score;
}

/**
 * Returns the Scrabble score for a single letter.
 *
 * The scoring follows standard English Scrabble rules.
 *
 * @param string $letter The single letter (expected to be uppercase) to score.
 * @return int The Scrabble score for the letter. Returns 0 for invalid/unscored characters.
 */
function letterScore(string $letter): int
{
    return match ($letter) {
        'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T' => 1,
        'D', 'G' => 2,
        'B', 'C', 'M', 'P' => 3,
        'F', 'H', 'V', 'W', 'Y' => 4,
        'K' => 5,
        'J', 'X' => 8,
        'Q', 'Z' => 10,
        default => 0
    };
}

/**
 * Normalizes a given text string by converting it to uppercase and splitting it into an array of individual characters.
 *
 * This is a helper function to prepare the word for letter-by-letter scoring.
 *
 * @param string $text The input string to normalize.
 * @return array<string> An array of uppercase characters.
 */
function normalizeChars(string $text): array
{
    return str_split(strtoupper($text));
}