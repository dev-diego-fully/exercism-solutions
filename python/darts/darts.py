"""
Module for calculating the score based on distance from a target center.

This module provides functions to compute the score based on a given coordinate
and the proximity to various target areas, each with different scores based on their
radius.
"""

from math import sqrt


def score(x: float, y: float) -> int:
    """
    Calculates the score based on the distance from a target center.

    This function computes the distance from the given (x, y) coordinate to the
    target center, then checks which target area (inner, middle, outer) the
    coordinate falls into, returning the corresponding score.

    :param x: float the x-coordinate of the point
    :param y: float the y-coordinate of the point
    :return: int the score corresponding to the target area
    :raises ValueError: if no target area can be matched (should not occur in valid cases)
    """
    distance_from_center = distance((x, y), get_center())
    targets = get_target()
    for target in targets.values():
        if target.hits(distance_from_center):
            return target.score
    raise ValueError("Impossible error")


def distance(coord_a: tuple[float, float], coord_b: tuple[float, float]):
    """
    Computes the Euclidean distance between two points in a 2D space.

    :param coord_a: tuple the first point as (x, y)
    :param coord_b: tuple the second point as (x, y)
    :return: float the distance between the two points
    """
    (ax, ay), (bx, by) = coord_a, coord_b
    dx, dy = ax - bx, ay - by
    return sqrt(dx**2 + dy**2)


def get_center() -> tuple[float, float]:
    """
    Returns the center coordinate of the target area.

    The center is always fixed at (0.0, 0.0) for this system.

    :return: tuple the coordinates of the target center as (x, y)
    """
    return (0.0, 0.0)


def get_target() -> dict:
    """
    Returns the dictionary of target areas and their associated properties.

    This function returns a dictionary where each key is the name of a target area
    (e.g., "inner", "middle", "outer", "out of target") and the corresponding value is
    an instance of the `TargetArea` class. Each `TargetArea` instance has a radius and a score
    associated with it. The function is used to determine which target a point falls into
    based on its distance from the center.

    :return: dict a dictionary mapping target names to `TargetArea` instances, where each
             `TargetArea` has a radius and a score.
    """
    return {
        "inner": TargetArea(1, 10),
        "middle": TargetArea(5, 5),
        "outer": TargetArea(10, 1),
        "out of target": TargetArea(float("inf"), 0),
    }


class TargetArea:
    """
    Represents a target area with a defined radius and score.

    The `TargetArea` class is used to define areas with a certain radius, and the score
    assigned to any point that falls within that radius.

    Attributes:
        radius (float): The radius of the target area.
        score (int): The score awarded if a point is within the target's radius.
    """

    def __init__(self, radius: float, target_score: int):
        """
        Initializes a TargetArea instance with a specified radius and score.

        :param radius: float the radius of the target area.
        :param target_score: int the score assigned to this target area.
        """
        self.__radius: float = radius
        self.__score: int = target_score

    @property
    def score(self) -> int:
        """
        Returns the score for the target area.
        """
        return self.__score

    def hits(self, distance_from_center: float) -> bool:
        """
        Determines whether a given distance from the center falls within the target's radius.

        :param distance_from_center: float the distance from the center to the point being checked.
        :return: bool True if the distance is less than or equal to the target's radius,
        False otherwise.
        """
        return distance_from_center <= self.__radius
