"""
Raindrops module: Converts a number into a string based on its factors.
"""

_raindrop_sounds: dict = {3: "Pling", 5: "Plang", 7: "Plong"}


def convert(number):
    """
    Converts a number to raindrop sounds or returns the number as a string.
    """
    sound = []

    for divisor, drop_sound in _raindrop_sounds.items():
        if _is_divisible(number, divisor):
            sound.append(drop_sound)

    if len(sound) < 1:
        return str(number)
    return "".join(sound)


def _is_divisible(dividend: int, divisor: int) -> bool:
    """
    Checks the divisibility of the first number by the second.
    """
    return dividend % divisor == 0
