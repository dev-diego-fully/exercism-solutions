package protein

import "errors"

// ErrInvalidBase indicates an invalid codon base.
var ErrInvalidBase = errors.New("invalid base")

// ErrStop indicates that a stop codon was encountered.
var ErrStop = errors.New("invalid stop")

// STOP_SIGNAL represents the stop signal in translation.
const STOP_SIGNAL = "STOP"

// CODONS_PATTERN is the regex pattern used to extract codons from an RNA string.
const CODONS_PATTERN = `\w{0,3}`

// codonTranslationMap maps RNA codons to protein names.
var codonTranslationMap = map[string]string{
	"AUG": "Methionine",
	"UUU": "Phenylalanine",
	"UUC": "Phenylalanine",
	"UUA": "Leucine",
	"UUG": "Leucine",
	"UCU": "Serine",
	"UCC": "Serine",
	"UCA": "Serine",
	"UCG": "Serine",
	"UAU": "Tyrosine",
	"UAC": "Tyrosine",
	"UGU": "Cysteine",
	"UGC": "Cysteine",
	"UGG": "Tryptophan",
	"UAA": "STOP",
	"UAG": "STOP",
	"UGA": "STOP",
}
