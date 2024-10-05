""" Module Lasagna """
EXPECTED_BAKE_TIME = 40

def bake_time_remaining(elapsed_bake_time):
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - remaining bake time (in minutes) derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """
    return max(EXPECTED_BAKE_TIME - elapsed_bake_time, 0)


def preparation_time_in_minutes(number_of_layers):
    """Calculate the lasagna's preparation time
    :param number_of_layers: int - the number of layers in the lasagna
    :return: int - preparation time (in minutes) to prepare the lasagna

    The function receives an integer representing the number of layers in the
    lasagna and returns the amount of time needed to prepare a lasagna and
    according to the number of layers.
    """
    mins_per_layer = 2
    return mins_per_layer * number_of_layers


def elapsed_time_in_minutes(number_of_layers, elapsed_bake_time):
    """Calculate the elapsed cooking time.

    :param number_of_layers: int - the number of layers in the lasagna.
    :param elapsed_bake_time: int - elapsed cooking time.
    :return: int - total time elapsed (in minutes) preparing and cooking.

    This function takes two integers representing the number of lasagna layers and the
    time already spent baking and calculates the total elapsed minutes spent cooking the
    lasagna.
    """
    return preparation_time_in_minutes(number_of_layers) + elapsed_bake_time