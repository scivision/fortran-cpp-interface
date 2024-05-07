#include <stddef.h>

#include "my_vector.h"

void timestwo_c(const int x[], int x2[], const size_t N){
  for (size_t i=0; i<N; i++)
    x2[i] = x[i] * 2;
}
