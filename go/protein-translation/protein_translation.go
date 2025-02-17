// Package protein translates RNA sequences into proteins.
package protein

import (
	"math"
	"regexp"
)

// FromRNA converts an RNA string into a slice of proteins.
// Returns an error if an invalid codon base is encountered.
func FromRNA(rna string) ([]string, error) {
	codons := regexp.
		MustCompile(CODONS_PATTERN).
		FindAllString(rna, math.MaxInt32)

	proteins := []string{}
	for _, codon := range codons {
		translation, err := FromCodon(codon)

		if err == ErrInvalidBase {
			return nil, ErrInvalidBase
		}

		if err == ErrStop {
			break
		}

		proteins = append(proteins, translation)
	}

	return proteins, nil
}

// FromCodon converts a codon string into its corresponding protein.
// Returns an error for invalid bases or when a stop codon is encountered.
func FromCodon(codon string) (string, error) {
	translation, present := codonTranslationMap[codon]

	if !present {
		return "", ErrInvalidBase
	}

	if translation == STOP_SIGNAL {
		return "", ErrStop
	}

	return translation, nil
}
