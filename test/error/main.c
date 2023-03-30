// Example of Fortran erroring with C main
#include <stdlib.h>

#include "my_error.h"

int main(void) {
  int code = 42;
  error_fortran(&code);
  return EXIT_SUCCESS;
}
