#include <stdio.h>
#include <stdlib.h>

#include "my_vector.h"

int main()
{
  size_t N = 3;

  int* x = malloc(N*sizeof(int));
  int* x2 = malloc(N*sizeof(int));

  for (size_t i=0; i < N; i++){
    x[i] = i+1;
  }

  timestwo_f(&x[0], &x2[0], &N);

  for (size_t i=0; i < N; i++){
    if (x2[i] != 2*x[i]){
      fprintf(stderr, "value %d != %d\n", x2[i], x[i]);
      return EXIT_FAILURE;
    }
  }

  free(x);
  free(x2);

  printf("OK: C malloc new\n");

  return EXIT_SUCCESS;
}
