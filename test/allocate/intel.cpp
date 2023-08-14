#include <iostream>
#include <cstring>
#include <cstdlib>

#include "my_alloc.h"

int main(){

  size_t d1[1] = {1};

  float *A1;

  falloc1(&A1, d1);
  std::cout << "1D: allocated\n";

  fdealloc1(&A1);
  std::cout << "1D: deallocated\n";

  std::cout << "OK: fancy allocate test\n";

  return EXIT_SUCCESS;
}
