def equilateral(sides):
    return valid_triangle(sides) and unique_sides(sides) == 1


def isosceles(sides):
    return valid_triangle(sides) and unique_sides(sides) < 3


def scalene(sides):
    return valid_triangle(sides) and unique_sides(sides) == 3


def satisfies_inequalities(sides):
    [a, b, c] = sides
    return (
        satisfy_inequality([a, b, c])
        and satisfy_inequality([a, c, b])
        and satisfy_inequality([b, c, a])
    )


def satisfy_inequality(sides):
    return sides[0] + sides[1] >= sides[2]


def valid_triangle(sides):
    return all(map(lambda x: x > 0, sides)) and satisfies_inequalities(sides)


def unique_sides(sides):
    return len(set(sides))
