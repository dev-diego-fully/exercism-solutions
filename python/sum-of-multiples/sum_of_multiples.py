"""
Module for calculating the sum of multiples within a range up to a given limit.
"""


def sum_of_multiples(limit: int, multiples: list[int]) -> list[int]:
    """
    Calculates the sum of multiples of given values within the range from 1 to `limit`.

    Args:
        limit (int): The upper bound of the range.
        multiples (list[int]): A list of values to find multiples of.

    Returns:
        int: The sum of all multiples of the given values within the range.
    """
    cleaned_divers = tuple(m for m in multiples if m > 0)
    return sum(x for x in range(1, limit) if _has_divisor_in(x, cleaned_divers))


def _has_divisor_in(x: int, divers: list[int]) -> bool:
    """
    Checks if `x` is divisible by any of the values in `divers`.

    Args:
        x (int): The number to check for divisibility.
        divers (list[int]): The list of potential divisors.

    Returns:
        bool: `True` if `x` is divisible by any number in `divers`; otherwise, `False`.
    """
    return any(x % diver == 0 for diver in divers)
