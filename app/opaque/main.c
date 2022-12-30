// passing a Fortran-only type to/from C where only Fortran operates on opaque type
#include <stdio.h>
#include <stdlib.h>
#include "my_opaque.h"

int main(){

  void* myf;

  init_opaque_C(&myf);

  use_opaque_C(&myf);

  destruct_C(&myf);

  printf("OK: opaque\n");

  return EXIT_SUCCESS;
}
