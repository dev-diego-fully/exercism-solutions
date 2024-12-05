"""
Module for approximating the square root of a number using a binary search approach.
"""


def square_root(number: int) -> float:
    """
    Approximates the square root of a given number using binary search.

    This function iteratively narrows the range of possible values for the square
    root of `number` by comparing the square of the midpoint with the target number.

    Args:
        number (int): The number to find the square root of. Must be non-negative.

    Returns:
        float: The approximate square root of `number`.
    """
    [bot, mid, top] = [1, _get_middle(1, number), number]
    while True:
        mid_pow = mid**2
        if mid_pow == number:
            return mid
        [bot, mid, top] = _update_range(bot, top, mid, mid_pow, number)
    return mid


def _get_middle(bot: float, top: float) -> float:
    """
    Calculates the midpoint of two numbers, rounded to 8 decimal places.

    Args:
        bot (float): The lower bound of the range.
        top (float): The upper bound of the range.

    Returns:
        float: The midpoint of `bot` and `top`, rounded to 8 decimal places.
    """
    return round((bot + top) / 2, 8)


def _update_range(
    bot: float, top: float, mid: float, candidate: float, aim: float
) -> (float, float, float):
    """
    Updates the search range based on the comparison between `candidate` and `aim`.

    If `candidate` is greater than `aim`, the new range is adjusted to the lower
    half. Otherwise, it is adjusted to the upper half.

    Args:
        bot (float): The lower bound of the range.
        top (float): The upper bound of the range.
        mid (float): The current midpoint of the range.
        candidate (float): The square of `mid`.
        aim (float): The target value to approximate the square root of.

    Returns:
        tuple: A tuple containing the updated lower bound, midpoint, and upper bound.
    """
    if candidate > aim:
        return (bot, _get_middle(bot, mid), mid)
    return (mid, _get_middle(mid, top), top)
