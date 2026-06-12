#include <stdio.h>
#include <stdlib.h> // for exit()

#if __STDC_VERSION__ < 202311L
#include <stdbool.h>
#endif

#include "my_bool.h"

bool logical_not(bool a, int* dummy)
{
  printf("C boolean sizeof(%d) = %zu\n", a, sizeof(a));
  if (*dummy != 42) {
    fprintf(stderr, "ERROR: dummy argument != 42, but %d\n", *dummy);
    exit(EXIT_FAILURE);
  }

  return !a;
}

bool bool_passthru(bool a, int* dummy)
{
  printf("C boolean sizeof(%d) = %zu\n", a, sizeof(a));
  if (*dummy != 42) {
    fprintf(stderr, "ERROR: dummy argument != 42, but %d\n", *dummy);
    exit(EXIT_FAILURE);
  }

  return a;
}

bool bool_true(){ return true; }
bool bool_false(){ return false; }
