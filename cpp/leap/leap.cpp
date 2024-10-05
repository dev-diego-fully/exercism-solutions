#include "leap.h"

namespace leap {

bool is_divisible( int value, int divisor ) {

    return value % divisor == 0;

}

bool is_leap_year( int year ) {

    if( not is_divisible( year, 4 ) )
        return false;

    if( is_divisible( year, 400 ) )
        return true;

    if( is_divisible( year, 100 ) )
        return false;

    return true;

}

}  // namespace leap
