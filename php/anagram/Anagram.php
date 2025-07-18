<?php

declare(strict_types=1);

/**
 * Detects anagrams for a given word from a list of candidates.
 *
 * An anagram is a word or phrase formed by rearranging the letters of a different
 * word or phrase, typically using all the original letters exactly once.
 * This function first normalizes the source word and then compares it
 * with normalized versions of the candidate words, after filtering out
 * exact matches (case-insensitive) of the source word itself.
 *
 * @param string $word The source word for which to find anagrams.
 * @param array<string> $anagrams An array of candidate words to check for anagrams.
 * @return array<string> An array containing all detected anagrams from the candidate list.
 */
function detectAnagrams(string $word, array $anagrams): array
{
    $normalized = normalize($word);

    return array_filter(
        justNonRepeateds($word, $anagrams),
        fn(string $cand) => normalize($cand) === $normalized
    );
}

/**
 * Normalizes a string by converting it to lowercase, splitting it into characters,
 * sorting the characters, and then rejoining them.
 *
 * This function is used to create a canonical representation of a word,
 * which is useful for comparing strings regardless of their original casing
 * or character order, particularly for anagram detection.
 *
 * @param string $source The input string to normalize.
 * @return string The normalized string.
 */
function normalize(string $source): string
{
    $copy = str_split(strtolower($source));

    sort($copy);

    return implode("", $copy);
}

/**
 * Filters a list of candidate words, returning only those that are not identical
 * (case-insensitively) to the source word.
 *
 * This helps in avoiding the detection of the source word itself as an anagram.
 *
 * @param string $source The original word against which candidates are compared.
 * @param array<string> $list An array of candidate words to filter.
 * @return array<string> A filtered array containing only candidates that are not the same as the source word.
 */
function justNonRepeateds(string $source, array $list): array
{
    $lowered = strtolower($source);

    return array_filter($list, fn(string $cand) => strtolower($cand) !== $lowered);
}

