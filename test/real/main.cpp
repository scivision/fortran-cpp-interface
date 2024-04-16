#include <iostream>

#include "mynan.h"


int main() {
  bool b, c;
  double d = 0.0;
  double n;

  n = d/d;

  b = is_nan(&n);
  c = is_ieee_nan(&n);

  std::cout << "is_nan(d/d) = " << b << "\n";
  std::cout << "is_ieee_nan(d/d) = " << c << "\n";

  if(!b || !c) return EXIT_FAILURE;

  return EXIT_SUCCESS;
}
