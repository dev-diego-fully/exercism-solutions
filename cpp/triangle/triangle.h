#pragma once

#if !defined(TRIANGLE_H)
#define TRIANGLE_H

#include <unordered_set>

namespace triangle {

enum class Flavor {
    equilateral,
    isosceles,
    scalene
};

Flavor kind( const double a, const double b, const double c );

using flavor = Flavor;

}  // namespace triangle

#endif // TRIANGLE_H