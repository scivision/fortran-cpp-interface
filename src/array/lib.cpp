#include <cstddef>

extern "C" void timestwo(int*, size_t*);

void timestwo(int* A, size_t* N)
{
  for (auto i=0u; i < *N; i++){
    A[i] = 2*A[i];
  }
}
