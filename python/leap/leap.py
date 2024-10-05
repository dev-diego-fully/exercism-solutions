"""
Module for check is a year is a leap year
"""

def leap_year(year: int) -> bool:
    """
    Check if a year is a leap year
    """
    def is_div(a: int, b: int) -> bool:
        """
        Checks if the first value is is_divisible by second value
        """
        return a % b == 0 if b != 0 else False

    return is_div(year, 4) and not is_div(year, 100) or is_div(year, 400)
