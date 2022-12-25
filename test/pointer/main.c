#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "my_pointer.h"


int main(void)
{

  size_t N = 3;
  size_t M = 2;

  float* a = malloc(N * sizeof(float));
  float* b = malloc(M * sizeof(float));

  memcpy(a, (float[]){0, 1, 2}, N * sizeof(float));

  point23(&a[0], &b[0], &N);

  if (b[0] != a[1] || b[1] != a[2]){
    fprintf(stderr, "value %f != %f or %f != %f\n", b[0], a[1], b[1], a[2]);
    return 1;
  }

  free(a);
  free(b);

  printf("OK: C to Fortran pointer\n");
  return 0;
}
