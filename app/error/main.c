// Example of Fortran erroring with C main
#include <stdlib.h>
#include <stdnoreturn.h>

#ifndef HAVE_UNREACHABLE
// https://en.cppreference.com/w/c/program/unreachable
#if defined(__GNUC__) || defined(__clang__)
  #define unreachable() __builtin_unreachable()
#elif defined(_MSC_VER)
  #define unreachable() __assume(0)
#else
  #define unreachable() ((void)0)
#endif
#endif

#include "my_error.h"

int main(void) {
  int code = 42;
  error_fortran(&code);

  unreachable();

  return EXIT_FAILURE;
}
