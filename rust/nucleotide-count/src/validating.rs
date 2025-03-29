pub(crate) fn validate_dna(candidate: &str) -> Result<(), char> {
    match candidate.chars().find(is_invalid_nucleotide) {
        None => Ok(()),
        Some(v) => Err(v),
    }
}

pub(crate) fn is_invalid_nucleotide(candidate: &char) -> bool {
    !matches!(candidate, 'C' | 'G' | 'A' | 'T')
}
