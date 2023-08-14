#include <iostream>
#include <cstdlib>

#include "my_bool.h"

int main(){

if (!logical_not(false)) {
  std::cerr << "expected Fortran to not boolean\n";
  return EXIT_FAILURE;
}

std::cout << "OK: boolean-logical not\n";
return EXIT_SUCCESS;
}
