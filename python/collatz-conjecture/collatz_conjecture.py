"""
Module for calculating the steps in the Collatz sequence.
"""


def steps(number: int) -> int:
    """
    Calculates the number of steps to reach 1 from the initial number
    in the Collatz sequence.

    Raises:
        ValueError: If the input is not a positive integer.
    """
    if number <= 0:
        raise ValueError("Only positive integers are allowed")

    total_steps: int = 0
    current: int = number

    while current > 1:
        current = _collatz(current)
        total_steps += 1

    return total_steps


def _collatz(number: int) -> int:
    """
    Returns the next number in the Collatz sequence.
    """
    return number // 2 if number % 2 == 0 else 3 * number + 1
