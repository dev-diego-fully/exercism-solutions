#pragma once

#include <array>
#include <string>
#include <vector>

namespace kindergarten_garden {

enum class Plants {
    clover,
    grass,
    violets,
    radishes
};

using GardenLine = std::vector<Plants>;

using GardenMap = std::vector<GardenLine>;

using KidPlants = std::array<Plants, 4>;

KidPlants plants(const std::string map, const std::string kid_name);

}  // namespace kindergarten_garden
