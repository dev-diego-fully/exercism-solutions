"""
Module for finding anagrams in a list of words.

Provides a function to find anagrams of a reference word in a list, ignoring 
case and excluding the reference word itself.
"""


def find_anagrams(word: str, candidates: list[str]) -> list[str]:
    """
    Finds anagrams of a given word from a list of candidate words.

    Compares each candidate word to the reference word, ignoring case. The
    reference word itself is excluded from the results.

    Args:
        word (str): The reference word.
        candidates (list[str]): A list of candidate words.

    Returns:
        list[str]: A list of anagrams found in `candidates`.
    """
    lowered_word = word.lower()
    sorted_word_chars = sorted(lowered_word)
    return [
        candidate
        for candidate in candidates
        if ((lowered_candidate := candidate.lower()) != lowered_word)
        and sorted(lowered_candidate) == sorted_word_chars
    ]
