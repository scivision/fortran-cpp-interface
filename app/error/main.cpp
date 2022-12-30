// Example of Fortran erroring with C++ main
#include <cstdlib>

#include "my_error.h"

int main() {
  int code = 42;
  error_fortran(&code);
  return EXIT_SUCCESS;
}
