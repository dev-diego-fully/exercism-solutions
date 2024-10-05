#pragma once

#include <string>

namespace star_map {

enum class System {
    BetaHydri,
    Sol,
    EpsilonEridani,
    AlphaCentauri,
    DeltaEridani,
    Omicron2Eridani
};


};

namespace heaven {

class Vessel {

    public:
        int generation = 1;
        star_map::System current_system = star_map::System::Sol;
        int busters = 0;
        std::string name = "";

        Vessel( std::string name, int generation );
        Vessel( std::string name, int generation, star_map::System current_system );
        Vessel replicate( std::string a );

        bool shoot_buster();
        void make_buster();

};

std::string get_older_bob( Vessel a, Vessel b );
bool in_the_same_system( Vessel a, Vessel b );

}

