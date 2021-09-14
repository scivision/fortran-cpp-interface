// Example of Fortran erroring with C main

extern void error_fortran(int*);

int main(void) {
  int code = 42;
  error_fortran(&code);
  return 0;
}
