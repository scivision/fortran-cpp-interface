#include <stddef.h>

void timestwo_c(int*, size_t*);

void timestwo_c(int* A, size_t* N)
{
  for (size_t i=0; i < *N; i++){
    A[i] = 2*A[i];
  }
}
