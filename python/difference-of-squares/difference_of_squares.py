"""
Module for calculating the sum of squares, the square of the sum, and their difference.

Provides functions to:
- Calculate the square of the sum of numbers from 1 to `number`.
- Calculate the sum of the squares of numbers from 1 to `number`.
- Find the difference between the square of the sum and the sum of the squares.
"""


def square_of_sum(number: int) -> int:
    """
    Calculates the square of the sum of numbers from 1 to `number`.

    Args:
        number (int): The upper limit of the range.

    Returns:
        int: The square of the sum.
    """
    return sum(range(1, number + 1)) ** 2


def sum_of_squares(number: int) -> int:
    """
    Calculates the sum of the squares of numbers from 1 to `number`.

    Args:
        number (int): The upper limit of the range.

    Returns:
        int: The sum of the squares.
    """
    return sum(i**2 for i in range(1, number + 1))


def difference_of_squares(number: int) -> int:
    """
    Calculates the difference between the square of the sum and the sum of the squares
    of numbers from 1 to `number`.

    Args:
        number (int): The upper limit of the range.

    Returns:
        int: The difference between the square of the sum and the sum of the squares.
    """
    return square_of_sum(number) - sum_of_squares(number)
