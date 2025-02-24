#include "power_of_troy.h"

namespace troy
{
    void give_new_artifact(human &owner, std::string artifact_name)
    {
        owner.possession = std::make_unique<artifact>(artifact_name);
    }

    void exchange_artifacts(std::unique_ptr<artifact> &possessionA,
                            std::unique_ptr<artifact> &possessionB)
    {
        possessionA.swap(possessionB);
    }

    void manifest_power(human &owner, std::string power_name)
    {
        owner.own_power = std::make_unique<power>(power_name);
    }

    void use_power(human &user, human &target) {
        target.influenced_by = user.own_power;
    }

    int power_intensity(human &user) {
        return user.own_power.use_count();
    }
} // namespace troy
