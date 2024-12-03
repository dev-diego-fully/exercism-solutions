"""
Module for converting a DNA strand to RNA by translating each nucleotide.

This module provides functions to convert a DNA strand to its corresponding RNA strand.
Each nucleotide in the DNA sequence is translated according to a predefined mapping.
"""


def to_rna(dna_strand: str) -> str:
    """
    Converts a DNA strand to an RNA strand.

    This function translates each nucleotide in the DNA sequence to its
    corresponding RNA nucleotide using a nucleotide map. The translation
    is done for the entire string.

    :param dna_strand: str the DNA sequence to be converted
    :return: str the corresponding RNA sequence
    :raises ValueError: if an invalid nucleotide is found in the DNA strand
    """
    nucleotide_map: dict = get_nucletide_map()
    return "".join([translate_nucleotide(n, nucleotide_map) for n in dna_strand])


def translate_nucleotide(nucleotide: str, nucleotide_map: dict) -> str:
    """
    Translates a single nucleotide based on the nucleotide map.

    This function uses the provided nucleotide map to convert a single nucleotide
    to its corresponding RNA nucleotide.

    :param nucleotide: str a single nucleotide from the DNA sequence
    :param nucleotide_map: dict a dictionary mapping DNA nucleotides to RNA nucleotides
    :return: str the RNA equivalent of the nucleotide
    :raises ValueError: if the nucleotide is not a valid DNA nucleotide
    """
    try:
        return nucleotide_map[nucleotide]
    except KeyError as exc:
        raise ValueError(f"Invalid nucleotide: {nucleotide}") from exc


def get_nucletide_map():
    """
    Returns the nucleotide mapping for DNA to RNA translation.

    The function returns a dictionary that maps DNA nucleotides to their
    corresponding RNA nucleotides.

    :return: dict a dictionary with DNA nucleotides as keys and RNA nucleotides
    as values
    """
    return {"A": "U", "T": "A", "C": "G", "G": "C"}
