"""
Module for implementing the Caesar cipher with letter rotation.

This module provides functionality to encrypt text using the Caesar cipher, 
a simple substitution cipher where each letter is shifted by a specified key.
Non-alphabetic characters remain unchanged.
"""


def rotate(text: str, key: int) -> str:
    """
    Encrypts a text using the Caesar cipher with a given key.

    Each letter in the input text is shifted by the specified key. Non-alphabetic
    characters remain unchanged.

    :param text: str the input text to encrypt.
    :param key: int the number of positions to shift each letter.
    :return: str the encrypted text after applying the Caesar cipher.
    """
    return "".join(rotate_letter(letter, key) for letter in text)


def rotate_letter(letter: str, key: int) -> str:
    """
    Rotates a single letter by a given key according to the Caesar cipher.

    The function shifts the letter by the key while maintaining its case (uppercase
    or lowercase). Non-alphabetic characters are returned unchanged.

    :param letter: str the letter to rotate.
    :param key: int the number of positions to shift the letter.
    :return: str the rotated letter or the original character if not alphabetic.
    """
    if not letter.isalpha():
        return letter
    case_start = ord("A") if letter.isupper() else ord("a")
    return chr(case_start + rotate_position(ord(letter) - case_start, key))


def rotate_position(position: int, key: int) -> int:
    """
    Calculates the new position of a letter after applying the Caesar cipher shift.

    The function ensures that the position wraps around within the bounds of the
    alphabet (0-25).

    :param position: int the current position of the letter (0-25).
    :param key: int the number of positions to shift.
    :return: int the new position after applying the shift.
    """
    alphabet_size = 26
    return (position + key) % alphabet_size
