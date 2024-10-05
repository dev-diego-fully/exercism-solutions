#include "grains.h"
#include <cmath>

namespace grains {

unsigned long long square( const unsigned int nth ) {

    const unsigned int base = 2;
    const unsigned int nth_tile_pow = nth - 1;

    return std::pow( base, nth_tile_pow );

}

unsigned long long total() {

    const int chess_tiles_number = 64;
    unsigned long long total_grains = 0;

    for( int i = 1; i <= chess_tiles_number; i++ ) {

        total_grains += square( i );

    }

    return total_grains;

}

}  // namespace grains
