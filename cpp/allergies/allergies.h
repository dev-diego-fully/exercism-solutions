#if !defined(ALLERGIES_H)
#define ALLERGIES_H

#include <string>
#include <unordered_set>
#include <vector>

namespace allergies {

class AllergyProfile {
private:
  unsigned int allergies_value;

public:
  AllergyProfile(const unsigned int allergies_value);

  bool is_allergic_to(std::string element) const;
  std::unordered_set<std::string> get_allergies() const;
};

AllergyProfile allergy_test(const unsigned int allergies_value);

} // namespace allergies

#endif // ALLERGIES_H