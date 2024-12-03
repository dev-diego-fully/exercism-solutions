"""
Module for checking if a string is an isogram.

An isogram is a word or phrase in which no letter appears more than once, 
ignoring case. This module provides a function to check if the input string 
is an isogram by ensuring that each letter appears only once.

Functions:
    is_isogram(string: str) -> bool: Checks if the input string is an isogram.
"""

import re


def is_isogram(string: str) -> bool:
    """
    Checks if a string is an isogram.

    An isogram is a word or phrase in which no letter appears more than once.
    This function checks whether all letters in the string appear at most once,
    ignoring case.

    :param string: str the input string to check
    :return: bool True if the string is an isogram, False otherwise
    """
    normalized = normalize(string)
    print(normalized)
    return len(set(normalized)) == len(normalized)


def normalize(string: str) -> str:
    """
    Removes non-alphabetic characters from a string and converts it to lowercase.

    This function filters out any characters that are not letters (A-Z or a-z)
    and returns the resulting string in lowercase, making it suitable for
    case-insensitive and alphabetic-only processing.

    :param string: str the input string to normalize.
    :return: str the normalized string containing only lowercase alphabetic characters.
    """
    return re.sub(r"[^a-zA-Z]", "", string).lower()
