"""Solution to Ellen's Alien Game exercise."""


class Alien:
    """Create an Alien object with location x_coordinate and y_coordinate.

    Attributes
    ----------
    (class)total_aliens_created: int
    x_coordinate: int - Position on the x-axis.
    y_coordinate: int - Position on the y-axis.
    health: int - Number of health points.

    Methods
    -------
    hit(): Decrement Alien health by one point.
    is_alive(): Return a boolean for if Alien is alive (if health is > 0).
    teleport(new_x_coordinate, new_y_coordinate): Move Alien object to new coordinates.
    collision_detection(other): Implementation TBD.
    """

    total_aliens_created: int = 0

    def __init__(self, x_coordinate: int, y_coordinate: int):
        Self = type(self)
        Self.total_aliens_created += 1
        self.x_coordinate = x_coordinate
        self.y_coordinate = y_coordinate
        self.health = 3

    def hit(self):
        """
        Decrements alien's health
        """
        if self.is_alive():
            self.health -= 1

    def is_alive(self) -> bool:
        """
        Check if alien is health isn't zero
        :return: bool
        """
        return self.health > 0

    def teleport(self, new_x_coordinate: int, new_y_coordinate: int):
        """
        Teleport the alien for a new place specified by the coordinations pair
        """
        self.x_coordinate = new_x_coordinate
        self.y_coordinate = new_y_coordinate

    def collision_detection(self, subject) -> bool:
        """
        Check if alien's colides with a subject
        """
        pass


def new_aliens_collection(locations: tuple[tuple[int, int]]):
    """
    Create a list of aliens from a location list
    :param locations: tuple[tuple[int, int]]
    :return: list[Alien]
    """
    return [Alien(*location) for location in locations]
