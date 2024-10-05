#include "triangle.h"
#include <stdexcept>

namespace triangle {

bool all_positive( const double a, const double b, const double c ) {

    return ( a > 0 ) && ( b > 0 ) && ( c > 0 );

}

bool satify_inequality( const double a, const double b, const double c ) {

    if( a + b <= c )
        return false;

    if( a + c <= b )
        return false;
    
    if( b + c <= a )
        return false;

    return true;

}

bool is_triangle( const double a, const double b, const double c ) {

    return all_positive( a, b, c ) && satify_inequality( a, b, c );

}

bool is_equilateral( const double a, const double b, const double c ) {

    return (a == b) && (a == c);

}

bool is_scalene( const double a, const double b, const double c ) {

    return (a != b) && (a != c) && (b != c);

}

Flavor kind( const double a, const double b, const double c ) {

    if( not is_triangle( a, b, c ) )
        throw std::domain_error( "Not a triangle type." );

    if( is_equilateral( a, b, c ) )
        return Flavor::equilateral;

    if( is_scalene( a, b, c ) )
        return Flavor::scalene;

    return Flavor::isosceles;

}

}  // namespace triangle
