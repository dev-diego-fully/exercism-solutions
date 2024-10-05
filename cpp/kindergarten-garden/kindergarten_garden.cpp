#include "kindergarten_garden.h"


namespace kindergarten_garden {


Plants plant_for(const char c) {
    switch (c) {
        case 'G':
            return Plants::grass;
        case 'C':
            return Plants::clover;
        case 'R':
            return Plants::radishes;
        default:
            return Plants::violets;         
    }
}

bool maps_plant(const char c) {
    switch (c) {
        case 'G':
        case 'C':
        case 'R':
        case 'V':
            return true;
        default:
            return false;        
    }
}

bool new_garden_line(const char c) {
    return c == '\n';
}

int kid_number(const std::string kid_name) {
    return kid_name.at(0) - 'A';
}

GardenMap parse_garden_map(std::string str_map) {
    GardenMap garden_map{{}};

    for(const char c: str_map) {
        if(new_garden_line(c)) {
            garden_map.push_back({});
        }
        if(maps_plant(c)) {
            garden_map.back().push_back(plant_for(c));
        }
    }

    return garden_map;
}


KidPlants plants(GardenMap map, int kid_num) {
    const size_t kids_plants_per_line = 2;
    const size_t kid_plants_start = kid_num * kids_plants_per_line;

    KidPlants kid_plants{};
    int plants_count = 0;

    for(size_t i = 0; i < map.size(); i++) {
        const GardenLine current_line = map.at(i);
        kid_plants[plants_count++] = current_line.at(kid_plants_start);
        kid_plants[plants_count++] = current_line.at(kid_plants_start + 1);
    }

    return kid_plants;
}

KidPlants plants(const std::string map, const std::string kid_name) {
    return plants(parse_garden_map(map), kid_number(kid_name));
}


}  // namespace kindergarten_garden
