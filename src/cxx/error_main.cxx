// Example of Fortran erroring with C++ main

extern "C" void error_fortran(int*);

int main() {
  int code = 42;
  error_fortran(&code);
  return 0;
}
