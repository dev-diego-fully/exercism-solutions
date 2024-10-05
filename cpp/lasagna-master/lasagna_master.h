#pragma once

#include <vector>
#include <string>

namespace lasagna_master {

struct amount {
    int noodles;
    double sauce;
};

using ingredient = std::string;

template <typename T>
using layers = std::vector<T>;
using lasagna = layers<ingredient>;

int preparationTime( lasagna layers, int average_time_per_layer = 2 );
amount quantities( lasagna layers );
void addSecretIngredient( lasagna& my_lasagna, const lasagna& friends_lasagna );
std::vector<double> scaleRecipe( const std::vector<double>& quantities, int portions = 2 );
void addSecretIngredient( lasagna& my_lasagna, ingredient secret_ingredient );




}  // namespace lasagna_master
