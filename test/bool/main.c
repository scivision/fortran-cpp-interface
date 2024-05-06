#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "my_bool.h"

int main(void){

bool b;
int c = 0;

b = bool_true();
if(!b){
  fprintf(stderr, "bool_true() failed: %d\n", b);
  c++;
}

b = bool_false();
if(b){
  fprintf(stderr, "bool_false() failed: %d\n", b);
  c++;
}

b = logical_not(true);
if(b) {
  fprintf(stderr, "logical_not(true) should be false: %d\n", b);
  c++;
}

b = logical_not(false);
if (!b) {
  fprintf(stderr, "logical_not(false) should be true: %d\n", b);
  c++;
}

if(c) {
  fprintf(stderr, "ERROR: C boolean-logical not\n");
  return EXIT_FAILURE;
}

printf("OK: boolean-logical not\n");
return EXIT_SUCCESS;
}
