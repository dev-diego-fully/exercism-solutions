mod counter;
mod validating;

/// Attempts to return the individual count of a nucleotide
/// in the given DNA strand. Fails if the nucleotide is invalid
/// or the strand contains invalid nucleotides.
pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    if validating::is_invalid_nucleotide(&nucleotide) {
        return Err(nucleotide);
    }
    match validating::validate_dna(dna) {
        Ok(_) => Ok(dna.chars().filter(|c| *c == nucleotide).count()),
        Err(v) => Err(v),
    }
}

/// Attempts to return a count of each nucleotide present
/// in the given DNA strand. Fails if the DNA strand contains
/// invalid nucleotides. Fails to return the first invalid
/// nucleotide found.
pub fn nucleotide_counts(dna: &str) -> Result<counter::NucleotideCounter, char> {
    match validating::validate_dna(dna) {
        Err(c) => Err(c),
        Ok(_) => Ok(dna
            .chars()
            .fold(counter::new(), counter::update_nucleotide_count)),
    }
}
