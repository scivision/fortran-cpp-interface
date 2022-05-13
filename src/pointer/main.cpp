#include <iostream>

extern "C" void point23(float [], float [], size_t*);


int main()
{
  size_t N = 3;
  auto a = new float[N]{0, 1, 2};
  auto b = new float[N-1];

  point23(&a[0], &b[0], &N);

  if (b[0] != a[1] || b[1] != a[2]){
    std::cerr << "value " <<  b[0] << "!=" << a[1] << " or " << b[1] << "!=" << a[2] << std::endl;
    return EXIT_FAILURE;
  }

  delete[] a;
  delete[] b;

  std::cout << "OK: C++ to Fortran pointer" << std::endl;
  return EXIT_SUCCESS;
}
