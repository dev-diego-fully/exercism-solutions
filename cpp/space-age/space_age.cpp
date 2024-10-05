#include "space_age.h"

namespace space_age {

SpaceAge::SpaceAge( const long int seconds_lived ) {

    this->seconds_lived = seconds_lived;

}

long int SpaceAge::seconds() const {

    return this->seconds_lived;

}

double SpaceAge::on_mercury() const {

    const double mercurity_year_as_earth_year = 0.2408467;

    return this->on_earth() / mercurity_year_as_earth_year;

}

double SpaceAge::on_venus() const {

    const double venus_year_as_earth_year = 0.61519726;

    return this->on_earth() / venus_year_as_earth_year;

}

double SpaceAge::on_earth() const {

    const double earth_year_in_seconds = 31557600;

    return this->seconds_lived / earth_year_in_seconds;

}

double SpaceAge::on_mars() const {

    const double mars_year_as_earth_year = 1.8808158;

    return this->on_earth() / mars_year_as_earth_year;

}

double SpaceAge::on_jupiter() const {

    const double jupiter_year_as_earth_year = 11.862615;

    return this->on_earth() / jupiter_year_as_earth_year;

}

double SpaceAge::on_saturn() const {

    const double saturn_year_as_earth_year = 29.447498;

    return this->on_earth() / saturn_year_as_earth_year;

}

double SpaceAge::on_uranus() const {

    const double uranus_year_as_earth_year = 84.016846;

    return this->on_earth() / uranus_year_as_earth_year;

}

double SpaceAge::on_neptune() const {

    const double neptune_year_as_earth_year = 164.79132;

    return this->on_earth() / neptune_year_as_earth_year;

}

}  // namespace space_age
