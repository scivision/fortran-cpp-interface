#include <stddef.h>

void timestwo_c(int x[], int x2[], size_t N){
  for (size_t i=0; i<N; i++)
    x2[i] = x[i] * 2;
}
