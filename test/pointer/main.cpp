#include <iostream>
#include <vector>
#include <cstdlib>

#include "my_pointer.h"


int main()
{
  size_t N = 3;
  std::vector<float> a(N);
  std::vector<float> b(N-1);

  for (size_t i = 0; i < 3; ++i)
    a[i] = i+1;

  point23(&a[0], &b[0], &N);

  if (b[0] != a[1] || b[1] != a[2]){
    std::cerr << "value " <<  b[0] << "!=" << a[1] << " or " << b[1] << "!=" << a[2] << std::endl;
    return EXIT_FAILURE;
  }

  std::cout << "OK: C++ to Fortran pointer\n";
  return EXIT_SUCCESS;
}
