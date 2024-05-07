#include <iostream>
#include <cstring>
#include <cstdlib>
#include <vector>

#include "my_alloc.h"


int main(){

  std::vector<size_t> d1 = {1000000000};

  float *A1;


  falloc1(&A1, &d1.front());
  std::cout << "1D: allocated\n";

  std::cout << "press enter to deallocate 1D\n";
  std::cin.get();

  fdealloc1(&A1);
  std::cout << "1D: deallocated\n";

  std::cout << "press enter to continue\n";
  std::cin.get();

  std::cout << "OK: fancy allocate test\n";

  return EXIT_SUCCESS;
}
