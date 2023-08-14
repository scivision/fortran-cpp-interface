// passing a Fortran-only type to/from C++ where only Fortran operates on opaque type
#include <iostream>
#include <cstdlib>

#include "my_opaque.h"


int main(){

  void* myf;

  init_opaque_C(&myf);

  use_opaque_C(&myf);

  destruct_C(&myf);

  std::cout << "OK: opaque\n";

  return EXIT_SUCCESS;
}
