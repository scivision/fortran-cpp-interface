#include <iostream>
#include <cstring>

extern "C" void alloc1(float**, float**, size_t*);
extern "C" void dealloc1(float**, float**, size_t*);

int main(){

  size_t d1[1] = {1};

  float *A1, *B1;


  alloc1(&A1, &B1, d1);
  std::cout << "1D: A and B allocated" << std::endl;

  dealloc1(&A1, &B1, d1);
  std::cout << "1D: A and B deallocated" << std::endl;

  std::cout << "OK: allocate test" << std::endl;

  return EXIT_SUCCESS;
}
