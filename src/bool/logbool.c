#include <stdio.h>
#include <stdbool.h>

#include "my_bool.h"

bool logical_not(bool a)
{
  printf("c++ input boolean: %d  size %zu\n", a, sizeof(a));

  return !a;
}

bool bool_true(){ return true; }
bool bool_false(){ return false; }
