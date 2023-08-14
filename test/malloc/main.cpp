#include <iostream>
#include <memory>
#include <cstdlib>

#include "my_vector.h"


int main()
{
  std::size_t N = 3;

  auto x = std::make_unique<int[]>(N);
  auto x2 = std::make_unique<int[]>(N);

  for (size_t i = 0; i < 3; ++i)
    x.get()[i] = i+1;

  timestwo_f(&x.get()[0], &x2.get()[0], &N);

  for (auto i=0u; i < N; i++){
    if (x2.get()[i] != 2*x.get()[i]){
      std::cerr << "value " <<  x2.get()[i] << "!=" << x.get()[i] << std::endl;
      return EXIT_FAILURE;
    }
  }

  std::cout << "OK: C++ malloc new" << std::endl;

  return EXIT_SUCCESS;
}
