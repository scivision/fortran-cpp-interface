#include <cstdlib>
#include <memory>
#include <iostream>

#include "contiguous.h"

int main(){

size_t dims[1] = {3};

auto a = std::make_unique<float[]>(3);

for (size_t i = 0; i < 3; ++i)
  a.get()[i] = i+1;

asub(&a.get()[0], dims);

std::cout << "OK: C++ contiguous array\n";

return EXIT_SUCCESS;
}
