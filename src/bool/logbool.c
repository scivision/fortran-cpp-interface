#include <stdio.h>

#if __STDC_VERSION__ < 202311L
#include <stdbool.h>
#endif

#include "my_bool.h"

bool logical_not(bool a)
{
  printf("C boolean sizeof(%d) = %zu\n", a, sizeof(a));

  return !a;
}

bool bool_true(){ return true; }
bool bool_false(){ return false; }
