// C++ calling polymorphic Fortran object
// based on https://github.com/mattzett/fortran_tests
#include <array>
#include <iostream>
#include <cstdlib>

#include "my_polyfcn.h"


int main() {

 // pointers for various fortran data
void* objptr1;
void* objptr2;
int objtype;
float* arrptr;

const size_t lx1=2;
const size_t ly1=2;

// Object 1`
objtype=1;
std::array<float, lx1*ly1> x1;
x1 = {1, 2, 3, 4};
arrptr = &x1.front();
objconstruct_C(&objtype, &objptr1, &arrptr, &lx1, &ly1);
std::cout << "Use object 1" << std::endl;
objuse_C(&objtype, &objptr1);

// Object 2
objtype=2;
const size_t lx2=2;
const size_t ly2=3;
std::array<float, lx2*ly2> x2;
x2 = {6,5,4,3,2,1};
arrptr = &x2.front();
objconstruct_C(&objtype, &objptr2, &arrptr, &lx2, &ly2);
std::cout << "Use object 2" << std::endl;
objuse_C(&objtype,&objptr2);

// show that objects persist
std::cout << "Use object 1 again" << std::endl;
objtype=1;
objuse_C(&objtype, &objptr1);

std::cout << "Use object 2 again" << std::endl;
objtype=2;
objuse_C(&objtype, &objptr2);

destruct_C(&objtype, &objptr1);
destruct_C(&objtype, &objptr2);

return EXIT_SUCCESS;
}
