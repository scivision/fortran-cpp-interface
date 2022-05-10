// passing a Fortran-only type to/from C++ where only Fortran operates on opaque type
#include <iostream>

extern "C" void init_opaque_C(void**);

extern "C" void use_opaque_C(void**);

int main(){

  void* myf;

  init_opaque_C(&myf);

  use_opaque_C(&myf);

  std::cout << "OK: opaque" << std::endl;

  return EXIT_SUCCESS;
}
