#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "my_bool.h"

int main(void){

if(logical_not(true)) {
  fprintf(stderr, "logical_not(true) should be false");
  return EXIT_FAILURE;
}

if (!logical_not(false)) {
  fprintf(stderr, "logical_not(false) should be true)");
  return EXIT_FAILURE;
}

printf("OK: boolean-logical not\n");
return EXIT_SUCCESS;
}
