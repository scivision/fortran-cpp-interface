#include <iostream>

extern "C" bool logical_not(bool a)
{

  std::cout << "c++ input boolean: " << a << " size " << sizeof(a) << "\n";

  return !a;

}
