// passing a Fortran-only type to/from C where only Fortran operates on opaque type
#include <stdio.h>

extern void init_opaque_C(void**);

extern void use_opaque_C(void**);

int main(){

  void* myf;

  init_opaque_C(&myf);

  use_opaque_C(&myf);

  printf("OK: opaque\n");

  return 0;
}
