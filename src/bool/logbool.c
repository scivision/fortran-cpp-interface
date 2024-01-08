#include <stdio.h>
#include <stdbool.h>

extern bool logical_not(bool a)
{

  printf("c++ input boolean: %d  size %zu\n", a, sizeof(a));

  return !a;

}
