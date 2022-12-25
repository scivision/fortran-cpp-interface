#include <iostream>
#include <cstring>

extern "C" void alloc1(float**, size_t*);
extern "C" void dealloc1(float**);

int main(){

  size_t d1[1] = {1};

  float *A1;

  alloc1(&A1, d1);
  std::cout << "1D: allocated" << std::endl;

  dealloc1(&A1);
  std::cout << "1D: deallocated" << std::endl;

  std::cout << "OK: fancy allocate test" << std::endl;

  return EXIT_SUCCESS;
}
