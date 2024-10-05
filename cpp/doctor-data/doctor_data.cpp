#include "doctor_data.h"

namespace heaven {


Vessel::Vessel( std::string name, int generation ) {
    this->name = name;
    this->generation = generation;
}

Vessel::Vessel( std::string name, int generation, star_map::System current_system ) {
    this->name = name;
    this->generation = generation;
    this->current_system = current_system;
}

Vessel Vessel::replicate( std::string name ) {
    return Vessel{name, this->generation + 1, this->current_system};
}

bool Vessel::shoot_buster() {
    if(this->busters > 0) {
        this->busters--;
        return true;
    }
    return false;
}

void Vessel::make_buster() {
    this->busters++;
};

std::string get_older_bob( Vessel a, Vessel b ) {

    if(a.generation < b.generation)
        return a.name;
    return b.name;

}

bool in_the_same_system( Vessel a, Vessel b ) {

    return a.current_system == b.current_system;

}

}
