"""
Module for checking if a string is an isogram.

An isogram is a word or phrase in which no letter appears more than once, 
ignoring case. This module provides a function to check if the input string 
is an isogram by ensuring that each letter appears only once.

Functions:
    is_isogram(string: str) -> bool: Checks if the input string is an isogram.
"""


def is_isogram(string: str) -> bool:
    """
    Checks if a string is an isogram.

    An isogram is a word or phrase in which no letter appears more than once.
    This function checks whether all letters in the string appear at most once,
    ignoring case.

    :param string: str the input string to check
    :return: bool True if the string is an isogram, False otherwise
    """
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    lowered = string.lower()
    return all(lowered.count(letter) <= 1 for letter in alphabet)
