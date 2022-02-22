#include <iostream>

extern "C" bool logical_not(bool);

int main(){

if (!logical_not(false)) {
  std::cerr << "expected Fortran to not boolean" << std::endl;
  return EXIT_FAILURE;
}

std::cout << "OK: boolean-logical not" << std::endl;
return EXIT_SUCCESS;
}
