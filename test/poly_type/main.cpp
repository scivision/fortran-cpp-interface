#include <iostream>
#include <cstdlib>

extern "C" void init_type(int*, void**);
extern "C" void add_one_C(int*, void**, int*, int*);
extern "C" void dealloc_type(int*, void**);


int main(){

  void* x3;
  void* x4;
  int xtype=3;
  int A, C;

  xtype = 3;
  init_type(&xtype, &x3);

  add_one_C(&xtype, &x3, &A, &C);
  if(A != 4) {
    std::cerr << "Error: " << A << " != 4" << std::endl;
    return EXIT_FAILURE;
  }
  std::cout << "C:3 = " << C << std::endl;
  add_one_C(&xtype, &x3, &A, &C);
  std::cout << "C:3 = " << C << std::endl;
  add_one_C(&xtype, &x3, &A, &C);
  std::cout << "C:3 = " << C << std::endl;

  xtype = 4;
  init_type(&xtype, &x4);

  add_one_C(&xtype, &x4, &A, &C);
  if(A != 5) {
    std::cerr << "Error: " << A << " != 5" << std::endl;
    return EXIT_FAILURE;
  }
  std::cout << "C:4 = " << C << std::endl;
  add_one_C(&xtype, &x4, &A, &C);
  std::cout << "C:4 = " << C << std::endl;
  add_one_C(&xtype, &x4, &A, &C);
  std::cout << "C:4 = " << C << std::endl;

  dealloc_type(&xtype, &x3);
  std::cout << "three deallocated" << std::endl;
  dealloc_type(&xtype, &x4);
  std::cout << "four deallocated" << std::endl;

  std::cout << "OK: C++ poly_type" << std::endl;

  return EXIT_SUCCESS;
}
