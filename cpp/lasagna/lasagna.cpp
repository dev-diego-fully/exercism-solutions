// ovenTime returns the amount in minutes that the lasagna should stay in the
// oven.
#include <algorithm>
int ovenTime() {

    return 40;

}

/* remainingOvenTime returns the remaining
   minutes based on the actual minutes already in the oven.
*/
int remainingOvenTime(int actualMinutesInOven) {
    
    const int min_time_oven = 0;

    return std::max( min_time_oven, ovenTime() - actualMinutesInOven );

}

/* preparationTime returns an estimate of the preparation time based on the
   number of layers and the necessary time per layer.
*/
int preparationTime(int numberOfLayers) {
    
    const int time_per_layer = 2;

    return numberOfLayers * time_per_layer;

}

// elapsedTime calculates the total time spent to create and bake the lasagna so
// far.
int elapsedTime(int numberOfLayers, int actualMinutesInOven) {

    return preparationTime( numberOfLayers ) + actualMinutesInOven;

}
