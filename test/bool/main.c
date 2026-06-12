#if __STDC_VERSION__ < 202311L
#include <stdbool.h>
#endif

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

bool_args args = { true, 42 };

b = logical_not(args);
if(b) {
  fprintf(stderr, "logical_not(true) should be false: %d\n", b);
  c++;
}

args.value = false;
b = logical_not(args);
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
