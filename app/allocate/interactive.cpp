#include <iostream>
#include <cstring>
#include <cstdlib>

#include "my_alloc.h"


int main(){

  size_t d1[1] = {1000000000};

  float *A1;


  falloc1(&A1, d1);
  std::cout << "1D: allocated" << std::endl;

  std::cout << "press enter to deallocate 1D" << std::endl;
  std::cin.get();

  fdealloc1(&A1);
  std::cout << "1D: deallocated" << std::endl;

  std::cout << "press enter to continue" << std::endl;
  std::cin.get();

  std::cout << "OK: fancy allocate test" << std::endl;

  return EXIT_SUCCESS;
}
