"""
Module for converting resistor color codes into numeric values and corresponding
metric units.

This module provides functionality to convert a list of resistor color
codes into a numeric value representing the resistance in ohms. It also
includes a way to convert this value into different metric
units such as ohms, kiloohms, megaohms, and gigaohms.

Functions:
    label(colors: list[str]) -> int: Converts a list of color codes to a
    resistor value in ohms and then to a metric unit.
"""


def label(colors: list[str]) -> int:
    """
    Converts a list of color codes representing a resistor's value into a metric.

    The first three colors are used to calculate the resistance value.
    The first two colors represent the tens and units, while the third represents
    the exponent of 10.

    Args:
        colors (list[str]): A list of color codes.

    Returns:
        int: The calculated resistor value in ohms.
    """
    [ten, unity, zeros] = map(_color_code, colors[:3])
    return _to_metric((ten * 10 + unity) * (10) ** zeros)


def _color_code(color: str) -> int:
    """
    Converts a color code to its corresponding number.

    The color code must be one of the predefined color codes for resistors.

    Args:
        color (str): A color code.

    Returns:
        int: The corresponding numeric value of the color.

    Raises:
        ValueError: If the color code is not valid.
    """
    try:
        return _colors.index(color)
    except ValueError as exc:
        raise ValueError(f"{color}") from exc


def _to_metric(ohms: int) -> str:
    """
    Converts a resistor value in ohms to its corresponding metric.

    This function checks which metric range the given resistor value falls into
    and converts it to the appropriate unit.

    Args:
        ohms (int): The resistor value in ohms.

    Returns:
        str: The resistor value converted to the appropriate metric unit.

    Raises:
        ValueError: If the resistor value is not covered by any metric range.
    """
    for metric_range in _metrics:
        if ohms in metric_range:
            return metric_range.parse(ohms)
    raise ValueError("Ohm range not covered.")


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


class MetricRange:
    """
    Represents a range of resistor values for a specific metric.

    This class is used to define the range of values covered by a metric, such as ohms,
    kiloohms, megaohms, etc. It also provides a method to convert a resistor value to the
    appropriate metric unit.

    Attributes:
        prefix (str): The prefix of the metric (e.g., 'kiloohms', 'megaohms').
        start (int): The start of the range.
        end (float): The end of the range.
        factor (int): The factor used for converting values within the range.
    """

    def __init__(self, prefix: str, start: int, end: float, factor: int = None):
        self.__start: int = start
        self.__end: float = end
        self.__prefix: str = prefix
        self.__factor: int = factor if factor else self.__start

    def __contains__(self, ohms: int) -> bool:
        """
        Checks if a given resistor value falls within this metric range.

        Args:
            ohms (int): The resistor value in ohms.

        Returns:
            bool: True if the resistor value is within the range, False otherwise.
        """
        return self.__start <= ohms <= self.__end

    def parse(self, ohms: int) -> str:
        """
        Converts the resistor value into a string representation in the appropriate metric.

        Args:
            ohms (int): The resistor value in ohms.

        Returns:
            str: The resistor value as a string in the appropriate metric (e.g., '1 kiloohm').
        """
        return f"{int(ohms/self.__factor)} {self.__prefix}"


_metrics: tuple = (
    MetricRange("ohms", 0, 1e3, 1),
    MetricRange("kiloohms", 1e3, 1e6),
    MetricRange("megaohms", 1e6, 1e9),
    MetricRange("gigaohms", 1e9, float("inf")),
)
