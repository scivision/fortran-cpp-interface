// main C program using a Fortran submodule

#include <stdio.h>
#include <stdlib.h>

#define _USE_MATH_DEFINES
#include <math.h>

extern float pi();

int main() {

  if (fabs(pi() - M_PI) > 1e-4) {
    fprintf(stderr, "pi() unexpected value: %f\n", pi());
    return EXIT_FAILURE;
  }

  printf("OK: pi() value: %f\n", pi());

  return EXIT_SUCCESS;

}
