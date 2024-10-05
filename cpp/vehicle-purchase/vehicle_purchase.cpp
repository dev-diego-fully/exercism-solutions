#include "vehicle_purchase.h"

namespace vehicle_purchase {

    // needs_license determines whether a license is needed to drive a type of vehicle. Only "car" and "truck" require a license.
    bool needs_license(std::string kind){

        return kind == "car" or kind == "truck";

    }

    // choose_vehicle recommends a vehicle for selection. It always recommends the vehicle that comes first in lexicographical order.
    std::string choose_vehicle(std::string option1, std::string option2) {

        const std::string default_message_part = " is clearly the better choice.";

        if( option1 < option2 ) {
            return option1 + default_message_part;
        }

        return option2 + default_message_part;

    }

    double remainder_for( double age ) {

        if( age < 3 )
            return 80;

        else if( age >= 10 )
            return 50;
        
        else
            return 70;

    }

    // calculate_resell_price calculates how much a vehicle can resell for at a certain age.
    double calculate_resell_price(double original_price, double age) {

        const double percent = 0.01;

        return original_price * remainder_for( age ) * percent;

    }

}  // namespace vehicle_purchase