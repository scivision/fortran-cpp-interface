#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

extern bool logical_not(bool);

int main(void){

if (!logical_not(false)) {
  fprintf(stderr, "expected Fortran to not boolean");
  return EXIT_FAILURE;
}

printf("OK: boolean-logical not\n");
return EXIT_SUCCESS;
}
