#include <iostream>
#include <cstdlib>
#include <exception>

#include "my_bool.h"

int main(){

int c = 0;
bool b;

b = bool_true();
if(!b){
  std::cerr << "bool_true() failed: " << b << "\n";
  c++;
}

b = bool_false();
if(b){
  std::cerr << "bool_false() failed: " << b << "\n";
  c++;
}

bool_args args{true, 42};

b = logical_not(args);

if(b){
  std::cerr << "logical_not(true) failed: " << b << "\n";
  c++;
}

args.value = false;
b = logical_not(args);

if (!b){
  std::cerr << "logical_not(false) failed: " << b << "\n";
  c++;
}

b = bool_passthru(args);
if(b){
  std::cerr << "bool_passthru(false) failed: " << b << "\n";
  c++;
}

args.value = true;
b = bool_passthru(args);
if(!b){
  std::cerr << "bool_passthru(true) failed: " << b << "\n";
  c++;
}

if(c){
  std::cerr << "ERROR: C++ boolean-logical not\n";
  return EXIT_FAILURE;
}


std::cout << "OK: boolean-logical not\n";
return EXIT_SUCCESS;
}
