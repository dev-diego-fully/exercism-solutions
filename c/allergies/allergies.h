#ifndef ALLERGIES_H
#define ALLERGIES_H

#include <math.h>
#include <stdbool.h>

typedef enum {
  ALLERGEN_EGGS = 0,
  ALLERGEN_PEANUTS,
  ALLERGEN_SHELLFISH,
  ALLERGEN_STRAWBERRIES,
  ALLERGEN_TOMATOES,
  ALLERGEN_CHOCOLATE,
  ALLERGEN_POLLEN,
  ALLERGEN_CATS,
  ALLERGEN_COUNT,
} allergen_t;

typedef struct {
  int count;
  bool allergens[ALLERGEN_COUNT];
} allergen_list_t;

bool is_allergic_to(allergen_t allergen, unsigned short allergies_number);
allergen_list_t get_allergens(unsigned short allergies_number);

#endif