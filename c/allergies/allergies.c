#include "allergies.h"

bool is_allergic_to(allergen_t allergen, unsigned short allergies_number) {
  if (allergen >= ALLERGEN_COUNT) {
    return false;
  }
  return (short)(pow(2, allergen)) & allergies_number;
}

allergen_list_t get_allergens(unsigned short allergies_number) {
  allergen_list_t list = {.allergens = {false}};
  for (int allergen = 0; allergen <= ALLERGEN_COUNT; allergen++) {
    if (is_allergic_to(allergen, allergies_number)) {
      list.allergens[allergen] = true;
      list.count++;
    }
  }
  return list;
}