#include <iostream>

extern "C" bool logical_not_cpp(bool a)
{

  std::cout << "c++ input boolean: " << a << "\n";

  return !a;

}
