#include "complex_numbers.h"

complex_t c_add(complex_t a, complex_t b) {
  return (complex_t){.real = a.real + b.real, .imag = a.imag + b.imag};
}

complex_t c_sub(complex_t a, complex_t b) {
  return (complex_t){.real = a.real - b.real, .imag = a.imag - b.imag};
}

complex_t c_mul(complex_t a, complex_t b) {
  const double real_part = a.real * b.real - a.imag * b.imag;
  const double imag_part = a.imag * b.real + a.real * b.imag;
  return (complex_t){.real = real_part, .imag = imag_part};
}

complex_t c_div(complex_t a, complex_t b) {
  const double divisor = pow(b.real, 2) + pow(b.imag, 2);
  const double real_part = (a.real * b.real + a.imag * b.imag) / divisor;
  const double imag_part = (a.imag * b.real - a.real * b.imag) / divisor;
  return (complex_t){.real = real_part, .imag = imag_part};
}

double c_abs(complex_t x) {
  const double real_distance = pow(x.real, 2);
  const double imag_distance = pow(x.imag, 2);
  return sqrt(real_distance + imag_distance);
}

complex_t c_conjugate(complex_t x) {
  return (complex_t){.real = x.real, .imag = -x.imag};
}

double c_real(complex_t x) { return x.real; }

double c_imag(complex_t x) { return x.imag; }

complex_t c_exp(complex_t x) {
  complex_t a = {.real = exp(x.real), 0};
  complex_t b = {.real = cos(x.imag), .imag = sin(x.imag)};
  return c_mul(a, b);
}
