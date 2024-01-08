#include <iostream>
#include <cstdlib>
#include <exception>

#include "my_bool.h"

int main(){

if(logical_not(true))
  throw std::runtime_error("logical_not(true) failed");

if (!logical_not(false))
  throw std::runtime_error("logical_not(false) failed");

std::cout << "OK: boolean-logical not\n";
return EXIT_SUCCESS;
}
