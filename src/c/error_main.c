// Example of Fortran erroring with C main
#include <stdlib.h>

extern void error_fortran(int*);

int main(void) {
  int code = 42;
  error_fortran(&code);
  return EXIT_SUCCESS;
}
