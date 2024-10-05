"""Functions which helps the locomotive engineer to keep track of the train."""


def get_list_of_wagons(*args):
    """Return a list of wagons.

    :param: arbitrary number of wagons.
    :return: list - list of wagons.
    """
    return [*args]


def fix_list_of_wagons(each_wagons_id, missing_wagons):
    """Fix the list of wagons.

    :param each_wagons_id: list - the list of wagons.
    :param missing_wagons: list - the list of missing wagons.
    :return: list - list of wagons.
    """
    first, second, locomotive, *others_wagons = each_wagons_id
    return [locomotive, *missing_wagons, *others_wagons, first, second]


def add_missing_stops(departure_arrival, **kwargs):
    """Add missing stops to route dict.

    :param route: dict - the dict of routing information.
    :param: arbitrary number of stops.
    :return: dict - updated route dictionary.
    """
    departure, arrival = departure_arrival.values()
    stops = list(kwargs.values())
    return {"from": departure, "to": arrival, "stops": stops}


def extend_route_information(route, more_route_information):
    """Extend route information with more_route_information.

    :param route: dict - the route information.
    :param more_route_information: dict -  extra route information.
    :return: dict - extended route information.
    """
    copy = route.copy()
    for info, value in more_route_information.items():
        copy[info] = value
    return copy


def fix_wagon_depot(wagons_rows):
    """Fix the list of rows of wagons.

    :param wagons_rows: list[list[tuple]] - the list of rows of wagons.
    :return: list[list[tuple]] - list of rows of wagons.
    """
    colors_index = {}
    fixed_wagons = [[] for _ in range(len(wagons_rows))]
    #
    for row_index, row in enumerate(wagons_rows):
        for wagon_index, wagon in enumerate(row):
            _, wagon_color = wagon
            if wagon_color not in colors_index:
                colors_index[wagon_color] = row_index
            wagon_color_index = colors_index[wagon_color]
            fixed_wagons[wagon_index].insert(wagon_color_index, wagon)
    return fixed_wagons