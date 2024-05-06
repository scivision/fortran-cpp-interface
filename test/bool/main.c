#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "my_bool.h"

int main(void){

bool b = logical_not(true);
int c = 0;

if(b) {
  fprintf(stderr, "logical_not(true) should be false: %d\n", b);
  c++;
}

b = logical_not(false);

if (!b) {
  fprintf(stderr, "logical_not(false) should be true: %d\n", b);
  c++;
}

if(c) {
  fprintf(stderr, "ERROR: C boolean-logical not\n");
  return EXIT_FAILURE;
}

printf("OK: boolean-logical not\n");
return EXIT_SUCCESS;
}
