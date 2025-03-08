#ifndef NUCLEOTIDE_COUNT_H
#define NUCLEOTIDE_COUNT_H

/**
 * Counts the occurrences of each nucleotide in a DNA strand.
 *
 * @param dna_strand The DNA strand to analyze.
 * @return A formatted string with the counts of A, C, G, and T, or NULL if the input is invalid.
 */
char *count(const char *dna_strand);

#endif