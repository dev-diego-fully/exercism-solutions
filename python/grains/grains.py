"""
Module to calculate the number of grains of wheat on a chessboard,
knowing that the number in each square doubles.
"""


def square(number: int) -> int:
    """Calculate the amount of grain that will be in the nth square on the chessboard.
    """
    if 1 <= number <= 64:
        return 2 ** (number - 1)
    raise ValueError("square must be between 1 and 64")


def total() -> int:
    """Calculate the amount of grains on the entire chessboard.
    """
    return sum(square(number) for number in range(1, 65))
