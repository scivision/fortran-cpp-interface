#include <stdio.h>
#include <stdlib.h>

#if __STDC_VERSION__ < 202311L
#include <stdbool.h>
#endif

#include "mynan.h"


int main(void) {
  bool b, c;
  double d = 0.0;
  double n;

  n = d/d;

  b = is_nan(&n);
  c = is_ieee_nan(&n);

  printf("is_nan(d/d) = %d\n", b);
  printf("is_ieee_nan(d/d) = %d\n", c);

  if (!b || !c) return EXIT_FAILURE;

  return EXIT_SUCCESS;
}
