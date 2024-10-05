#include "darts.h"

namespace darts {

enum class Target {
    Inner,
    Middle,
    Outer,
    Outside
};

float distance(const float x1, const float y1, const float x2, const float y2) {
    const float delta_x = x1 - x2;
    const float delta_y = y1 - y2;
    return std::sqrt(std::pow(delta_x, 2) + std::pow(delta_y, 2));
}

Target target(const float distance) {
    const int outer_distance = 10;
    const int middle_distance = 5;
    const int inner_distance = 1;

    if(distance <= inner_distance) {
        return Target::Inner;
    }
    if(distance <= middle_distance) {
        return Target::Middle;
    }
    if(distance <= outer_distance) {
        return Target::Outer;
    }
    return Target::Outside;
}

Target target(const float x, const float y) {
    return target(distance(x, y, 0, 0));
}

int score(Target target) {
    switch (target) {
        case Target::Inner:
            return 10;
        case Target::Middle:
            return 5;
        case Target::Outer:
            return 1;
        default:
            return 0;
    }
}

int score(const float x, const float y) {
    return score(target(x, y));
}

} // namespace darts