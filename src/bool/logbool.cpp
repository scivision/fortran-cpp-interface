#include <iostream>

extern "C" bool logical_not(bool a)
{

  std::cout << "c++ input boolean: " << a << "\n";

  return !a;

}
