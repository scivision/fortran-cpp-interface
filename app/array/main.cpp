#include <iostream>
#include <cstdlib>
#include <array>

extern "C" void timestwo(int [], int [], const size_t*);


int main()
{
  const size_t N = 3;

  std::array<int, N> x = {0, 1, 2};
  std::array<int, N> x2;

  timestwo(&x.front(), &x2.front(), &N);

  for (auto i=0u; i < x2.size(); i++){
    if (x2[i] != 2*x[i]){
      std::cerr << "value " <<  x2[i] << "!=" << x[i] << std::endl;
      return EXIT_FAILURE;
    }
  }

  std::cout << "OK: array" << std::endl;

  return EXIT_SUCCESS;
}
