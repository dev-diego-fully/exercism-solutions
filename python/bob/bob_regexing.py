"""
Handles regex patterns and matching logic for Bob's response triggers.

This module centralizes all regular expression patterns and provides
functions to evaluate whether a string matches a given pattern.
"""

from re import search


def get_patterns() -> dict:
    """
    Provides a dictionary of regex patterns used to trigger Bob's responses.

    :return: dict a mapping of pattern names to their corresponding regex strings
    """
    return {
        "silence": r"^[\s]*$",
        "yelling": r"^(?!.*[a-z]).*[A-Z]",
        "question": r"\?\s*$",
    }


def regex_check(string: str, regex: str) -> bool:
    """
    Checks if a given string matches a regular expression.

    :param string: str the string to evaluate
    :param regex: str the regex pattern to match
    :return: bool True if the regex matches the string, False otherwise
    """
    return search(regex, string) is not None
