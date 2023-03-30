#include <iostream>
#include <cstring>
#include <cstdlib>

#include "my_alloc.h"

int main(){

  size_t d1[1] = {1};

  float *A1;

  falloc1(&A1, d1);
  std::cout << "1D: allocated" << std::endl;

  fdealloc1(&A1);
  std::cout << "1D: deallocated" << std::endl;

  std::cout << "OK: fancy allocate test" << std::endl;

  return EXIT_SUCCESS;
}
