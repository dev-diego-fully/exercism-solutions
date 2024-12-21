package dna

import "errors"

// Histogram is a mapping from nucleotide to its count in given DNA.
type Histogram map[rune]int

// DNA is a list of nucleotides.
type DNA string

// Counts Generates a count of each nucleotide present in the DNA sequence.
// Missing nucleotides are explicitly marked with a count of 0.
// Returns an error if an invalid element is found as a nucleotide.
func (dna DNA) Counts() (Histogram, error) {
	var histogram Histogram = newHistogram()

	for _, nucleotide := range dna {
		if !isNucleotide[nucleotide] {
			return nil, errors.New("invalid nucleotide found")
		}
		histogram[nucleotide]++
	}

	return histogram, nil
}

// Creates a Histogram with the count of all nucleotides explicitly
// set to zero.
func newHistogram() Histogram {
	return map[rune]int{
		'A': 0,
		'T': 0,
		'C': 0,
		'G': 0,
	}
}

// Used to check whether or not a given street is valid as a nucleotide
var isNucleotide = map[rune]bool{
	'A': true,
	'T': true,
	'C': true,
	'G': true,
}
