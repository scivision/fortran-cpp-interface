// Example of Fortran erroring and exception handling with C++ main
#include <cstdlib>
#include <exception>
#include <iostream>

#include "my_error.h"

int main() {

int code = 42;

try{
  error_fortran(&code);
} catch (const std::exception& e) {
  std::cerr << "Caught exception: " << e.what() << std::endl;
}

return EXIT_SUCCESS; // This will never be reached
}
