// returns a pointer to fortran
#include <iostream>
#include <cstring>

extern "C" char* get_null(char*);

char* get_null(char* c){
  if (std::strlen(c) == 0){
    std::cout << "C++ got empty string from Fortran\n";
    return nullptr;
  }
  else{
    std::cout << "C++ got non-empty string from Fortran\n";
    return c;
  }
}
