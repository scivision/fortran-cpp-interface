#include <iostream>
#include <cstring>

extern "C" void alloc1(float**, float**, size_t*);
extern "C" void alloc2(float**, float**, size_t*);
extern "C" void alloc3(float**, float**, size_t*);
extern "C" void alloc4(float**, float**, size_t*);

extern "C" void dealloc1(float**, float**, size_t*);
extern "C" void dealloc2(float**, float**, size_t*);
extern "C" void dealloc3(float**, float**, size_t*);
extern "C" void dealloc4(float**, float**, size_t*);

int main(){

  size_t d1[1] = {1};
  size_t d2[2] = {1,1};
  size_t d3[3] = {1,1,1};
  size_t d4[4] = {1,1,1,1};

  float *A1, *B1, *A2, *B2, *A3, *B3, *A4, *B4;


  alloc1(&A1, &B1, d1);
  std::cout << "1D: A and B allocated" << std::endl;

  dealloc1(&A1, &B1, d1);
  std::cout << "1D: A and B deallocated" << std::endl;

  alloc2(&A2, &B2, d2);
  std::cout << "2D: A and B allocated" << std::endl;

  dealloc2(&A2, &B2, d2);
  std::cout << "2D: A and B deallocated" << std::endl;

  alloc3(&A3, &B3, d3);
  std::cout << "3D: A and B allocated" << std::endl;

  dealloc3(&A3, &B3, d3);
  std::cout << "3D: A and B deallocated" << std::endl;

  alloc4(&A4, &B4, d4);
  std::cout << "4D: A and B allocated" << std::endl;

  dealloc4(&A4, &B4, d4);
  std::cout << "4D: A and B deallocated" << std::endl;

  std::cout << "OK: allocate test" << std::endl;

  return EXIT_SUCCESS;
}
