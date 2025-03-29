/// Attempts to validate a provided DNA strand. If the strand contains
/// any invalid character as a nucleotide, returns an error
/// containing the first invalid character found.
pub(crate) fn validate_dna(candidate: &str) -> Result<(), char> {
    match candidate.chars().find(is_invalid_nucleotide) {
        None => Ok(()),
        Some(v) => Err(v),
    }
}

/// Returns true if the given character is not a valid DNA nucleotide.
pub(crate) fn is_invalid_nucleotide(candidate: &char) -> bool {
    !matches!(candidate, 'C' | 'G' | 'A' | 'T')
}
