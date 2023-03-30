#include <stdio.h>
#include <stdlib.h>

#include "my_alloc.h"


int main(void){

  size_t d1[1] = {1};
  size_t d2[2] = {1,1};
  size_t d3[3] = {1,1,1};
  size_t d4[4] = {1,1,1,1};

  float *A1, *B1, *A2, *B2, *A3, *B3, *A4, *B4;


  alloc1(&A1, &B1, d1);
  printf("1D: A and B allocated\n");

  dealloc1(&A1, &B1, d1);
  printf("1D: A and B deallocated\n");

  alloc2(&A2, &B2, d2);
  printf("2D: A and B allocated\n");

  dealloc2(&A2, &B2, d2);
  printf("2D: A and B deallocated\n");

  alloc3(&A3, &B3, d3);
  printf("3D: A and B allocated\n");

  dealloc3(&A3, &B3, d3);
  printf("3D: A and B deallocated\n");

  alloc4(&A4, &B4, d4);
  printf("4D: A and B allocated\n");

  dealloc4(&A4, &B4, d4);
  printf("4D: A and B deallocated\n");

  printf("OK: allocate test\n");

  return EXIT_SUCCESS;
}
