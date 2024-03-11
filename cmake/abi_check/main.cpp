#include <iostream>
#include <cstdlib>

#include "myadd.h"

int main() {

  int i = addone(2);

  if(i != 3) {
    std::cerr << "2 + 1 != " << i << "\n";
    return EXIT_FAILURE;
  }

  std::cout << "OK: C++ main Fortran lib\n";
  return EXIT_SUCCESS;
}
