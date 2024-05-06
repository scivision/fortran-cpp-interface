#include <iostream>

#include "my_bool.h"

bool logical_not(bool a)
{
  std::cout << "c++ input boolean: " << a << " size " << sizeof(a) << "\n";

  return !a;
}

bool bool_true(){ return true; }
bool bool_false(){ return false; }
