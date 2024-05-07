#include <iostream>
#include <vector>
#include <cstdlib>

#include "my_vector.h"


int main()
{
  constexpr size_t N = 3;

  std::vector<int> x(N);
  std::vector<int> x2(N);

  for (size_t i = 0; i < N; ++i)
    x[i] = i+1;

  timestwo_f(&x[0], &x2[0], N);

  for (auto i=0u; i < N; i++){
    if (x2[i] != 2 * x[i]){
      std::cerr << "value " <<  x2[i] << "!=" << x[i] << std::endl;
      return EXIT_FAILURE;
    }
  }

  std::cout << "OK: C++ std::vector pre-allocated\n";

  return EXIT_SUCCESS;
}
