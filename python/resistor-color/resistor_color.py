"""
Module for determining the numeric value of a resistor band based on its color.

This module provides functionality to retrieve the numeric value of a resistor 
color band and a list of all valid resistor colors.
"""


def color_code(color: str) -> int:
    """
    Returns the resistor color code for the given color name.

    This function maps a color name to its corresponding resistor color code
    (a number from 0 to 9). If the provided color is not valid, a ValueError
    is raised.

    :param color: str the name of the resistor color.
    :return: int the resistor color code corresponding to the color.
    :raises ValueError: if the provided color is not a valid resistor color.
    """
    try:
        return colors().index(color)
    except ValueError as exc:
        raise ValueError("Invalid resistor color: {color}") from exc


def colors() -> list:
    """
    Returns the list of valid resistor colors.

    The index of each color in the list corresponds to its numeric value
    in the resistor color code.

    :return: list a list of valid resistor colors in the standard order.
    """
    return [
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
    ]
