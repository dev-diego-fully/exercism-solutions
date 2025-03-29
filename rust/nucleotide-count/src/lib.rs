mod counter;
mod validating;

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    if validating::is_invalid_nucleotide(&nucleotide) {
        return Err(nucleotide);
    }
    match validating::validate_dna(dna) {
        Ok(_) => Ok(dna.chars().filter(|c| *c == nucleotide).count()),
        Err(v) => Err(v),
    }
}

pub fn nucleotide_counts(dna: &str) -> Result<counter::NucleotideCounter, char> {
    match validating::validate_dna(dna) {
        Err(c) => Err(c),
        Ok(_) => Ok(dna
            .chars()
            .fold(counter::new(), counter::update_nucleotide_count)),
    }
}
