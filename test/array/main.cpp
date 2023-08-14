#include <iostream>
#include <cstdlib>
#include <array>

#include "my_vector.h"

int main()
{
  const std::size_t Nc = 3;
  std::size_t N = Nc;

  std::array<int, Nc> x = {0, 1, 2};
  std::array<int, Nc> x2;

  timestwo_f(&x.front(), &x2.front(), &N);

  for (auto i=0u; i < x2.size(); i++){
    if (x2[i] != 2*x[i]){
      std::cerr << "value " <<  x2[i] << "!=" << x[i] << std::endl;
      return EXIT_FAILURE;
    }
  }

  std::cout << "OK: array\n";

  return EXIT_SUCCESS;
}
