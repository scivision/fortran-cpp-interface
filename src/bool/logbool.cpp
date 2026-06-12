#include <iostream>
#include <cstdlib> // for std::exit()

#include "my_bool.h"

bool logical_not(const bool a, int* dummy)
{
  std::cout << "C++ boolean sizeof(" << a << ") = " << sizeof(a) << "\n";
  if (*dummy != 42) {
    std::cerr << "ERROR: dummy argument != 42, but " << *dummy << "\n";
    std::exit(EXIT_FAILURE);
  }

  return !a;
}

bool bool_passthru(const bool a, int* dummy)
{
  std::cout << "C++ boolean sizeof(" << a << ") = " << sizeof(a) << "\n";
  if (*dummy != 42) {
    std::cerr << "ERROR: dummy argument != 42, but " << *dummy << "\n";
    std::exit(EXIT_FAILURE);
  }

  return a;
}

bool bool_true(){ return true; }
bool bool_false(){ return false; }
