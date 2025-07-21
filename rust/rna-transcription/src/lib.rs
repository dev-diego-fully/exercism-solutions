//! This module provides structures and methods for representing and transcribing DNA and RNA sequences.
//! It includes validation for nucleotide sequences and functionality to transcribe DNA to RNA.

/// Represents a DNA (Deoxyribonucleic Acid) sequence.
///
/// A DNA sequence is composed of the nucleotides Adenine (A), Thymine (T), Cytosine (C), and Guanine (G).
#[derive(Debug, PartialEq, Eq)]
pub struct Dna {
    dna: String,
}

/// Represents an RNA (Ribonucleic Acid) sequence.
///
/// An RNA sequence is composed of the nucleotides Adenine (A), Uracil (U), Cytosine (C), and Guanine (G).
#[derive(Debug, PartialEq, Eq)]
pub struct Rna {
    rna: String,
}

impl Dna {
    /// Creates a new `Dna` instance from a string slice.
    ///
    /// The string is validated to ensure it contains only valid DNA nucleotides ('A', 'T', 'C', 'G').
    ///
    /// # Arguments
    ///
    /// * `dna` - A string slice representing the DNA sequence.
    ///
    /// # Returns
    ///
    /// * `Ok(Dna)` - A `Dna` instance if the input string is a valid DNA sequence.
    /// * `Err(usize)` - The index of the first invalid character if the input string contains invalid nucleotides.
    pub fn new(dna: &str) -> Result<Dna, usize> {
        match find_index(dna.chars(), Self::is_invalid_nucleotide) {
            Some(index) => Err(index),
            None => Ok(Self {
                dna: dna.to_owned(),
            }),
        }
    }

    /// Transcribes the `Dna` sequence into an `Rna` sequence.
    ///
    /// During transcription, Thymine (T) in DNA is replaced by Uracil (U) in RNA,
    /// while Adenine (A), Cytosine (C), and Guanine (G) remain unchanged.
    ///
    /// # Returns
    ///
    /// An `Rna` instance representing the transcribed sequence.
    pub fn into_rna(self) -> Rna {
        Rna {
            rna: self
                .dna
                .chars()
                .flat_map(Self::translate_nucleotide)
                .collect(),
        }
    }

    /// Checks if a given character is an invalid DNA nucleotide.
    ///
    /// Valid DNA nucleotides are 'A', 'T', 'C', 'G'.
    ///
    /// # Arguments
    ///
    /// * `nuc` - The character to check.
    ///
    /// # Returns
    ///
    /// `true` if the character is not a valid DNA nucleotide, `false` otherwise.
    fn is_invalid_nucleotide(nuc: char) -> bool {
        !matches!(nuc, 'A' | 'T' | 'C' | 'G')
    }

    /// Translates a single DNA nucleotide to its corresponding RNA nucleotide.
    ///
    /// 'A' -> 'U'
    /// 'T' -> 'A'
    /// 'C' -> 'G'
    /// 'G' -> 'C'
    ///
    /// # Arguments
    ///
    /// * `nucletiode` - The DNA nucleotide character to translate.
    ///
    /// # Returns
    ///
    /// `Some(char)` containing the translated RNA nucleotide, or `None` if the input is not a valid DNA nucleotide.
    fn translate_nucleotide(nucletiode: char) -> Option<char> {
        match nucletiode {
            'A' => Some('U'),
            'T' => Some('A'),
            'C' => Some('G'),
            'G' => Some('C'),
            _ => None,
        }
    }
}

impl Rna {
    /// Creates a new `Rna` instance from a string slice.
    ///
    /// The string is validated to ensure it contains only valid RNA nucleotides ('A', 'U', 'C', 'G').
    ///
    /// # Arguments
    ///
    /// * `rna` - A string slice representing the RNA sequence.
    ///
    /// # Returns
    ///
    /// * `Ok(Rna)` - An `Rna` instance if the input string is a valid RNA sequence.
    /// * `Err(usize)` - The index of the first invalid character if the input string contains invalid nucleotides.
    pub fn new(rna: &str) -> Result<Rna, usize> {
        match find_index(rna.chars(), Self::is_invalid_nucleotide) {
            Some(index) => Err(index),
            None => Ok(Self {
                rna: rna.to_owned(),
            }),
        }
    }

    /// Checks if a given character is an invalid RNA nucleotide.
    ///
    /// Valid RNA nucleotides are 'A', 'U', 'C', 'G'.
    ///
    /// # Arguments
    ///
    /// * `nuc` - The character to check.
    ///
    /// # Returns
    ///
    /// `true` if the character is not a valid RNA nucleotide, `false` otherwise.
    fn is_invalid_nucleotide(nuc: char) -> bool {
        !matches!(nuc, 'A' | 'U' | 'C' | 'G')
    }
}

/// Finds the first index in an iterator where a `finder` function returns `true`.
///
/// This is a generic helper function that can be used to locate elements
/// that satisfy a certain condition within any iterator.
///
/// # Type Parameters
///
/// * `T` - The type of items yielded by the iterator.
///
/// # Arguments
///
/// * `iter` - An iterator over items of type `T`.
/// * `finder` - A closure or function that takes an item of type `T` and returns `true` if it matches the desired condition.
///
/// # Returns
///
/// `Some(usize)` - The 0-based index of the first item for which `finder` returns `true`.
/// `None` - If no item in the iterator satisfies the condition.
fn find_index<T>(iter: impl Iterator<Item = T>, finder: impl Fn(T) -> bool) -> Option<usize> {
    for (index, val) in iter.enumerate() {
        if finder(val) {
            return Some(index);
        }
    }

    None
}