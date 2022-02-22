#include <stdbool.h>
#include <stdio.h>

extern bool logical_not(bool);

int main(void){

if (!logical_not(false)) {
  fprintf(stderr, "expected Fortran to not boolean");
  return 1;
}

printf("OK: boolean-logical not\n");
return 0;
}
