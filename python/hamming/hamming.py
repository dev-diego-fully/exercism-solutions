"""
Module for calculating the Hamming distance between two strings.
"""


def distance(strand_a: str, strand_b: str) -> int:
    """
    Calculates the Hamming distance between two strings.

    The Hamming distance is the number of positions at which the strings differ.
    The strings must be of equal length.

    Args:
        strand_a (str): The first string.
        strand_b (str): The second string.

    Returns:
        int: The Hamming distance between the two strings.

    Raises:
        ValueError: If the strings have different lengths.
    """
    if len(strand_a) != len(strand_b):
        raise ValueError("Strands must be of equal length.")
    return sum(1 for pair in zip(strand_a, strand_b) if pair[0] != pair[1])
