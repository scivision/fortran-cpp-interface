#include <stdio.h>
#include <stdlib.h>

#include "myadd.h"

int main(void) {

  if(addone(2) != 3) {
    fprintf(stderr, "2 + 1 != %d", addone(2));
    return EXIT_FAILURE;
  }

  printf("OK: C main Fortran lib\n");
  return EXIT_SUCCESS;
}
