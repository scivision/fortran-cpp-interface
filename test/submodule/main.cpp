// main C++ program using a Fortran submodule

#include <iostream>
#include <cstdlib>

// #define _USE_MATH_DEFINES  // Windows oneAPI needs as compiler define
#include <cmath>

#include "my_submodule.h"

int main() {

  if (fabs(pi() - M_PI) > 1e-4) {
    std::cerr << "pi() unexpected value: " << pi() << std::endl;
    return EXIT_FAILURE;
  }

  std::cout << "OK: pi() value: " << pi() << std::endl;

  return EXIT_SUCCESS;

}
