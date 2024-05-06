#include <iostream>
#include <cstdlib>
#include <exception>

#include "my_bool.h"

int main(){

bool b = logical_not(true);
int c = 0;

if(b){
  std::cerr << "logical_not(true) failed: " << b << "\n";
  c++;
}

b = logical_not(false);

if (!b){
  std::cerr << "logical_not(false) failed: " << b << "\n";
  c++;
}

if(c){
  std::cerr << "ERROR: C++ boolean-logical not\n";
  return EXIT_FAILURE;
}


std::cout << "OK: boolean-logical not\n";
return EXIT_SUCCESS;
}
