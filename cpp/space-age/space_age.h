#if !defined(SPACE_AGE_H)
#define SPACE_AGE_H

namespace space_age {

class SpaceAge {

    private:
        long int seconds_lived = 0;
    
    public:

        SpaceAge( const long int seconds_lived );
        long int seconds() const;
        double on_mercury() const;
        double on_venus() const;
        double on_earth() const;
        double on_mars() const;
        double on_jupiter() const;
        double on_saturn() const;
        double on_neptune() const;
        double on_uranus() const;

};

using space_age = SpaceAge;

}  // namespace space_age

#endif // SPACE_AGE_H