<?php

declare(strict_types=1);

/**
 * Transcribes a DNA strand into an RNA strand.
 *
 * This function performs a direct character replacement to convert a DNA sequence
 * into its corresponding RNA sequence. The mapping is as follows:
 * - 'A' (Adenine) in DNA becomes 'U' (Uracil) in RNA.
 * - 'T' (Thymine) in DNA becomes 'A' (Adenine) in RNA.
 * - 'G' (Guanine) in DNA becomes 'C' (Cytosine) in RNA.
 * - 'C' (Cytosine) in DNA becomes 'G' (Guanine) in RNA.
 *
 * @param string $dna The DNA strand to transcribe (e.g., "GCTA").
 * @return string The transcribed RNA strand (e.g., "CGAU").
 *
 * @example
 * toRna("GCTA"); // Returns "CGAU"
 * toRna("ATGC"); // Returns "UACG"
 */
function toRna(string $dna): string
{
    return strtr($dna, "ATGC", "UACG");
}