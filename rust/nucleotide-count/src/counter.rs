use std::collections::HashMap;

pub(crate) type NucleotideCounter = HashMap<char, usize>;

/// Returns a valid and completely zeroed nucleotide counter.
pub(crate) fn new() -> NucleotideCounter {
    [('A', 0), ('C', 0), ('G', 0), ('T', 0)]
        .into_iter()
        .collect()
}

/// Increments the count of the given nucleotide in the given counter.
pub(crate) fn update_nucleotide_count(
    mut counter: NucleotideCounter,
    nucleotide: char,
) -> NucleotideCounter {
    counter.entry(nucleotide).and_modify(|c| (*c += 1));
    counter
}
