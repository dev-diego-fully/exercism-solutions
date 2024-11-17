"""
Module to check if a number is an Armstrong number.

An Armstrong number is a number that is equal to the sum of its digits 
raised to the power of the number of digits.
"""


def is_armstrong_number(number: int) -> bool:
    """
    Returns True if the number is an Armstrong number.
    """
    return _get_armstrong_value(number) == number


def _get_armstrong_value(number: int) -> int:
    """
    Calculates the sum of the digits raised to the power of the number of digits.
    This value is used to check if a number is an Armstrong number.
    """
    return sum(_get_armstrong_digits(number))


def _get_armstrong_digits(number: int) -> list[int]:
    """
    Raises each digit of the number to the power of the number of digits.
    """
    digits = _get_digits(number)
    return [digit ** len(digits) for digit in digits]


def _get_digits(number: int) -> list[int]:
    """
    Extracts and returns the digits of the number as a list of integers.
    """
    return [int(digit) for digit in str(number)]
