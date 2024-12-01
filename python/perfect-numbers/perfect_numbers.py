"""
This module provides functionality to classify positive integers as "deficient,"
"perfect," or "abundant" based on the sum of their positive divisors.

Functions:
- classify: Determines the classification of a positive integer.
"""

from typing import Literal


def classify(number: int) -> Literal["deficient", "perfect", "abundant"]:
    """A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """
    _ensure_postive_integers(number)

    factors_sum: int = sum(_factors(number))
    if factors_sum < number:
        return "deficient"
    if factors_sum == number:
        return "perfect"
    return "abundant"


def _factors(number: int) -> list[int]:
    """Finds all positive divisors of a given integer except itself.

    :param number: int a positive integer
    :return: list[int] a list of positive divisors of the input integer
    """
    return [x for x in range(1, number) if number % x == 0]


def _ensure_postive_integers(number: int) -> None:
    """Ensures the input is a positive integer.

    :param number: int the integer to validate
    :raises ValueError: if the input integer is not positive
    """
    if number <= 0:
        raise ValueError("Classification is only possible for positive integers.")
