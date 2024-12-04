"""
Module for calculating the value of a resistor based on its color code.

This module provides functionality for determining the value of a resistor by
interpreting its color bands. The `value` function calculates the resistor's
value using the first two colors from a list representing the color bands.

The color codes are mapped to numbers using a predefined set of standard colors.

Functions:
- value: Calculates the resistor value based on the first two color bands.
"""


def value(colors: list[str]) -> int:
    """
    Calculates the resistor value based on the first two color codes.

    This function interprets the first two colors from the input list as
    digits of a two-digit number. The first color code represents the tens
    place, and the second color code represents the ones place.

    :param colors: list of str the list of color codes for the resistor.
    :return: int the calculated resistor value.
    """
    [c1, c2] = colors[:2]
    return _color_code(c1) * 10 + _color_code(c2)


def _color_code(color: str) -> int:
    """
    Returns the numeric code for the given resistor color.

    This function maps the color name to its corresponding resistor color
    code (a number from 0 to 9). If the provided color is not valid, a
    ValueError is raised.

    :param color: str the name of the resistor color.
    :return: int the numeric code corresponding to the color.
    :raises ValueError: if the provided color is not a valid resistor color.
    """
    try:
        return _colors.index(color)
    except ValueError as exc:
        raise ValueError(f"Invalid resistor color: {color}.") from exc


_colors: tuple[str] = (
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white",
)
