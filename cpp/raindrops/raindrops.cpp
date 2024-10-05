#include "raindrops.h"
#include <string>

namespace raindrops {

std::string convert( int number ) {

    const RaindropSound sound_for_3 = "Pling";
    const RaindropSound sound_for_5 = "Plang";
    const RaindropSound sound_for_7 = "Plong";

    const bool is_divisible_by_3 = number % 3 == 0;
    const bool is_divisible_by_5 = number % 5 == 0;
    const bool is_divisible_by_7 = number % 7 == 0;
    const bool is_divisible_by_least_one = (
        is_divisible_by_3 or is_divisible_by_5 or is_divisible_by_7
    );

    std::string result;
    
    if( is_divisible_by_3 ) 
        result.append( sound_for_3 );

    if( is_divisible_by_5 )
        result.append( sound_for_5 );

    if( is_divisible_by_7 )
        result.append( sound_for_7 );

    if( not is_divisible_by_least_one )
        return std::to_string( number );

    return result;

}

}  // namespace raindrops
