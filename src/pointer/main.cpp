#include <iostream>
#include <vector>

extern "C" void point23(float [], float [], size_t*);


int main()
{

  std::vector<float> a = {0, 1, 2};
  auto N = a.size();
  std::vector<float> b(2);

  point23(&a.front(), &b.front(), &N);

  if (b[0] != a[1] || b[1] != a[2]){
    std::cerr << "value " <<  b[0] << "!=" << a[1] << " or " << b[1] << "!=" << a[2] << std::endl;
    return EXIT_FAILURE;
  }

  std::cout << "OK: C++ to Fortran pointer" << std::endl;
  return EXIT_SUCCESS;
}
