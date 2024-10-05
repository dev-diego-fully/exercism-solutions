#include "triangle.h"

#define TRUE 1
#define FALSE 0

int is_valid_triangle(triangle_t triangle);
int all_positive_sides(triangle_t triangle);
int satisfy_inequalities(triangle_t triangle);

int is_scalene(triangle_t triangle) {
  if (!is_valid_triangle(triangle)) {
    return FALSE;
  }
  const double a = triangle.a, b = triangle.b, c = triangle.c;
  return a != b && a != c && b != c;
}

int is_isosceles(triangle_t triangle) {
  if (!is_valid_triangle(triangle)) {
    return FALSE;
  }
  const double a = triangle.a, b = triangle.b, c = triangle.c;
  return a == b || a == c || b == c;
}

int is_equilateral(triangle_t triangle) {
  if (!is_valid_triangle(triangle)) {
    return FALSE;
  }
  const double a = triangle.a, b = triangle.b, c = triangle.c;
  return a == b && b == c;
}

int is_valid_triangle(triangle_t triangle) {
  return all_positive_sides(triangle) && satisfy_inequalities(triangle);
}

int all_positive_sides(triangle_t triangle) {
  return triangle.a > 0 && triangle.b > 0 && triangle.c > 0;
}

int satisfy_inequalities(triangle_t triangle) {
  const double a = triangle.a, b = triangle.b, c = triangle.c;
  return a + b >= c && a + c >= b && b + c >= a;
}