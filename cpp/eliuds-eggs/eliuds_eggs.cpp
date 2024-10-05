#include "eliuds_eggs.h"

namespace chicken_coop {

int positions_to_quantity(const unsigned int positions) noexcept {
    int quantity = 0;

    for(unsigned int i = positions; i > 0; i /= 2) {
        quantity += i % 2;
    }
    
    return quantity;
}

}  // namespace chicken_coop
