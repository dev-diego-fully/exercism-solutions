"""
Module for checking if a sentence is a pangram.

This module provides a function `is_pangram` that determines whether a given sentence 
contains every letter of the English alphabet at least once, and a helper function 
`get_alphabet` to retrieve the alphabet.

Functions:
    is_pangram(sentence: str) -> bool: Checks if a sentence is a pangram.
    get_alphabet() -> str: Returns the English alphabet in lowercase.
"""


def is_pangram(sentence: str) -> bool:
    """
    Checks if the given sentence is a pangram.

    A pangram is a sentence that contains every letter of the alphabet at least once.

    :param sentence: str the sentence to check
    :return: bool True if the sentence is a pangram, False otherwise
    """
    lower: str = sentence.lower()
    return all(letter in lower for letter in get_alphabet())


def get_alphabet() -> str:
    """
    Returns the lowercase English alphabet.

    :return: str the English alphabet from 'a' to 'z'
    """
    return "abcdefghijklmnopqrstuvwxyz"
