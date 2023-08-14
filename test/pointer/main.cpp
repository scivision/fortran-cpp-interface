#include <iostream>
#include <memory>
#include <cstdlib>

#include "my_pointer.h"


int main()
{
  size_t N = 3;
  auto a = std::make_unique<float[]>(N);
  auto b = std::make_unique<float[]>(N-1);

  for (size_t i = 0; i < 3; ++i)
    a.get()[i] = i+1;

  point23(&a.get()[0], &b.get()[0], &N);

  if (b.get()[0] != a.get()[1] || b.get()[1] != a.get()[2]){
    std::cerr << "value " <<  b.get()[0] << "!=" << a.get()[1] << " or " << b.get()[1] << "!=" << a.get()[2] << std::endl;
    return EXIT_FAILURE;
  }

  std::cout << "OK: C++ to Fortran pointer" << std::endl;
  return EXIT_SUCCESS;
}
