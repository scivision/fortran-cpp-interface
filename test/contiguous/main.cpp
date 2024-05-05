// std::vector is contiguous since C++17
// https://en.cppreference.com/w/cpp/named_req/ContiguousContainer
// https://en.cppreference.com/w/cpp/container/vector

#include <cstdlib>
#include <vector>
#include <iostream>

#include "contiguous.h"

int main(){

size_t dims[1] = {3};

std::vector<float> a(3);

for (size_t i = 0; i < 3; ++i)
  a[i] = i+1;

asub(&a[0], dims);

std::cout << "OK: C++ contiguous array\n";

return EXIT_SUCCESS;
}
