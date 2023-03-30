#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "my_bool.h"

int main(void){

if (!logical_not(false)) {
  fprintf(stderr, "expected Fortran to not boolean");
  return EXIT_FAILURE;
}

printf("OK: boolean-logical not\n");
return EXIT_SUCCESS;
}
