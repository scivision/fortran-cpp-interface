#include <stdio.h>
#include <stdlib.h>

#include "my_poly_type.h"

int main(){

  void* x3;
  void* x4;
  int xtype=3;
  int A, C;

  xtype = 3;
  init_type(&xtype, &x3);

  add_one_C(&xtype, &x3, &A, &C);
  if(A != 4) {
    fprintf(stderr, "Error: %d != 4\n", A);
    return EXIT_FAILURE;
  }
  printf("C:3 = %d\n", C);
  add_one_C(&xtype, &x3, &A, &C);
  printf("C:3 = %d\n", C);
  add_one_C(&xtype, &x3, &A, &C);
  printf("C:3 = %d\n", C);

  xtype = 4;
  init_type(&xtype, &x4);

  add_one_C(&xtype, &x4, &A, &C);
  if(A != 5) {
    fprintf(stderr, "Error: %d != 5\n", A);
    return EXIT_FAILURE;
  }
  printf("C:4 = %d\n", C);
  add_one_C(&xtype, &x4, &A, &C);
  printf("C:4 = %d\n", C);
  add_one_C(&xtype, &x4, &A, &C);
  printf("C:4 = %d\n", C);

  dealloc_type(&xtype, &x3);
  printf("three deallocated\n");
  dealloc_type(&xtype, &x4);
  printf("four deallocated\n");

  printf("OK: C poly_type\n");

  return EXIT_SUCCESS;
}
