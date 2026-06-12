#include <stdio.h>
#include <stdlib.h> // for exit()

#if __STDC_VERSION__ < 202311L
#include <stdbool.h>
#endif

#include "my_bool.h"

bool logical_not(bool_args args)
{
  printf("C boolean sizeof(%d) = %zu\n", args.value, sizeof(args.value));
  if (args.dummy != 42) {
    fprintf(stderr, "ERROR: dummy argument != 42, but %d\n", args.dummy);
    exit(EXIT_FAILURE);
  }

  return !args.value;
}

bool bool_passthru(bool_args args)
{
  printf("C boolean sizeof(%d) = %zu\n", args.value, sizeof(args.value));
  if (args.dummy != 42) {
    fprintf(stderr, "ERROR: dummy argument != 42, but %d\n", args.dummy);
    exit(EXIT_FAILURE);
  }

  return args.value;
}

bool bool_true(){ return true; }
bool bool_false(){ return false; }
