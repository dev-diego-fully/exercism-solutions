<?php

declare(strict_types=1);

/**
 * Counts the occurrences of each valid nucleotide (adenine, cytosine, thymine, guanine) in a DNA strand.
 *
 * This function processes a DNA input string, validates each character as a nucleotide,
 * and tallies their counts. It will throw an exception if any invalid nucleotide is encountered.
 *
 * @param string $input The DNA strand as a string (case-insensitive).
 * @return array<string, int> An associative array where keys are valid nucleotides ("a", "c", "t", "g")
 * and values are their respective counts.
 * @throws Exception If the input string contains any character that is not a valid nucleotide.
 *
 * @example
 * nucleotideCount("AGCT"); // Returns ["a" => 1, "c" => 1, "g" => 1, "t" => 1]
 * nucleotideCount("GATTACA"); // Returns ["a" => 3, "c" => 1, "g" => 1, "t" => 2]
 */
function nucleotideCount(string $input): array
{
    $counter = nucleotideCounter();
    $chars = str_split(strtolower($input));

    foreach ($chars as $char) {
        if (!isValidNucleotide($char)) {
            throw new Exception("Invalid Nucleotide: $char");
        }
        $counter[$char] += 1;
    }

    return $counter;
}

/**
 * Initializes and returns an associative array to store nucleotide counts, all set to zero.
 *
 * This function provides the base structure for counting "a", "c", "t", and "g" nucleotides.
 *
 * @return array<string, int> An associative array with "a", "c", "t", "g" as keys, initialized to 0.
 */
function nucleotideCounter(): array
{
    return ["a" => 0, "c" => 0, "t" => 0, "g" => 0];
}

/**
 * Checks if a given string represents a valid single nucleotide.
 *
 * A valid nucleotide is one of "a", "c", "t", or "g".
 *
 * @param string $candidate The character to validate as a nucleotide.
 * @return bool True if the candidate is a valid nucleotide, false otherwise.
 */
function isValidNucleotide(string $candidate): bool
{
    return in_array($candidate, NUCLEOTIDES);
}

/**
 * @var array<string> NUCLEOTIDES A constant array containing all valid lowercase DNA nucleotide characters.
 */
const NUCLEOTIDES = ["a", "c", "t", "g"];
