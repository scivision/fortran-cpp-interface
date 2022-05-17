#include <iostream>
#include <cstring>

extern "C" void alloc1(float**, size_t*);
extern "C" void dealloc1(float**);

int main(){

  size_t d1[1] = {100000000};

  float *A1;


  alloc1(&A1, d1);
  std::cout << "1D: allocated" << std::endl;

  std::cout << "press enter to deallocate 1D" << std::endl;
  std::cin.get();

  dealloc1(&A1);
  std::cout << "1D: deallocated" << std::endl;

  std::cout << "press enter to continue" << std::endl;
  std::cin.get();

  std::cout << "OK: fancy allocate test" << std::endl;

  return EXIT_SUCCESS;
}
