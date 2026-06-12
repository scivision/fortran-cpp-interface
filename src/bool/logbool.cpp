#include <iostream>

#include "my_bool.h"

bool logical_not(const bool a)
{
  std::cout << "C++ boolean sizeof(" << a << ") = " << sizeof(a) << "\n";

  return !a;
}

bool bool_true(){ return true; }
bool bool_false(){ return false; }
