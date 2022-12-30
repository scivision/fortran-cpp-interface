#include <cstddef>

extern "C" void timestwo_cpp(int* A, size_t* N)
{
  for (auto i=0u; i < *N; i++){
    A[i] = 2*A[i];
  }
}
