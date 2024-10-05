#include "lasagna_master.h"
#include <vector>

namespace lasagna_master {

int last_layer( const lasagna& vec ) {

    return vec.size() - 1;

}

double scale( double value, double old_base, double new_base ) {

    return value/old_base * new_base;

}

int preparationTime( const lasagna layers, int average_time_per_layer ) {

    return layers.size() * average_time_per_layer;
    
}

amount quantities( const lasagna layers ) {

    const int layers_number = layers.size();
    const ingredient sauce = "sauce";
    const ingredient noodles = "noodles";
    const amount needed_per_layer = { 50, 0.2 };
    
    amount quantities_needed = {0, 0};

    for( int i = 0; i < layers_number; i++ ) {

        const ingredient current = layers.at( i );

        if( current == sauce )
            quantities_needed.sauce += needed_per_layer.sauce;

        else if( current == noodles )
            quantities_needed.noodles += needed_per_layer.noodles;


    }

    return quantities_needed;

}

void addSecretIngredient( lasagna& my_lasagna, const lasagna& friends_lasagna ) {

    const int my_last_layer = last_layer( my_lasagna );
    const int friends_last_layer = last_layer( friends_lasagna );

    my_lasagna[ my_last_layer ] = friends_lasagna.at( friends_last_layer );

}

std::vector<double> scaleRecipe(const std::vector<double> &quantities, int portions) {
    
    const int default_rendiment = 2;
    const int ingredient_number = quantities.size();
    std::vector<double> scaled;

    for( int i = 0; i < ingredient_number; i++ ) {
        
        const double current_quantity = quantities.at( i );

        scaled.push_back( scale( current_quantity, default_rendiment, portions ) );

    }

    return scaled;

}

void addSecretIngredient( lasagna& my_lasagna, ingredient secret_ingredient ) {

    const int last = last_layer( my_lasagna );

    my_lasagna[ last ] = secret_ingredient;

}

}  // namespace lasagna_master
