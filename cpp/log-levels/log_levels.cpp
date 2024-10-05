#include <string>

namespace log_line {
    std::string message(std::string line) {

        const std::string msg_predecessor = ":";
        const int distance_from_predecessor = 2;
        
        const int predecessor_index = line.find( msg_predecessor );
        const int msg_start = (
            predecessor_index + distance_from_predecessor
        );

        return line.substr( msg_start );

    }

    std::string log_level(std::string line) {

        const std::string level_predecessor = "[";
        const std::string level_sucessor = "]";
        const int char_jump = 1;

        const int level_start = line.find( level_predecessor ) + char_jump;
        const int level_end = line.find( level_sucessor ) - char_jump;
        const std::string level = line.substr( level_start, level_end );

        return level;

    }

    std::string reformat(std::string line) {

        return message(line) + " (" + log_level(line) + ")";

    }
}
