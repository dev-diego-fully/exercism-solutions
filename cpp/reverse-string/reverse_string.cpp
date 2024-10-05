#include "reverse_string.h"

namespace reverse_string {

std::string reverse_string( const std::string &reversed ) {

    std::string result = reversed;

    std::reverse( result.begin(), result.end() );

    return result;

}

}  // namespace reverse_string
