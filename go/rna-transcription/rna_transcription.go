package strand

import "strings"

// ToRNA transcribes a DNA string into an RNA string by applying
// the standard nucleotide complement rule (A → U, T → A, C → G, G → C).
// It does not validate the DNA string or handle invalid nucleotides.
func ToRNA(dna string) string {
	return strings.Map(getNucleotideComplement, dna)
}

// getNucleotideComplement returns the RNA complement for a given DNA nucleotide.
func getNucleotideComplement(nucleotide rune) rune {
	return nucleotidesComplements[nucleotide]
}

var nucleotidesComplements = map[rune]rune{
	'C': 'G',
	'G': 'C',
	'A': 'U',
	'T': 'A',
}
