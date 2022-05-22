#include <stddef.h>

extern void timestwo(int*, size_t*);

void timestwo(int* A, size_t* N)
{
  for (size_t i=0; i < *N; i++){
    A[i] = 2*A[i];
  }
}
