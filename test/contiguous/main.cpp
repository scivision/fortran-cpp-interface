#include <cstdlib>
#include <iostream>

#include "contiguous.h"

int main(){

size_t dims[1] = {3};

float* a = new float[3]{1,2,3};

asub(&a[0], dims);

std::cout << "OK: C++ contiguous array" << std::endl;

delete [] a;

return EXIT_SUCCESS;
}
