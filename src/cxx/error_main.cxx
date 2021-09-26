// Example of Fortran erroring with C++ main
#include <cstdlib>

extern "C" void error_fortran(int*);

int main() {
  int code = 42;
  error_fortran(&code);
  return EXIT_SUCCESS;
}
