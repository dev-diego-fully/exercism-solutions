#include "allergies.h"
#include <unordered_set>

namespace allergies {

const std::unordered_set<std::string> allergies = {
    "eggs",     "peanuts",    "shellfish", "strawberries",
    "tomatoes", "chocolate", "pollen",    "cats",
};

unsigned int allergy_value(const std::string allergy) {
  if (allergy == "eggs") {
    return 1;
  }
  if (allergy == "peanuts") {
    return 2;
  }
  if (allergy == "shellfish") {
    return 4;
  }
  if (allergy == "strawberries") {
    return 8;
  }
  if (allergy == "tomatoes") {
    return 16;
  }
  if (allergy == "chocolate") {
    return 32;
  }
  if (allergy == "pollen") {
    return 64;
  }
  if (allergy == "cats") {
    return 128;
  }
  return 0;
}

AllergyProfile::AllergyProfile(unsigned int allergies_value) {
    this->allergies_value = allergies_value;
}

bool AllergyProfile::is_allergic_to(std::string allergy) const {
  const unsigned int allergy_value = allergies::allergy_value(allergy);
  if (allergy_value == 0) {
    return false;
  }
  const unsigned int allergys = this->allergies_value & allergy_value;
  return (allergys) == allergy_value;
}

std::unordered_set<std::string> AllergyProfile::get_allergies() const {
  std::unordered_set<std::string> that_allergies;

  for (std::string allergy : allergies) {
    if (this->is_allergic_to(allergy)) {
      that_allergies.insert(allergy);
    }
  }

  return that_allergies;
}

AllergyProfile allergy_test(const unsigned int allergies_value) {
    return AllergyProfile{allergies_value};
}

} // namespace allergies
